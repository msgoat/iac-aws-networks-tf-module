# variables.tf
# Module: bastion

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

variable "public_subnet_id" {
  description = "Unique identifier of the public subnet supposed to host the Bastion EC2 instances."
}

variable "common_tags" {
  description = "Common tags to be attached to each AWS resource"
  type = "map"
}

variable "bastion_ami_id" {
  description = "Unique identifier of the AMI to be used for the Bastion EC2 instances."
  default = "ami-0427098429ee46731" # Fedora-Cloud-Base-30-20190525.0.x86_64-hvm-eu-central-1-standard-0
}

variable "bastion_instance_type" {
  description = "EC2 instance type to be used for the Bastion EC2 instances."
  default = "t2.micro"
}

variable "bastion_root_volume_type" {
  description = "Volume type of Bastion EC2 instances root volume."
  default = "standard"
}

variable "bastion_root_volume_size" {
  description = "Volume size in GB of Bastion EC2 instances root volume."
  default = "50"
}

variable "bastion_key_pair_name" {
  description = "Name of the SSH key pair name to be assigned to the Bastion EC2 instances."
}

variable "bastion_inbound_cidrs" {
  description = "The IP ranges in CIDR notation allowed to access the Bastion EC2 instances via SSH."
  type = "list"
}

variable "bastion_iam_instance_profile_name" {
  description = "The name of an IAM instance profile to be attached to all Bastion EC2 instances."
}
