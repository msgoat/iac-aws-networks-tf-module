variable "network_id" {
  description = "Unique identifier of the VPC that will own the stack."
}

variable "network_name" {
  description = "The name suffix of the VPC."
}

variable "internet_gateway_id" {
  description = "Unique identifier of the AWS Internet Gateway to route all outbound traffic from the public subnets to the internet"
}

variable "zone_names" {
  description = "Names of the availability zones which are supposed to host a subnet stack"
  type = list(string)
}

variable "number_of_subnets_per_zone" {
  description = "Number of subnets per availibility zone"
  type = number
}

variable "public_subnets_per_zone" {
  description = "Number of public subnets per availibility zone"
  type = number
}

variable "private_subnets_per_zone" {
  description = "Number of private subnets per availibility zone"
  type = number
}

variable "common_tags" {
  description = "Common tags to attach to all managed AWS resources"
  type = map(string)
}

variable "eks_cluster_name" {
  description = "Optional name of an AWS EKS cluster which is supposed to use the newly created subnets"
}

variable "public_subnet_cidrs" {
  description = "CIDR ranges for public subnets"
  type = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR ranges for private subnets"
  type = list(string)
}