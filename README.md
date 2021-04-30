# iac-aws-reference_vpc-tf: Terraform module to set up an AWS reference VPC

Creates a reference network on AWS with a VPC spanning all availability zones of the given AWS region. 

Each availability zone will host a stack of three subnets:
* one public subnet for all internet-facing resources (web layer)
* one private subnet for application resources (application layer)
* one private subnet for databases and messaging systems used by your applications (data layer)

All outbound traffic from private resources running in the private subnets will be routed either through NAT gateways 
(one NAT gateway per availability zone) or NAT instances (one NAT instance per availability zone). 

Optionally you can have Bastion Servers in an Auto Scaling Group with a configurable number of instances.
 
## Input Variables

Variable Name | Variable Type | Mandatory? | Description | Default  
 --- | --- | --- | --- | --- 
region_name | string | x | The AWS region to deploy into (e.g. eu-central-1) /
organization_name | string | x | The name of the organization that owns all AWS resources  
department_name | string | x | The name of the department that owns all AWS resources | 
project_name | string | x | The name of the project that owns all AWS resources |
stage | string | x | The name of the current environment stage |
network_name | string | x | Logical name of the VPC (will be expanded to actual VPC name "vpc-${region_name}-${network_name}") | 
network_cidr | string | x | The CIDR range of the VPC (/16 ranges recommended like "10.0.0.0/16") |  
inbound_traffic_cidrs | list(string) | x | The source IP ranges in CIDR notation allowed to access any public resource within the network. |  
nat_strategy | string |  | NAT strategy to be applied to VPC. Possible values are: NAT_GATEWAY (default) or NAT_INSTANCE | "NATGATEWAY" 
nat_instance_type | string |  | EC2 instance type to be used for the NAT instances; will only be used if nat_strategy == NAT_GATEWAY | "t3.micro"
number_of_bastion_instances | number |  | Number of bastion EC2 instances that must be always available; may be 0 if you don't need any bastion servers | 1
bastion_instance_type | string |  | EC2 instance type to be used for the bastion instances | "t3.micro"
bastion_key_name | string | x | Name of SSH key pair name to used for the bastion instances | 
bastion_inbound_traffic_cidrs | list(string) |  | The IP ranges in CIDR notation allowed to access the bastion instances | inbound_traffic_cidrs

## Outputs

Output Name | Output Type | Description  
 --- | --- | ---  
network_id | string | Unique identifier of the VPC network created by this module
public_subnet_ids | list(string) | Unique identifiers of all newly created public subnets
private_subnet_ids | list(string) | Unique identifiers of all newly created private subnets
vpc_id | string | Unique identifier of the newly created VPC network
vpc_name | string | Fully qualified name of the newly created VPC network
bastion_security_group_name | string | Name of the security group applied to all bastion instances
bastion_security_group_id | string | Unique identifier of the security group applied to all bastion instances
public_subnet_ids | list(string) | Unique identifiers of all public subnets
private_subnet_ids | list(string) | Unique identifiers of all private subnets
web_subnet_ids | list(string) | Unique identifiers of all web subnets
app_subnet_ids | list(string) | Unique identifiers of all application subnets
data_subnet_ids | list(string) | Unique identifiers of all datastore subnets