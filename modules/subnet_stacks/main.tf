# get current AWS region
data "aws_region" "current" {
}

# get given VPC
data "aws_vpc" "given" {
  id = var.network_id
}

# get given availabilty zones
data "aws_availability_zone" "zones_to_span" {
  count = length(var.zone_names)
  name = var.zone_names[count.index]
}

# get given internet gateway
data "aws_internet_gateway" "given" {
  internet_gateway_id = var.internet_gateway_id
}

locals {
  subnet_common_tags = var.common_tags
  public_subnet_common_tags = var.eks_cluster_name != "" ? merge(local.subnet_common_tags, map("kubernetes.io/role/elb", "1", "kubernetes.io/cluster/${var.eks_cluster_name}", "shared")) : local.subnet_common_tags
  private_subnet_common_tags = var.eks_cluster_name != "" ? merge(local.subnet_common_tags, map("kubernetes.io/role/internal-elb", "1", "kubernetes.io/cluster/${var.eks_cluster_name}", "shared")) : local.subnet_common_tags
}
