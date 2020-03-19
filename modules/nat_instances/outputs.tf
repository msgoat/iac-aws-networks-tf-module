output "nat_instance_ids" {
  description = "Unique identifiers of all created NAT EC2 instances"
  value = aws_instance.nats[*].id
}
