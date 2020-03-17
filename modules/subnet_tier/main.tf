# Local values used in this module
locals {
  subnet_common_tags = var.common_tags
  subnet_name = "${lower(var.network_name)}-${lower(var.subnet_tier_name)}"
}

# Retrieve information about the specified VPC
data "aws_vpc" "vpc" {
  id = var.network_id
}

# Retrieve information about the specified Availability Zone
data "aws_availability_zone" "zone" {
  count = var.max_zones
  zone_id = var.zone_ids[count.index]
}

# --- Subnets ----------------------------------------------------------------

resource "aws_subnet" "subnet" {
  count = var.max_zones
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = var.subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zone.zone[count.index].name
  map_public_ip_on_launch = var.is_public
  tags = merge(map(
    "Name", "subnet-${data.aws_availability_zone.zone[count.index].name}-${local.subnet_name}",
          "Tier", var.subnet_tier_name
  ),
  local.subnet_common_tags)
}
