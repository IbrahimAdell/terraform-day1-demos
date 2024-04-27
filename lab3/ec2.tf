# AMI that will be used
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"]
}

# launch 2 EC2 instances
resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.ubuntu.id
  for_each                    = var.instances
  instance_type               = each.value.instance_type
  subnet_id                   = aws_subnet.subnet[each.value.subnet].id
  security_groups             = [aws_security_group.sg.id]
  associate_public_ip_address = each.value.associate_publicIP
  tags = {
    Name = each.value.name
  }
  user_data = "${file("script.sh")}"
} 

# output to print public ip & private ip
output "public_ip" {
  value = aws_instance.ec2["public-ec2"].public_ip
}
output "private_ip" {
  value = aws_instance.ec2["private-ec2"].private_ip
}