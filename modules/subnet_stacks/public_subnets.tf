# create the given number of public subnets in each availability zone
resource "aws_subnet" "public_subnets" {
  count = length(var.zone_names) * var.public_subnets_per_zone
  vpc_id = data.aws_vpc.given.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zone.zones_to_span[floor(count.index / var.public_subnets_per_zone)].name
  map_public_ip_on_launch = true
  tags = merge(map("Name", "subnet-${data.aws_availability_zone.zones_to_span[floor(count.index / var.public_subnets_per_zone)].name}-${var.network_name}-public"), local.public_subnet_common_tags)
}

# route all outbound internet traffic from public subnets through the Internet Gateway
resource "aws_route_table" "internet_route_table" {
  vpc_id = data.aws_vpc.given.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.given.id
  }
  tags = merge(map(
  "Name", "rtb-${data.aws_region.current.name}-${var.network_name}-igw"
  ), local.subnet_common_tags)
}

resource "aws_route_table_association" "internet_route_table_association" {
  count = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.internet_route_table.id
}
