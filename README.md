# iac-networks-aws-module

Infrastructure as code project managing a reference network on AWS using Terraform.

## Variables

Variable Name | Variable Type | Description | Default  
 --- | --- | --- | --- 
region_name | string | The AWS region to deploy into (e.g. eu-central-1) /
organization_name | string | The name of the organization that owns all AWS resources  
department_name | string | The name of the department that owns all AWS resources | 
project_name | string | The name of the project that owns all AWS resources |
stage | string | The name of the current environment stage |
network_name | string | The name suffix of the VPC | 
network_cidr | string | The CIDR range of the VPC | "10.0.0.0/16" 
inbound_traffic_cidrs | list(string) | The source IP ranges in CIDR notation allowed to access any public resource within the network. | ["194.76.29.0/24"] 
bastion_instance_type | string | EC2 instance type of all Bastion EC2 instances. Optional, default: t3.micro | "t3.micro"
bastion_key_pair_name | string | Name of the SSH key pair name to be assigned to the Bastion EC2 instances | "key-eu-central-1-cloudtrain-bastion" 
with_eks_support | bool | Controls AWS EKS support in the newly created VPC | false 

output "network_id" {
  description = "Unique identifier of the VPC network created by this module."
  value = "${module.vpc.network_id}"
}

output "web_subnet_ids" {
  description = "Unique identifier of all public subnets belonging to the public web tier."
  value = ["${module.subnet_zone0.web_subnet_id}","${module.subnet_zone1.web_subnet_id}","${module.subnet_zone2.web_subnet_id}"]
}

output "app_subnet_ids" {
  description = "Unique identifier of all private subnets belonging to the private application tier."
  value = ["${module.subnet_zone0.app_subnet_id}","${module.subnet_zone1.app_subnet_id}","${module.subnet_zone2.app_subnet_id}"]
}

output "data_subnet_ids" {
  description = "Unique identifier of all private subnets belonging to the private data tier."
  value = ["${module.subnet_zone0.data_subnet_id}","${module.subnet_zone1.data_subnet_id}","${module.subnet_zone2.data_subnet_id}"]
}

output "bastion_instance_ids" {
  description = "Unique identifier of all bastion EC2 instances."
  value = ["${module.bastion_zone0.bastion_instance_id}","${module.bastion_zone1.bastion_instance_id}","${module.bastion_zone2.bastion_instance_id}"]
}
 