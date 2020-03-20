# Terraform module iac-networks-aws-module

Creates a reference network on AWS with a VPC spanning all availability zones of the given AWS region. 

Each availability zone will host a stack of three subnets:
* one public subnet for all internet-facing resources
* one private subnet for application resources
* one private subnet for databases and messaging systems used by your applications

All outbound traffic from private resources running in the private subnets will be routed through NAT gateways 
(one NAT gateway per availability zone).

If you need a VPC with different characteristics, you can use a mix of the provided submodules to tailor the default 
implementation to your specific requirements:  
* submodule [vpc](modules/vpc/README.md) creates an empty VPC including an internet gateway
* submodule [subnet_stacks](modules/subnet_stacks/README.md) creates a stack of subnets in each availability zone
* submodule [nat_gateways](modules/nat_gateways/README.md) adds a NAT solution based on AWS NAT Gateways to your subnets
* submodule [nat_instances](modules/nat_instances/README.md) offers a NAT solution based on AWS NAT Instances

Concrete examples of common use-cases can be found in the test section of this Terraform module:
* test [vpc_simple](test/vpc_simple/main.tf) demonstrates how to create a simple VPC with public subnets only requiring no NAT solution
* test [vpc_with_nat_gateways](test/vpc_with_nat_gateways/main.tf) shows how to create a full-blown VPC with NAT gateways
* test [vpc_with_nat_instances](test/vpc_with_nat_instances/main.tf) shows how to create a full-blown VPC with NAT instances
 
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
eks_cluster_name | string |   | Actual name of an AWS EKS cluster, if this VPC should host an AWS EKS cluster; adds EKS support to all created VPCs and subnets | "" 

## Outputs

Output Name | Output Type | Description  
 --- | --- | ---  
network_id | string | Unique identifier of the VPC network created by this module
public_subnet_ids | list(string) | Unique identifiers of all newly created public subnets
private_subnet_ids | list(string) | Unique identifiers of all newly created private subnets
