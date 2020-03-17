variable "network_id" {
  description = "Unique identifier of the VPC that will own the stack."
}

variable "network_name" {
  description = "The name suffix of the VPC."
}

variable "subnet_tier_name" {
  description = "Name of the subnet tier"
}

variable "common_tags" {
  description = "Common tags to be attached to each subnet"
  type = map(string)
}

variable "zone_ids" {
  description = "Unique identifiers of all availibility zones this subnet tier should span"
  type = list(string)
}

variable "subnet_cidrs" {
  description = "IP address ranges of each subnet in CIDR format"
  type = list(string)
}

variable "max_zones" {
  description = "Maximum number of availbility zones this subnet tier should span"
  type = number
}

variable "is_public" {
  description = "Indicates if this particular subnet tire has public subnets"
  type = bool
  default = false
}