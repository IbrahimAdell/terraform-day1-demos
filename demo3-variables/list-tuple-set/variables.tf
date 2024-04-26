variable "subnet_cidr_blocks" {
  type    = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24"]
}

variable "subnet_availability_zones" {
  type    = tuple([string, string, string])
  default = (["us-west-1a", "us-west-1b", "us-west-1c"])
}

variable "subnet_names" {
  type    = set(string)
  default = ["test-1", "test-2", "test-3"]
}
