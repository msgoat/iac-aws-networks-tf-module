# retrieve information about the current region
data "aws_region" "current" {

}

# retrieve information about the specified VPC
data "aws_vpc" "vpc" {
  id = var.network_id
}

# retrieve information about the public subnets supposed to host the NAT instances
data "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_ids)
  id = var.public_subnet_ids[count.index]
}

# retrieve information about the private subnets that are supposed to be protected by the NAT instances
data "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_ids)
  id = var.private_subnet_ids[count.index]
}

locals {
  vpc_name = data.aws_vpc.vpc.tags["Name"]
  nat_common_tags = merge(var.common_tags)
  nat_name = lower(var.network_name)
  public_subnets_by_zone = { for zone_name in var.zone_names :
      zone_name => [for subnet in data.aws_subnet.public_subnets : subnet.id if subnet.availability_zone == zone_name ] }
  private_subnets_by_zone = { for zone_name in var.zone_names :
      zone_name => [for subnet in data.aws_subnet.private_subnets : subnet.id if subnet.availability_zone == zone_name ] }
  allocation_size = min(var.max_nat_instances, length(var.zone_names))
}
