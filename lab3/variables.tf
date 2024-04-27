# providers variables 
variable "profile" { type = string }
variable "region" { type = string }

# VPC variables 
variable "vpc_cidr" { type = string }
variable "name" { type = string }

# subnts variables 
variable "subnets" {
  description = "public & private subnets info."
  type = map(object({
    cidr_block = string
    name       = string
  }))
}

# Internet Gateway variable
variable "igw-name" { type = string }

# NAT variable
variable "nat-name" { type = string }

# route-tables variables 
variable "rt-cide" { type = string }
variable "public-rt-name" { type = string }
variable "private-rt-name" { type = string }

# EC2 variables 
variable "instances" {
  description = "public & private instances info."
  type = map(object({
    instance_type      = string
    subnet             = string
    is_public          = bool
    associate_publicIP = bool
    name               = string

  }))
}

# security group variables 
variable "sg_name" { type = string }
variable "sg_cidr" {type = list(string)}
