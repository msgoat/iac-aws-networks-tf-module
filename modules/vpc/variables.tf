# variables.tf
# Module: vpc
# Defines all input variables of this Terraform module.

variable "region_name" {
  description = "The AWS region to deploy into (e.g. eu-central-1)."
}

variable "network_name" {
  description = "The name suffix of the VPC."
}

variable "network_cidr" {
  description = "CIDR representing the networks IP address space (e.g 10.0.0.0/16)."
  type = "string"
}

variable "inbound_traffic_cidrs" {
  description = "The IP ranges in CIDR notation allowed to access any instance or service via internet."
  type        = "list"
}

variable "common_tags" {
  description = "Common tags to be attached to each AWS resource"
  type = "map"
}
