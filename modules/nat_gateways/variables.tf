variable "network_id" {
  description = "Unique identifier of the VPC that will own the stack."
}

variable "network_name" {
  description = "The name suffix of the VPC."
}

variable "zone_names" {
  description = "Names of all availability zones which should be covered with NAT gateways"
}

variable "public_subnet_ids" {
  description = "Unique identifier of all public subnets which should host a NAT gateway (i.e. one public subnet per zone)"
  type = list(string)
}

variable "private_subnet_ids" {
  description = "Unique identifier of all private subnets which should be routed through the NAT gateways"
  type = list(string)
}

variable "common_tags" {
  description = "Common tags to be attached to each AWS resource"
  type = map(string)
}

variable "max_nat_gateways" {
  type = number
  default = 99
}