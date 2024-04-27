provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "NTI-VPC"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "NTI-subnet"
  }
}

resource "aws_instance" "ec2_instance" {
  ami         		        = "ami-080e1f13689e07408"
  instance_type 		= "t2.micro"
  associate_public_ip_address  = true
  subnet_id    		= aws_subnet.subnet.id
  tags = {
      Name = "NTI-ec2"
    }
    
  provisioner "local-exec"{
    command = "echo ${self.public_ip} >> ./ec2_public_ip.txt"
  }
  
}
