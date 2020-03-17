# outputs.tf
# Module: vpc

output "network_id" {
  description = "Unique identifier of the VPC network created by this module."
  value = aws_vpc.vpc.id
}

output "internet_gateway_id" {
  description = "Unique identifier of the Internet Gateway associated with the VPC created by this module."
  value = aws_internet_gateway.igw.id
}