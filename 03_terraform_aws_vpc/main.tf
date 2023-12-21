# create a vpc
resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
     Name = "tf_vpc"
  }
}

# create a subnets
resource "aws_subnet" "tf_vpc_public_subnet" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "TF VPC Public Subnet"
  }
}

resource "aws_subnet" "tf_vpc_private_subnet" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "TF VPC Private Subnet"
  }
}

# create internet gateway
resource "aws_internet_gateway" "tf_vpc_ig" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "TF VPC IGW"
  }
}

# route tables
resource "aws_route_table" "tf_vpc_public_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_vpc_ig.id
  }

  tags = {
    Name = "TF VPC Public RT"
  }
}

# Route table association
resource "aws_route_table_association" "tf_vpc_public_subnet_association" {
  subnet_id      = aws_subnet.tf_vpc_public_subnet.id
  route_table_id = aws_route_table.tf_vpc_public_rt.id
}

# create ec2 instance

resource "aws_instance" "TfVpcEC2Instance" {
    ami = "ami-03f4878755434977f"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.tf_vpc_public_subnet.id
    security_groups = [aws_security_group.TfAllowHTTPSG.id,aws_security_group.TfAllowSSHSG.id]

    key_name = "ec2-keypair"

    tags = {
      Name: "tf_vpc_ec2_instance"
    }
}

# create security group
resource "aws_security_group" "TfAllowSSHSG" {
  name        = "tf_sg_allow_ssh"
  description = "allow ssh access from anywhere"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
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
    Name = "tf_sg_allow_ssh"
  }
}

resource "aws_security_group" "TfAllowHTTPSG" {
      name        = "tf_sg_allow_http"
  description = "allow http access from anywhere"
  vpc_id      = aws_vpc.tf_vpc.id

    ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
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
    Name = "tf_sg_allow_http"
  }
}