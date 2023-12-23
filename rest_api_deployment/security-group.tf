resource "aws_security_group" "TfAllowSSHAndHTTP" {
  name        = "SG: Allow SSH and HTTP"
  description = "allow ssh and http access from anywhere"
  vpc_id      = aws_vpc.TfMyVPC.id
  depends_on = [ aws_vpc.TfMyVPC ]

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
     ipv6_cidr_blocks = []
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
     ipv6_cidr_blocks = []
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
     ipv6_cidr_blocks = []
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = []
  }

  tags = {
    Name = "SG: Allow SSH and HTTP"
  }
}

resource "aws_security_group" "TfAllowJenkins" {
  name        = "SG: Allow Jenkins PORT 8080"
  description = "Allow Jenkins PORT 8080"
  vpc_id      = aws_vpc.TfMyVPC.id
    depends_on = [ aws_vpc.TfMyVPC ]


    ingress {
    description      = "Allow 8080 access"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  tags = {
    Name = "SG: Allow Jenkins 8080"
  }
}