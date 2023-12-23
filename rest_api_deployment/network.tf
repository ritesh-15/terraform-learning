# VPC
resource "aws_vpc" "TfMyVPC" {
  cidr_block       = var.VPC_CIDR
  instance_tenancy = "default"

  tags = {
    Name = "VPC: TF VPC"
  }
}

# Public Subnet
resource "aws_subnet" "TfPublicSubnet" {
  vpc_id     = aws_vpc.TfMyVPC.id
  cidr_block = var.vpc_public_subnet_cidr
  availability_zone = var.vpc_subnet_zone_ap_south_1a
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-Public: Public Subnet ${var.vpc_subnet_zone_ap_south_1a}"
  }
}

resource "aws_subnet" "TfPublicSubnet2" {
  vpc_id     = aws_vpc.TfMyVPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.vpc_subnet_zone_ap_south_1c
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-Public: Public Subnet ${var.vpc_subnet_zone_ap_south_1c}"
  }
}

# Private Subnet
resource "aws_subnet" "TfPrivateSubnet" {
  vpc_id     = aws_vpc.TfMyVPC.id
  cidr_block = var.vpc_private_subnet_cidr
  availability_zone = var.vpc_subnet_zone_ap_south_1b

  tags = {
    Name = "Subnet-Private: Private Subnet ${var.vpc_subnet_zone_ap_south_1b}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "TfInternetGateway" {
  vpc_id = aws_vpc.TfMyVPC.id

  tags = {
    Name = "IG: Terraform VPC"
  }
}

# Route Table
resource "aws_route_table" "TfRouteTablePublic" {
  vpc_id = aws_vpc.TfMyVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TfInternetGateway.id
  }


  tags = {
    Name = "RT Public: For public subnet"
  }
}

# Route Table Association
resource "aws_route_table_association" "TfRoutePublicAssociation" {
  subnet_id      = aws_subnet.TfPublicSubnet.id
  route_table_id = aws_route_table.TfRouteTablePublic.id
  depends_on = [ aws_subnet.TfPublicSubnet, aws_route_table.TfRouteTablePublic ]
}

# Private subnet route table
resource "aws_route_table" "TfRouteTablePrivate" {
  vpc_id = aws_vpc.TfMyVPC.id
#   depends_on = [ aws_nat_gateway.TfNatGateway ]

#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.TfNatGateway.id
#   }


  tags = {
    Name = "RT Private: For Private subnet"
  }
}

resource "aws_route_table_association" "TfRoutePrivateAssociation" {
  subnet_id      = aws_subnet.TfPrivateSubnet.id
  route_table_id = aws_route_table.TfRouteTablePrivate.id
  depends_on = [ aws_subnet.TfPrivateSubnet ,aws_route_table.TfRouteTablePrivate ]
}