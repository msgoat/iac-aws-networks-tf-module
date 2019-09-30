# nat-gateway

Terraform submodule which adds a NAT gateway to the public web tier subnet of the given availability zone
and alters the route tables of all private subnets in order to route all 
internet bound traffic through the NAT gateway.