resource "local_file" "error" {
  count = 5
  filename = "nti"
  content = "nti" 
}
