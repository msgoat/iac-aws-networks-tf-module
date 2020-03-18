# create Elastic IP (EIP) to assign to NAT gateway
resource "aws_eip" "ips" {
  count = local.allocation_size
  vpc = true
  tags = merge(map(
    "Name", "eip-${local.zones_with_public_subnets[count.index]}-${local.nat_name}-ngw"
  ), local.nat_common_tags)
}
