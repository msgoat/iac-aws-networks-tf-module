# main.tf
# Module: stack
# Creates a complete stack of subnets in the specified availability zone

# Retrieve information about the specified VPC
data "aws_vpc" "vpc" {
  id = var.network_id
}

# Local values used in this module
locals {
  subnet_common_tags = merge(var.common_tags)
  subnet_name = lower(var.network_name)
  # add required AWS EKS tags to web and application tier subnets if EKS support is activated
  web_subnet_common_tags = var.with_eks_support ? map("Tier", "web", "kubernetes.io/role/elb", "1") : map("Tier", "web")
  app_subnet_common_tags = var.with_eks_support ? map("Tier", "app", "kubernetes.io/role/internal-elb", "1") : map("Tier", "app")
}

# Retrieve information about the specified Availability Zone
data "aws_availability_zone" "zone" {
  name = var.zone_name
}

# --- Subnets ----------------------------------------------------------------

# Create public web tier subnet

resource "aws_subnet" "web_subnet" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.zone_cidr_block, 4, 0)
  availability_zone = data.aws_availability_zone.zone.name
  map_public_ip_on_launch = true
  tags = merge(map(
    "Name", "subnet-${data.aws_availability_zone.zone.name}-${local.subnet_name}-web"
  ),
  local.web_subnet_common_tags,
  local.subnet_common_tags)
}

# Create private application tier subnet

resource "aws_subnet" "app_subnet" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.zone_cidr_block, 2, 1)
  availability_zone = data.aws_availability_zone.zone.name
  map_public_ip_on_launch = false
  tags = merge(map(
    "Name", "subnet-${data.aws_availability_zone.zone.name}-${local.subnet_name}-app"),
  local.app_subnet_common_tags,
  local.subnet_common_tags)
}

# Create private data tier subnet

resource "aws_subnet" "data_subnet" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.zone_cidr_block, 2, 2)
  availability_zone = data.aws_availability_zone.zone.name
  map_public_ip_on_launch = false
  tags = merge(map(
    "Name", "subnet-${data.aws_availability_zone.zone.name}-${local.subnet_name}-data",
    "Tier", "data"
  ), local.subnet_common_tags)
}

