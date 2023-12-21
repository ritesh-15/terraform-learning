resource "aws_vpc" "TfVPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "VPC: tf-ap-south-1"
  }
}