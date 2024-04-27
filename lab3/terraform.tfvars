# providers values 
profile = "test"
region  = "us-east-1"

# VPC values 
vpc_cidr = "10.0.0.0/16"
name     = "sprints-vpc"

# subnets values 
subnets = {
  "public-subnet" = {
    cidr_block = "10.0.0.0/24"
    name       = "public-subnet"
  },
  "private-subnet" = {
    cidr_block = "10.0.1.0/24"
    name       = "private-subnet"
  }
}

# Internet Gateway value
igw-name = "sprints-igw"

# NAT value
nat-name = "sprints-NAT"

# route-tables values 
rt-cide         = "0.0.0.0/0"
public-rt-name  = "sprints-public-rt"
private-rt-name = "sprints-private-rt"

# EC2 values
instances = {
  "public-ec2" = {
    instance_type      = "t2.micro"
    subnet             = "public-subnet"
    is_public          = true
    associate_publicIP = true
    name               = "sprints_public_ec2"
  },
  "private-ec2" = {
    instance_type      = "t2.micro"
    subnet             = "private-subnet"
    is_public          = false
    associate_publicIP = true
    name               = "sprints_private_ec2"
  }
}

# security group values 
sg_name = "sprints_sg"
sg_cidr = ["0.0.0.0/0"]
