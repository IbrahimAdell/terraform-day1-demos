resource "local_file" "file" {
  for_each = var.file_name
  filename = each.value
  content = "nti"
}
