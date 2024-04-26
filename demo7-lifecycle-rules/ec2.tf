resource "aws_instance" "ec2_instance" {
  ami         		        = "ami-080e1f13689e07408"
  instance_type 		= "t2.micro"
  associate_public_ip_address  = true
  subnet_id    		= aws_subnet.subnet.id
  tags = {
      Name = "nti-ec2"
    }
    
    #lifecycle {
      #ignore_changes = [instance_type, tags]
    #}
}
