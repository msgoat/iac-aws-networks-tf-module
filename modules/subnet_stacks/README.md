# Terraform submodule subnet_stacks

Adds a stack of subnets to each specified availability zone.
 
## Input Variables

Variable Name | Variable Type | Mandatory? | Description | Default  
 --- | --- | --- | --- | --- 
common_tags | map(string) | x | Common tags to be attached to all AWS resource created by this module. |
network_id | string | x | Unique identifier of a VPC the subnets will be added to. |
network_name | string | x | Logical name of a VPC the subnets will be added to. | 
zone_names | list(string) | x | Names of all availability zones which are supposed to host a subnet stack |
number_of_subnets_per_zone | number | x | Number of subnets per availability zone | 
public_subnets_per_zone | number | x | Number of public subnets per availability zone | 
private_subnets_per_zone | number | x | Number of private subnets per availability zone | 
private_max_nat_instances | number |   | Maximum number of NAT instances to be created | One NAT instance per availability zone 
eks_cluster_name | string |   | Actual name of an AWS EKS cluster, if all subnets should host an AWS EKS cluster; adds EKS support to all created subnets | "" 
public_subnet_cidrs | list(string) | x | CIDR ranges for public subnets |
private_subnet_cidrs | list(string) | x | CIDR ranges for private subnets |

## Outputs

Output Name | Output Type | Description  
 --- | --- | ---  
public_subnet_ids | list(string) | Unique identifiers of all newly created public subnets
private_subnet_ids | list(string) | Unique identifiers of all newly created private subnets
