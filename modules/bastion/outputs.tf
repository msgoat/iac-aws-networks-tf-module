# outputs.tf
# Module: bastion

output "bastion_instance_id" {
  description = "Unique identifier of the newly created Bastion EC2 instance"
  value = "${aws_instance.bastion.id}"
}
