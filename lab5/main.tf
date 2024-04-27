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
 
resource "aws_subnet" "subnets" {
  count		   = length(var.cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr[count.index]					
  availability_zone       = var.az[count.index]					

  tags = {
    Name = "NTI-subnet-${count.index}"
  }
}


resource "aws_instance" "ec2_instances" {
  count			= length(var.ami)
  ami         		        = var.ami[count.index]			  
  instance_type 		= "t2.micro"
  associate_public_ip_address   = true
  subnet_id    		= aws_subnet.subnets[count.index].id
 
  tags = {
      Name = "NTI-ec2-${count.index}"
    }
}
