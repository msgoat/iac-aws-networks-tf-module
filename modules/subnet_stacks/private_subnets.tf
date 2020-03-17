# create the given number of private subnets in each availability zone
resource "aws_subnet" "private_subnets" {
  count = length(var.zone_names) * var.private_subnets_per_zone
  vpc_id = data.aws_vpc.given.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zone.zones_to_span[floor(count.index / var.private_subnets_per_zone)].name
  map_public_ip_on_launch = false
  tags = merge(map("Name", "subnet-${data.aws_availability_zone.zones_to_span[floor(count.index / var.private_subnets_per_zone)].name}-${var.network_name}-private"), local.private_subnet_common_tags)
}

# each private has a default route table keeping all outbound traffic within the VPC