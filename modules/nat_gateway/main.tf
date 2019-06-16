# main.tf
# Module: nat-gateway

# Local values used in this module
locals {
  nat_common_tags = "${merge(var.common_tags)}"
  nat_name = "${lower(var.network_name)}"
}

# Retrieve information about the specified VPC
data "aws_vpc" "vpc" {
  id = "${var.network_id}"
}

# Retrieve information about the specified Availability Zone
data "aws_availability_zone" "zone" {
  name = "${var.zone_name}"
}

# Retrieve information about the public subnet of the specified availability zone
# supposed to host the NAT Gateway
data "aws_subnet" "public_subnet" {
  vpc_id = "${data.aws_vpc.vpc.id}"
  availability_zone_id = "${data.aws_availability_zone.zone.zone_id}"
  id = "${var.public_subnet_id}"
}

# Retrieve information about the private subnets of the specified availability
# zone that are supposed to be protected by the NAT Gateway
data "aws_subnet" "private_subnet_ids" {
  count = "${length(var.private_subnet_ids)}"
  vpc_id = "${data.aws_vpc.vpc.id}"
  availability_zone_id = "${data.aws_availability_zone.zone.zone_id}"
  id = "${element(var.private_subnet_ids, count.index)}"
}

# Retrieve information about the specified Internet Gateway
data "aws_internet_gateway" "internet_gateway" {
  internet_gateway_id = "${var.internet_gateway_id}"
}


# Elastic IP ---------------------------------------------------------------

# Create Elastic IP (EIP) to assign to NAT gateway
resource "aws_eip" "ngw_eip" {
  vpc = true
  tags = "${merge(map(
    "Name", "eip-${data.aws_availability_zone.zone.name}-${local.nat_name}"
  ), local.nat_common_tags)}"
}

# NAT gateway ---------------------------------------------------------------

# Create NAT gateway with Elastic IP
resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.ngw_eip.id}"
  subnet_id = "${data.aws_subnet.public_subnet.id}"
  tags = "${merge(map(
    "Name", "nat-${data.aws_availability_zone.zone.name}-${local.nat_name}"
  ), local.nat_common_tags)}"
}

# Security group for NAT instance
resource "aws_security_group" "nat_security_group" {
  name = "sec-${data.aws_availability_zone.zone.name}-${local.nat_name}-nat"
  description = "Controls all inbound and outbound traffic passed through the NAT gateway"
  vpc_id = "${data.aws_vpc.vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.vpc.cidr_block}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.vpc.cidr_block}"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = "${merge(map(
    "Name", "sg-${data.aws_availability_zone.zone.name}-${local.nat_name}-nat"
  ), local.nat_common_tags)}"
}

# Route tables ---------------------------------------------------------------

# route all outbound internet traffic from public subnets through the Internet Gateway
resource "aws_route_table" "internet_route_table" {
  vpc_id = "${data.aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${data.aws_internet_gateway.internet_gateway.id}"
  }
  tags = "${merge(map(
    "Name", "rtb-${data.aws_availability_zone.zone.name}-${local.nat_name}-igw"
  ), local.nat_common_tags)}"
}

resource "aws_route_table_association" "internet_route_table_association" {
  subnet_id = "${data.aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.internet_route_table.id}"
}

# route all outbound internet traffic from private subnets through the NAT instances
resource "aws_route_table" "nat_route_table" {
  vpc_id = "${data.aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.ngw.id}"
  }
  tags = "${merge(map(
    "Name", "rtb-${data.aws_availability_zone.zone.name}-${local.nat_name}-nat"
  ), local.nat_common_tags)}"
}

resource "aws_route_table_association" "app_route_table_associations" {
  count = "${length(var.private_subnet_ids)}"
  subnet_id = "${element(var.private_subnet_ids, count.index)}"
  route_table_id = "${aws_route_table.nat_route_table.id}"
}
