provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_vpc" "vpc-1" {
  cidr_block = var.vpc-1["cidr"]
  tags = {
    Name = var.vpc-1["name"]
  }
}


resource "aws_vpc" "vpc-2" {
  cidr_block = var.vpc-2.cidr
  tags = {
    Name = var.vpc-2.name
  }
}
