# ----------------------------------------------------------------------------
# main.tf
# ----------------------------------------------------------------------------
# Main entrypoint of this Terraform module.
# ----------------------------------------------------------------------------

provider "aws" {
  region  = var.region_name
  version = "~> 2.7"
}

# Local values used in this module
locals {
  networks_common_tags = {
    Organization = var.organization_name
    Department   = var.department_name
    Project      = var.project_name
    Stage        = var.stage
  }
}

# --- Network (VPC) ---------------------------

module "vpc" {
  source                = "./modules/vpc"
  region_name           = var.region_name
  network_name          = var.network_name
  network_cidr          = var.network_cidr
  common_tags           = local.networks_common_tags
  inbound_traffic_cidrs = var.inbound_traffic_cidrs
}

# --- Network (Subnets) ---------------------------

# Retrieve all availability zones in specified region
data "aws_availability_zones" "zone_names" {
}

module "subnet_zone0" {
  source          = "./modules/subnet"
  network_name    = var.network_name
  network_id      = module.vpc.network_id
  zone_name       = data.aws_availability_zones.zone_names.names[0]
  zone_index      = 0
  zone_cidr_block = cidrsubnet(var.network_cidr, 2, 0)
  common_tags     = local.networks_common_tags
  with_eks_support = var.with_eks_support
}

module "subnet_zone1" {
  source          = "./modules/subnet"
  network_name    = var.network_name
  network_id      = module.vpc.network_id
  zone_name       = data.aws_availability_zones.zone_names.names[1]
  zone_index      = 1
  zone_cidr_block = cidrsubnet(var.network_cidr, 2, 1)
  common_tags     = local.networks_common_tags
  with_eks_support = var.with_eks_support
}

module "subnet_zone2" {
  source          = "./modules/subnet"
  network_name    = var.network_name
  network_id      = module.vpc.network_id
  zone_name       = data.aws_availability_zones.zone_names.names[2]
  zone_index      = 2
  zone_cidr_block = cidrsubnet(var.network_cidr, 2, 2)
  common_tags     = local.networks_common_tags
  with_eks_support = var.with_eks_support
}

# --- NAT Gateways ---------------------------

module "nat_gateway_zone0" {
  source              = "./modules/nat_gateway"
  network_name        = var.network_name
  network_id          = module.vpc.network_id
  internet_gateway_id = module.vpc.internet_gateway_id
  zone_name           = data.aws_availability_zones.zone_names.names[0]
  zone_index          = 0
  common_tags         = local.networks_common_tags
  public_subnet_id    = module.subnet_zone0.web_subnet_id
  private_subnet_ids  = [module.subnet_zone0.app_subnet_id, module.subnet_zone0.data_subnet_id]
}

module "nat_gateway_zone1" {
  source              = "./modules/nat_gateway"
  network_name        = var.network_name
  network_id          = module.vpc.network_id
  internet_gateway_id = module.vpc.internet_gateway_id
  zone_name           = data.aws_availability_zones.zone_names.names[1]
  zone_index          = 1
  common_tags         = local.networks_common_tags
  public_subnet_id    = module.subnet_zone1.web_subnet_id
  private_subnet_ids  = [module.subnet_zone1.app_subnet_id, module.subnet_zone1.data_subnet_id]
}

module "nat_gateway_zone2" {
  source              = "./modules/nat_gateway"
  network_name        = var.network_name
  network_id          = module.vpc.network_id
  internet_gateway_id = module.vpc.internet_gateway_id
  zone_name           = data.aws_availability_zones.zone_names.names[2]
  zone_index          = 2
  common_tags         = local.networks_common_tags
  public_subnet_id    = module.subnet_zone2.web_subnet_id
  private_subnet_ids  = [module.subnet_zone2.app_subnet_id, module.subnet_zone2.data_subnet_id]
}

# --- IAM EC2 Instance Profile for Bastion Servers ---------------------------

module "bastion_iam_instance_profile" {
  source           = "./modules/bastion_iam_instance_profile"
  network_name     = var.network_name
  common_tags      = local.networks_common_tags
}

# --- Bastion Servers ---------------------------

module "bastion_zone0" {
  source           = "./modules/bastion"
  network_name     = var.network_name
  network_id       = module.vpc.network_id
  zone_name        = data.aws_availability_zones.zone_names.names[0]
  zone_index       = 0
  common_tags      = local.networks_common_tags
  public_subnet_id = module.subnet_zone0.web_subnet_id
  bastion_instance_type = var.bastion_instance_type
  bastion_key_pair_name = var.bastion_key_pair_name
  bastion_inbound_cidrs = var.inbound_traffic_cidrs
  bastion_iam_instance_profile_name = module.bastion_iam_instance_profile.profile_name
}

module "bastion_zone1" {
  source           = "./modules/bastion"
  network_name     = var.network_name
  network_id       = module.vpc.network_id
  zone_name        = data.aws_availability_zones.zone_names.names[1]
  zone_index       = 1
  common_tags      = local.networks_common_tags
  public_subnet_id = module.subnet_zone1.web_subnet_id
  bastion_instance_type = var.bastion_instance_type
  bastion_key_pair_name = var.bastion_key_pair_name
  bastion_inbound_cidrs = var.inbound_traffic_cidrs
  bastion_iam_instance_profile_name = module.bastion_iam_instance_profile.profile_name
}

module "bastion_zone2" {
  source           = "./modules/bastion"
  network_name     = var.network_name
  network_id       = module.vpc.network_id
  zone_name        = data.aws_availability_zones.zone_names.names[2]
  zone_index       = 2
  common_tags      = local.networks_common_tags
  public_subnet_id = module.subnet_zone2.web_subnet_id
  bastion_instance_type = var.bastion_instance_type
  bastion_key_pair_name = var.bastion_key_pair_name
  bastion_inbound_cidrs = var.inbound_traffic_cidrs
  bastion_iam_instance_profile_name = module.bastion_iam_instance_profile.profile_name
}

