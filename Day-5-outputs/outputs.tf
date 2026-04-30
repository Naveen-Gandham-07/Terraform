output "ip" {
    value = aws_instance.test.public_ip
  
}

output "privateIp" {
    value = aws_instance.test.private_ip
    sensitive = true
  
}

output "Az" {
    value = aws_instance.test.availability_zone
  
}