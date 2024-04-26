output "ec2-public-ipv4" {
  value = aws_instance.ec2_instance.public_ip
}

output "ec2-state" {
  value = aws_instance.ec2_instance.instance_state
}

