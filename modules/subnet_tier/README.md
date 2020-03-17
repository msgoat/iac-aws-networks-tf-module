# subnet_tier

Terraform submodule which adds a single layer (tier) of subnets to the given availability zone by adding one
subnet to each given availability zone up to the given number of zones the subnet tier should span.

## Input Variables

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| network_id | string | Unique identifier of the VPC that will host the subnet tier | |
| network_name | string | The name suffix of the VPC | | 
| subnet_tier_name | string | Name of the subnet tier | | 
| common_tags | map(string) | Common tags to be attached to each subnet | | 
| zone_ids | list(string) | Unique identifiers of all availibility zones this subnet tier should span| | 
| subnet_cidrs | list(string) | IP address ranges of each subnet in CIDR format | |  
| max_zones | number | Maximum number of availbility zones this subnet tier should span |  |  
| is_public | bool | Indicates if this particular subnet tire has public subnets | false |  

## Output Variables

| Name | Type | Description |
| --- | --- | --- |
| subnet_ids | list(string) | Unique identifiers of all newly created subnets |  
