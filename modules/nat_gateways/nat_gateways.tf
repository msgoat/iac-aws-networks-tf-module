# create NAT gateway with Elastic IP
resource "aws_nat_gateway" "nat_gateways" {
  count = local.allocation_size
  allocation_id = aws_eip.ips[count.index].id
  subnet_id = local.public_subnets_by_zone[local.zones_with_public_subnets[count.index]][0]
  tags = merge(map(
  "Name", "ngw-${local.zones_with_public_subnets[count.index]}-${local.nat_name}"
  ), local.nat_common_tags)
}
