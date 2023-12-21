resource "aws_subnet" "TfPublicSubnet" {
  vpc_id     = aws_vpc.TfVPC.id
  cidr_block = var.vpc_public_subnet_cidr
  availability_zone = var.vpc_subnet_zone_ap_south_1a
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-Public: Public Subnet ${var.vpc_subnet_zone_ap_south_1a}"
  }
}

resource "aws_subnet" "TfPrivateSubnet" {
  vpc_id     = aws_vpc.TfVPC.id
  cidr_block = var.vpc_private_subnet_cidr
  availability_zone = var.vpc_subnet_zone_ap_south_1b

  tags = {
    Name = "Subnet-Private: Private Subnet ${var.vpc_subnet_zone_ap_south_1b}"
  }
}