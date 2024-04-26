provider "local" {}

resource "local_file" "file" {
  content  = "Terraform Day 1"
  filename = "NTI"
  file_permission = "0744"
}

