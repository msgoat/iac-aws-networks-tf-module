# retrieve latest AMI for NAT instances provided by AWS
data "aws_ami" "nat" {
  most_recent = true
  owners = ["137112412989"]  # Amazon EC2 AMI Account ID

  filter {
    name = "name"
    values = ["amzn-ami-vpc-nat-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# create NAT instance
resource "aws_instance" "nats" {
  count = local.allocation_size
  ami = data.aws_ami.nat.id
  instance_type = var.nat_instance_type
  subnet_id = local.public_subnets_by_zone[var.zone_names[count.index]][0]
  vpc_security_group_ids = [aws_security_group.nat.id]
  tags = merge(map(
  "Name", "ec2-${var.zone_names[count.index]}-${local.nat_name}-nat"
  ), local.nat_common_tags)
}
