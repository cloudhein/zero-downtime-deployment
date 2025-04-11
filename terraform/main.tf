data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create a Security Group for ssh connection
resource "aws_security_group" "ssh_sg" {
  name        = "ssh_sg"
  description = "Allow SSH and all outbound"
  vpc_id      = data.aws_vpc.default_vpc.id

  tags = {
    Name = "ssh_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_rules" {
  security_group_id = aws_security_group.ssh_sg.id

  cidr_ipv4   = local.anywhere
  from_port   = local.ssh_port
  ip_protocol = local.tcp_protocol
  to_port     = local.ssh_port
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ssh_sg.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = local.all_protocols_ports # semantically equivalent to all ports
}