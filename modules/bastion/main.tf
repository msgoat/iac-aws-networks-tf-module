# main.tf
# Module: nat-gateway

# Local values used in this module
locals {
  nat_common_tags = merge(var.common_tags)
  bastion_name    = lower(var.network_name)
}

# Retrieve information about the specified VPC
data "aws_vpc" "vpc" {
  id = var.network_id
}

# Retrieve information about the specified Availability Zone
data "aws_availability_zone" "zone" {
  name = var.zone_name
}

# Retrieve information about the public subnet of the specified availability zone
# supposed to host the NAT Gateway
data "aws_subnet" "public_subnet" {
  vpc_id               = data.aws_vpc.vpc.id
  availability_zone_id = data.aws_availability_zone.zone.zone_id
  id                   = var.public_subnet_id
}

# Bastion EC2 instance ---------------------------------------------------------------

resource "aws_instance" "bastion" {
  ami                         = var.bastion_ami_id
  availability_zone           = data.aws_availability_zone.zone.name
  instance_type               = var.bastion_instance_type
  key_name                    = var.bastion_key_pair_name
  vpc_security_group_ids      = [aws_security_group.bastion_security_group.id]
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  root_block_device {
    volume_type = var.bastion_root_volume_type
    volume_size = var.bastion_root_volume_size
  }
  tags = merge(map(
    "Name", "ec2-${data.aws_availability_zone.zone.name}-${local.bastion_name}-bastion",
    "Role", "bastion"
  ), local.nat_common_tags)
}

# Security group for bastion instance
resource "aws_security_group" "bastion_security_group" {
  name        = "sec-${data.aws_subnet.public_subnet.availability_zone}-${local.bastion_name}-bastion"
  description = "Controls all inbound and outbound traffic passed through the bastion instances"
  vpc_id      = data.aws_subnet.public_subnet.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_inbound_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # from here we have to connect to anything within this region
  }
  tags = merge(map(
    "Name", "sg-${data.aws_availability_zone.zone.name}-${local.bastion_name}-bastion"
  ), local.nat_common_tags)
}
