# variables.tf
# Module: nat-gateway

variable "network_id" {
  description = "Unique identifier of the VPC that will own the stack."
}

variable "network_name" {
  description = "The name suffix of the VPC."
}

variable "zone_name" {
  description = "Name of the availability zone the stack will be created in."
}

variable "zone_index" {
  description = "Zero-based index of the availability zone used for CIDR block calculations"
}

variable "internet_gateway_id" {
  description = "Unique identifier of the Internet Gateway of the specified VPC."
}

variable "public_subnet_id" {
  description = "Unique identifier of the public subnet supposed to host the NAT Gateway."
}

variable "private_subnet_ids" {
  description = "Unique identifiers of the private subnets supposed to be protected by the NAT Gateway."
  type = "list"
}

variable "common_tags" {
  description = "Common tags to be attached to each AWS resource"
  type = "map"
}

