output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.retail_store.id
}

output "public_ip" {
  description = "EC2 public IP address"
  value       = aws_instance.retail_store.public_ip
}

output "public_dns" {
  description = "EC2 public DNS"
  value       = aws_instance.retail_store.public_dns
}

output "retail_store_url" {
  description = "Retail store application URL"
  value       = "http://${aws_instance.retail_store.public_ip}:8888"
}

output "ssh_command" {
  description = "SSH command to connect to the server"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_instance.retail_store.public_ip}"
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.retail_store.id
}
