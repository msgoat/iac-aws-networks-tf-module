# terraform.tfvars
# ---------------------------------------------------------------------------
# Provides values for all variables used in this demo which will be picked
# up automatically when running Terraform.
# ---------------------------------------------------------------------------
region_name = "eu-central-1"
organization_name = "msg systems"
department_name = "Automotive Technology"
project_name = "AT41"
stage = "dev"
network_name = "iac-test"
network_cidr  = "10.0.0.0/16"
inbound_traffic_cidrs = ["0.0.0.0/0"]
bastion_key_pair_name = "key-eu-central-1-cloudtrain-bastion"
