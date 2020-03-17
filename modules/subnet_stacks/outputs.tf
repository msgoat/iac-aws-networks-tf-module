output "public_subnet_ids" {
  description = "Unique identifiers of all newly created public subnets"
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "Unique identifiers of all newly created private subnets"
  value = aws_subnet.private_subnets[*].id
}