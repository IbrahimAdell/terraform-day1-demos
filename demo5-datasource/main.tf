provider "aws" {
  profile = "default"
  region = "us-east-1"
}

data "aws_vpc" "default_vpc" {
  default = true
}


resource "aws_subnet" "subnet" {
  vpc_id                  = data.aws_vpc.default_vpc.id
  cidr_block              = "172.31.64.0/18"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "NTI-subnet"
  }
}
