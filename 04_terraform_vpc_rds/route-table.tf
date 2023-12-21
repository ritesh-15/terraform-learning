resource "aws_route_table" "TfRouteTablePublic" {
  vpc_id = aws_vpc.TfVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TfInternetGateway.id
  }


  tags = {
    Name = "RT Public: For public subnet"
  }
}

resource "aws_route_table" "TfRouteTablePrivate" {
  vpc_id = aws_vpc.TfVPC.id
  depends_on = [ aws_nat_gateway.TfNatGateway ]

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.TfNatGateway.id
  }


  tags = {
    Name = "RT Private: For Private subnet"
  }
}