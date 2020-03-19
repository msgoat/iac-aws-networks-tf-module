resource "aws_security_group" "nat" {
  name = "sec-${data.aws_region.current.name}-${local.nat_name}-nat"
  description = "Security group for all NAT instances in VPC"
  vpc_id = data.aws_vpc.vpc.id
  tags = merge(map(
  "Name", "sg-${data.aws_region.current.name}-${local.nat_name}-nat"
  ), local.nat_common_tags)
}

resource "aws_security_group_rule" "nat_http_ingress" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.nat.id
  cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  description = "Allow inbound HTTP traffic from servers in the private subnet"
}

resource "aws_security_group_rule" "nat_https_ingress" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  security_group_id = aws_security_group.nat.id
  cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  description = "Allow inbound HTTPS traffic from servers in the private subnet"
}

resource "aws_security_group_rule" "nat_http_egress" {
  type = "egress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.nat.id
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow outbound HTTP traffic from NAT instances to the internet"
}

resource "aws_security_group_rule" "nat_https_egress" {
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  security_group_id = aws_security_group.nat.id
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow outbound HTTPS traffic from NAT instances to the internet"
}
