# vpc/outputs.tf
output "public_subnet_ids" {
  value = aws_subnet.public-subnet[*].id
}

# vpc/outputs.tf
output "private_subnet_ids" {
  value = aws_subnet.private-subnet[*].id
}