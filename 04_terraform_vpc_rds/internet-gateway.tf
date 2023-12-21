resource "aws_internet_gateway" "TfInternetGateway" {
  vpc_id = aws_vpc.TfVPC.id

  tags = {
    Name = "IG: Terraform VPC"
  }
}