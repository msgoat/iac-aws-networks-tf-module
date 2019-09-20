# variables.tf
# ----------------------------------------------------------------------------
# Defines all input variables of this Terraform module.
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ----------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ----------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ----------------------------------------------------------------------------

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
  default     = "10.0.0.0/16"
}

variable "inbound_traffic_cidrs" {
  description = "The IP ranges in CIDR notation allowed to access any public ressource within the network."
  type        = list(string)
}

variable "bastion_instance_type" {
  description = "EC2 instance type of all Bastion EC2 instances. Optional, default: t3.micro"
  default = "t3.micro"
}

variable "bastion_key_pair_name" {
  description = "Name of the SSH key pair name to be assigned to the Bastion EC2 instances."
}

variable "with_eks_support" {
  description = "Controls AWS EKS support in the newly created VPC."
  type = bool
  default = false
}
