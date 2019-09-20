# iac-networks-aws-module

Terraform module managing a reference network on AWS.

TODO: add picture demonstrating reference network on AWS
TODO: add loadbalancers to reference network
 
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

## Outputs

Output Name | Output Type | Description  
 --- | --- | ---  
network_id | string | Unique identifier of the VPC network created by this module
web_subnet_ids | list(string) | Unique identifiers of all public subnets belonging to the public web tier
app_subnet_ids | list(string) | Unique identifiers of all private subnets belonging to the private application tier
data_subnet_ids | list(string) | Unique identifiers of all private subnets belonging to the private data tier
bastion_instance_ids | list(string) | Unique identifiers of all bastion EC2 instances. Each public web tier subnet contains one bastion EC2 instance