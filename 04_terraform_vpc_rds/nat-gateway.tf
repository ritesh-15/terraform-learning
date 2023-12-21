resource "aws_eip" "TfNatIp" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "TfNatGateway" {
  allocation_id = aws_eip.TfNatIp.id
  subnet_id     = aws_subnet.TfPrivateSubnet.id
  depends_on = [aws_internet_gateway.TfInternetGateway, aws_eip.TfNatIp]

  tags = {
    Name = "NAT GW: Private Subnet NAT Gateway"
  }
}