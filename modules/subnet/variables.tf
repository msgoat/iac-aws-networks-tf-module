# variables.tf
# Module: stack
# Defines all input variables to the stack module

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

variable "zone_cidr_block" {
  description = "CIDR block dedicated to the specified zone"
}

variable "common_tags" {
  description = "Common tags to be attached to each AWS resource"
  type = "map"
}

variable "eks_cluster_name" {
  description = "AWS EKS cluster name to annotate VPC and subnets"
  default = ""
}


