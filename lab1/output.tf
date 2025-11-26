output "first_instance_public_ip" {
  description = "Public IP of the first instance"
  value       = aws_instance.web.public_ip
}

output "second_instance_public_ip" {
  description = "Public IP of the instance launched from AMI"
  value       = aws_instance.web_from_ami.public_ip
}

output "created_ami_id" {
  description = "AMI ID created from the first instance"
  value       = aws_ami_from_instance.web_ami.id
}
