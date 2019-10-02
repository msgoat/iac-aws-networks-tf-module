# variables.tf

variable "region_name" {
  description = "The AWS region to deploy into (e.g. eu-central-1)."
}

variable "organization_name" {
  description = "The name of the organization that owns all AWS resources."
}

variable "department_name" {
  description = "The name of the department that owns all AWS resources."
}

variable "project_name" {
  description = "The name of the project that owns all AWS resources."
}

variable "stage" {
  description = "The name of the current environment stage."
}

variable "network_name" {
  description = "The name suffix of the VPC."
}

variable "network_cidr" {
  description = "The CIDR range of the VPC."
}

variable "inbound_traffic_cidrs" {
  description = "The IP ranges in CIDR notation allowed to access any public ressource within the network."
  type        = "list"
}

variable "bastion_key_pair_name" {
  description = "Name of the SSH key pair name to be assigned to the Bastion EC2 instances."
}

variable "eks_cluster_name" {
  description = "AWS EKS cluster name to annotate VPC and subnets"
  default = ""
}
