provider "local" {}

resource "local_file" "file" {
  content  = "Terraform Day 1"
  filename = var.name
  file_permission = "0744"
}

variable "name" {
	description = "file name"
	type = string
}
