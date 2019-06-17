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
  default     = "eu-central-1"
}

variable "organization_name" {
  description = "The name of the organization that owns all AWS resources."
  default     = "msg systems"
}

variable "department_name" {
  description = "The name of the department that owns all AWS resources."
  default     = "Automotive Technology"
}

variable "project_name" {
  description = "The name of the project that owns all AWS resources."
  default     = "AT41"
}

variable "stage" {
  description = "The name of the current environment stage."
  default     = "dev"
}

variable "network_name" {
  description = "The name suffix of the VPC."
  default     = "cloudtrain"
}

variable "network_cidr" {
  description = "The CIDR range of the VPC."
  default     = "10.0.0.0/16"
}

variable "inbound_traffic_cidrs" {
  description = "The IP ranges in CIDR notation allowed to access any public ressource within the network."
  type        = list(string)
  default     = ["194.76.29.0/24"]
}

variable "bastion_key_pair_name" {
  description = "Name of the SSH key pair name to be assigned to the Bastion EC2 instances."
  default = "key-eu-central-1-cloudtrain-bastion"
}
