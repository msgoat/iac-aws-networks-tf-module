# ----------------------------------------------------------------------------
# main.tf
# ----------------------------------------------------------------------------

provider "aws" {
  region  = var.region_name
  version = "~> 2.7"
}

# Local values used in this module
locals {
  test_common_tags = {
    Organization = var.organization_name
    Department = var.department_name
    Project = var.project_name
    Stage = var.stage
  }
}

# --- VPC ---------------------------

module "network" {
  source = "../../../iac-networks-aws-module/modules/vpc"
  # source = "git::https://git.at.automotive.msg.team/cloudtrain/iac-networks-aws-module.git"
  region_name = var.region_name
  common_tags = local.test_common_tags
  network_name = var.network_name
  network_cidr = var.network_cidr
}

# --- Subnets ---------------------------

data "aws_availability_zones" "available_zones" {
  state = "available"
}

output "available_zones" {
  value = data.aws_availability_zones.available_zones.names
}

locals {
  max_zones = min(length(data.aws_availability_zones.available_zones.names), 3)
  cidrs_by_subnet = cidrsubnets(var.network_cidr, 8,8,8,4,4,4)
  public_subnet_cidrs = slice(local.cidrs_by_subnet, 0, local.max_zones)
  private_subnet_cidrs = slice(local.cidrs_by_subnet, local.max_zones, local.max_zones * 2)
}

output "public_subnet_cidrs" {
  value = local.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  value = local.private_subnet_cidrs
}

module "public_subnet_tier" {
  source = "../../../iac-networks-aws-module/modules/subnet_tier"
  network_name = var.network_name
  network_id = module.network.network_id
  subnet_cidrs = local.public_subnet_cidrs
  zone_ids = data.aws_availability_zones.available_zones.zone_ids
  max_zones = local.max_zones
  common_tags = local.test_common_tags
  subnet_tier_name = "web"
  is_public = true
}

module "private_subnet_tier" {
  source = "../../../iac-networks-aws-module/modules/subnet_tier"
  network_name = var.network_name
  network_id = module.network.network_id
  subnet_cidrs = local.private_subnet_cidrs
  zone_ids = data.aws_availability_zones.available_zones.zone_ids
  max_zones = local.max_zones
  common_tags = local.test_common_tags
  subnet_tier_name = "app"
  is_public = false
}
