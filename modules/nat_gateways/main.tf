# retrieve information about the current region
data "aws_region" "current" {

}

# retrieve information about the specified VPC
data "aws_vpc" "vpc" {
  id = var.network_id
}

# retrieve information about the public subnets supposed to host the NAT Gateway
data "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_ids)
  id = var.public_subnet_ids[count.index]
}

# retrieve information about the private subnets that are supposed to be protected by the NAT Gateway
data "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_ids)
  id = var.private_subnet_ids[count.index]
}

locals {
  vpc_name = data.aws_vpc.vpc.tags["Name"]
  nat_common_tags = merge(var.common_tags)
  nat_name = lower(var.network_name)
  zones_with_public_subnets = distinct([for subnet in data.aws_subnet.public_subnets : subnet.availability_zone])
  public_subnets_by_zone = { for zone_name in local.zones_with_public_subnets :
      zone_name => [for subnet in data.aws_subnet.public_subnets : subnet.id if subnet.availability_zone == zone_name ] }
  zones_with_private_subnets = distinct([for subnet in data.aws_subnet.private_subnets : subnet.availability_zone])
  private_subnets_by_zone = { for zone_name in local.zones_with_private_subnets :
      zone_name => [for subnet in data.aws_subnet.private_subnets : subnet.id if subnet.availability_zone == zone_name ] }
  nat_gateway_subnet_by_zone = { for zone_name, subnet_ids in local.public_subnets_by_zone :
      zone_name => subnet_ids[0] }
  allocation_size = min(var.max_nat_gateways, length(local.zones_with_public_subnets))
}

output "zones_with_public_subnets" {
  value = local.zones_with_public_subnets
}

output "public_subnets_by_zone" {
  value = local.public_subnets_by_zone
}