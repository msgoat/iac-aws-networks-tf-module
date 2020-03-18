output "network_id" {
  description = "Unique identifier of the newly created VPC network."
  value = module.vpc.network_id
}

output "public_subnet_ids" {
  description = "Unique identifier of all newly created public subnets."
  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Unique identifier of all newly created private subnets."
  value = module.subnets.private_subnet_ids
}

output "zones_with_public_subnets" {
  value = module.nat_gateways.zones_with_public_subnets
}

output "public_subnets_by_zone" {
  value = module.nat_gateways.public_subnets_by_zone
}