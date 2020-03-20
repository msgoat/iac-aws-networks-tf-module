# Terraform submodule vpc

Terraform submodule which creates a VPC.
 
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
eks_cluster_name | string |   | Actual name of an AWS EKS cluster, if this VPC should host an AWS EKS cluster; adds EKS support to all created VPCs and subnets | "" 

## Outputs

Output Name | Output Type | Description  
 --- | --- | ---  
network_id | string | Unique identifier of the VPC network created by this module
internet_gateway_id | string | Unique identifiers of the newly created internet gateway
