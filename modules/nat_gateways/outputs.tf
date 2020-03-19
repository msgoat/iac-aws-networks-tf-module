output "nat_gateway_ids" {
  description = "Unique identifiers of all created NAT gateways"
  value = aws_nat_gateway.nat_gateways[*].id
}
