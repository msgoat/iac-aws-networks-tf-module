variable "region_name" {
  description = "The AWS region to deploy into (e.g. eu-central-1)."
  type = string
}

variable "organization_name" {
  description = "The name of the organization that owns all AWS resources."
  type = string
}

variable "department_name" {
  description = "The name of the department that owns all AWS resources."
  type = string
}

variable "project_name" {
  description = "The name of the project that owns all AWS resources."
  type = string
}

variable "stage" {
  description = "The name of the current environment stage."
  type = string
}

variable "network_name" {
  description = "The name suffix of the VPC."
  type = string
}

variable "network_cidr" {
  description = "The CIDR range of the VPC."
  type = string
}

variable "inbound_traffic_cidrs" {
  description = "The IP ranges in CIDR notation allowed to access any public resource within the network."
  type        = list(string)
}

variable "nat_strategy" {
  description = "NAT strategy to be applied to VPC. Possible values are: NAT_GATEWAY (default) or NAT_INSTANCE"
  type = string
  default = "NAT_GATEWAY"
}

variable "nat_instance_type" {
  description = "EC2 instance type to be used for the NAT instances; will only be used if nat_strategy == NAT_GATEWAY"
  type = string
  default = "t3.micro"
}

variable "number_of_bastion_instances" {
  description = "Number of bastion EC2 instances that must be always available; default: 1"
  type = number
  default = 1
}

variable "bastion_instance_type" {
  description = "EC2 instance type to be used for the bastion instances; default: t3.micro"
  type = string
  default = "t3.micro"
}

variable "bastion_key_name" {
  description = "Name of SSH key pair name to used for the bastion instances"
  type = string
}

variable "bastion_inbound_traffic_cidrs" {
  description = "The IP ranges in CIDR notation allowed to access the bastion instances; default: inbound_traffic_cidrs"
  type = list(string)
  default = []
}


