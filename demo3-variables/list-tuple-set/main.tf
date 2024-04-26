provider "aws" {
  profile = "default"
  region = "us-east-1"
}


resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "nti-VPC"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_blocks[0]
  availability_zone = var.subnet_availability_zones[0]
  tags = {
    Name = "${var.subnet_names[0]}"
  }
}


resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_blocks[1]
  availability_zone = var.subnet_availability_zones[1]
  tags = {
    Name = "${var.subnet_names[1]}"
  }
}


resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_blocks[2]
  availability_zone = var.subnet_availability_zones[2]
  tags = {
    Name = "${var.subnet_names[2]}"
  }
}


