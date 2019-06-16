# ----------------------------------------------------------------------------
# main.tf
# ----------------------------------------------------------------------------
# Main entrypoint of this Terraform module.
# ----------------------------------------------------------------------------

provider "aws" {
  region = "${var.region_name}"
  version = "~> 1.37"
}

# Local values used in this module
locals {
  custom_tags = {
    Organization = "${var.organization_name}"
    Department = "${var.department_name}"
    Project = "${var.project_name}"
    Stage = "${var.stage}"
  }
}

# --- Network (VPC, Subnets) ---------------------------

module "vpc" {
  source = "./modules/vpc"
  region_name = "${var.region_name}"
  network_name = "${var.network_name}"
  network_cidr = "${var.network_cidr}"
  custom_tags = "${local.custom_tags}"
  inbound_traffic_cidrs = ["${var.inbound_traffic_cidrs}"]
}
