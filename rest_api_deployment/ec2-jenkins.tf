data "aws_subnet" "DataPublicSubnet" {
  filter {
    name   = "tag:Name"
    values = ["Subnet-Public: Public Subnet ${var.vpc_subnet_zone_ap_south_1a}"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-03f4878755434977f"
  instance_type = "t2.medium"
  key_name = "ec2-keypair"
  subnet_id = aws_subnet.TfPublicSubnet.id
  vpc_security_group_ids = [ aws_security_group.TfAllowSSHAndHTTP.id, aws_security_group.TfAllowJenkins.id]

  user_data = file("./jenkin-installer.sh")

  tags = {
    Name = "EC2: TF Public Subnet"
  }

  depends_on = [ aws_security_group.TfAllowSSHAndHTTP, aws_security_group.TfAllowJenkins ]
}