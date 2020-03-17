output "subnet_ids" {
  description = "Unique identifiers of the subnets created in this subnet tier"
  value = aws_subnet.subnet[*].id
}
