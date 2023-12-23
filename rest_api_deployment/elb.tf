resource "aws_lb_target_group" "TfTargetGroup" {
  name     = "TG-elb-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.TfMyVPC.id

  health_check {
    path = "/login"
    port = 8080
    interval = 5
    matcher = "200"
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
  }
}

resource "aws_lb_target_group_attachment" "TfTargetGroupAttachment"{
  target_group_arn = aws_lb_target_group.TfTargetGroup.arn
  target_id        = aws_instance.web.id
  port             = 8080
}

resource "aws_lb" "TfELB" {
  name               = "ELB-Jenkins-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.TfAllowSSHAndHTTP.id]
  subnets            = [aws_subnet.TfPublicSubnet.id, aws_subnet.TfPublicSubnet2.id]


  enable_deletion_protection = true

  tags = {
    Name = "ELB Jenkins"
  }

  depends_on = [ aws_subnet.TfPublicSubnet2 ]
}


resource "aws_lb_listener" "TfELBListener80" {
  load_balancer_arn = aws_lb.TfELB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
     type             = "forward"
    target_group_arn = aws_lb_target_group.TfTargetGroup.arn
  }
}

data "aws_route53_zone" "DataAwsHostedZone" {
    name = "riteshdevops.tech"
    private_zone = false
}

resource "aws_route53_record" "TfHostedZoneARecord" {
    zone_id = data.aws_route53_zone.DataAwsHostedZone.zone_id
    name = "jenkins.riteshdevops.tech"
    type = "A"

    alias {
      name = aws_lb.TfELB.dns_name
      evaluate_target_health = true
      zone_id = aws_lb.TfELB.zone_id
    }
}

resource "aws_acm_certificate" "TfCertificateManager" {
  domain_name       = "jenkins.riteshdevops.tech"
  validation_method = "DNS"
  

  tags = {
    Environment = "production"
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.TfCertificateManager.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = aws_route53_record.TfHostedZoneARecord.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_lb_listener" "TfAwsLBHTTPSListener" {
  load_balancer_arn = aws_lb.TfELB.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = aws_acm_certificate.TfCertificateManager.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TfTargetGroup.arn
  }
}
