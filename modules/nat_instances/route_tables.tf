# route all outbound internet traffic from private subnets through the NAT gateways
resource "aws_route_table" "nats" {
  count = local.allocation_size
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.nats[count.index].id
  }
  tags = merge(map(
  "Name", "rtb-${var.zone_names[count.index]}-${local.nat_name}-nat"
  ), local.nat_common_tags)
}

locals {
  nat_route_table_index_by_zone = { for zone_name in var.zone_names :
    zone_name => index(var.zone_names, zone_name) < local.allocation_size ? index(var.zone_names, zone_name) : 0
  }
  nat_route_table_by_zone = { for zone_name, index in local.nat_route_table_index_by_zone :
    zone_name => aws_route_table.nats[index].id if length(aws_route_table.nats) != 0}
}

resource "aws_route_table_association" "nats" {
  count = length(data.aws_subnet.private_subnets)
  subnet_id = data.aws_subnet.private_subnets[count.index].id
  route_table_id = local.nat_route_table_by_zone[data.aws_subnet.private_subnets[count.index].availability_zone]
}
