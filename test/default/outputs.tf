output "network_id" {
  description = "Unique identifier of the newly created VPC network."
  value = module.network.network_id
}

output "public_subnet_ids" {
  description = "Unique identifier of all newly created public subnets."
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Unique identifier of all newly created private subnets."
  value = module.network.private_subnet_ids
}
