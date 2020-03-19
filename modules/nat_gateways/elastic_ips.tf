# create Elastic IP (EIP) to assign to NAT gateway
resource "aws_eip" "ips" {
  count = local.allocation_size
  vpc = true
  tags = merge(map(
    "Name", "eip-${var.zone_names[count.index]}-${local.nat_name}-ngw"
  ), local.nat_common_tags)
}
