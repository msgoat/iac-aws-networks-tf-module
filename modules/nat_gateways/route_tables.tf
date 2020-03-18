# route all outbound internet traffic from private subnets through the NAT gateways
resource "aws_route_table" "nat" {
  count = local.allocation_size
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateways[count.index].id
  }
  tags = merge(map(
  "Name", "rtb-${local.zones_with_public_subnets[count.index]}-${local.nat_name}-ngw"
  ), local.nat_common_tags)
}

locals {
  nat_route_table_index_by_zone = { for zone_name in local.zones_with_private_subnets :
    zone_name => index(local.zones_with_private_subnets, zone_name) < local.allocation_size ? index(local.zones_with_private_subnets, zone_name) : 0
  }
  nat_route_table_by_zone = { for zone_name, index in local.nat_route_table_index_by_zone :
    zone_name => aws_route_table.nat[index].id }
}

resource "aws_route_table_association" "nat" {
  count = length(data.aws_subnet.private_subnets)
  subnet_id = data.aws_subnet.private_subnets[count.index].id
  route_table_id = local.nat_route_table_by_zone[data.aws_subnet.private_subnets[count.index].availability_zone]
}
