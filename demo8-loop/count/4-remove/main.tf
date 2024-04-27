resource "local_file" "good" {
  count = length(var.file_name)
  filename = var.file_name[count.index]
  content = "nti" 
}
