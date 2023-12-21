resource "aws_instance" "tf-ec2" {
  ami           = "ami-0287a05f0ef0e9d9a"
  instance_type = "t2.micro"
  subnet_id = "subnet-0d9cd1b177baf4eec"
  security_groups = [aws_security_group.tf_sg.id]
  user_data = file("script.sh")


  tags = {
    Name = "tf-ec2"
  }
}

resource "aws_security_group" "tf_sg" {
  name        = "security group using terraform"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-0b2b468ee4bfd1043"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tf_sg"
  }
}