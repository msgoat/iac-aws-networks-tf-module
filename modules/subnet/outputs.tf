# outputs.tf
# Module: subnet

output "web_subnet_id" {
  description = "Unique identifier of the public web tier subnet"
  value = "${aws_subnet.web_subnet.id}"
}

output "app_subnet_id" {
  description = "Unique identifier of the private application tier subnet"
  value = "${aws_subnet.app_subnet.id}"
}

output "data_subnet_id" {
  description = "Unique identifier of the private data tier subnet"
  value = "${aws_subnet.app_subnet.id}"
}
