resource "local_file" "file" {
  for_each = toset(var.file_name)
  filename = each.value
  content = "nti"
}
