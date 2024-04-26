provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_vpc" "imported_vpc" {

}


resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.imported_vpc.id
  cidr_block              = "10.0.0.0/25"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "NTI-subnet"
  }
}
