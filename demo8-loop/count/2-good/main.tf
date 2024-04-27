resource "local_file" "good" {
  count = 5
  filename = var.file_name[count.index]
  content = "nti" 
}
