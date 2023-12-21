resource "aws_security_group" "TfAllowSSHSG" {
  name        = "SG: Allow SSH"
  description = "allow ssh access from anywhere"
  vpc_id      = aws_vpc.TfVPC.id
  depends_on = [ aws_vpc.TfVPC ]

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
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
    Name = "SG: Allow SSH"
  }
}

resource "aws_security_group" "TfAllowHTTPSG" {
  name        = "SG: Allow HTTP"
  description = "allow http access from anywhere"
  vpc_id      = aws_vpc.TfVPC.id
    depends_on = [ aws_vpc.TfVPC ]


    ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
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
    Name = "SG: Allow HTTP"
  }
}