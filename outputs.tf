output "network_id" {
  description = "Unique identifier of the VPC network created by this module."
  value = "${module.vpc.network_id}"
}

output "web_subnet_ids" {
  description = "Unique identifier of all public subnets belonging to the public web tier."
  value = ["${module.subnet_zone0.web_subnet_id}","${module.subnet_zone1.web_subnet_id}","${module.subnet_zone2.web_subnet_id}"]
}

output "app_subnet_ids" {
  description = "Unique identifier of all private subnets belonging to the private application tier."
  value = ["${module.subnet_zone0.app_subnet_id}","${module.subnet_zone1.app_subnet_id}","${module.subnet_zone2.app_subnet_id}"]
}

output "data_subnet_ids" {
  description = "Unique identifier of all private subnets belonging to the private data tier."
  value = ["${module.subnet_zone0.data_subnet_id}","${module.subnet_zone1.data_subnet_id}","${module.subnet_zone2.data_subnet_id}"]
}
/*
output "bastion_instance_ids" {
  description = "Unique identifier of all bastion EC2 instances."
  value = ["${module.bastion_zone0.bastion_instance_id}","${module.bastion_zone1.bastion_instance_id}","${module.bastion_zone2.bastion_instance_id}"]
}
*/