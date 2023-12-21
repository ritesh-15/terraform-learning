terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# resource "aws_s3_bucket" "terraform-bucket" {
#   bucket = "my-terraform-bucket-1702958270959"


#   tags = {
#     Name        = "my-terraform-bucket"
#     Environment = "Dev"
#   }
# }

resource "aws_iam_user" "terraform-iam-user" {
  name = "terraform-iam-user-updated"
}