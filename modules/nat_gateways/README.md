# Terraform submodule nat_gateways

Adds NAT gateways and NAT routing to a given VPC.
 
## Input Variables

Variable Name | Variable Type | Mandatory? | Description | Default  
 --- | --- | --- | --- | --- 
common_tags | map(string) | x | Common tags to be attached to all AWS resource created by this module. |
network_id | string | x | Unique identifier of a VPC the NAT solution will be added to. |
network_name | string | x | Logical name of a VPC the NAT solution will be added to. | 
zone_names | list(string) | x | Names of all availability zones which should be covered with NAT gateways |
public_subnet_ids | list(string) | x | Unique identifiers of all public subnets which should host a NAT gateway (i.e. one public subnet per zone) |
private_subnet_ids | list(string) | x | Unique identifiers of all private subnets which should be routed through the NAT gateways |
max_nat_gateways | number |   | Maximum number of NAT gateways to be created | One NAT gateway per availability zone |

## Outputs

Output Name | Output Type | Description  
 --- | --- | ---  
nat_gateway_ids | list(string) | Unique identifiers of all newly created NAT gateways
