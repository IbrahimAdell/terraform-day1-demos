variable "vpc-1" {
  description = "vpc name and cidr block"
  type        = map
  default = {
    name = "test-vpc"
    cidr = "10.0.1.0/16"
  }
}


variable "vpc-2" {
  description = "vpc name and cidr block"
  type        = object({
    name = string
    cidr = string
  })
  default = {
    name = "test-vpc"
    cidr = "10.0.1.0/16"
  }
}
