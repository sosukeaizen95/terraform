terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}
provider "aws" {
  region = var.region
}

data "aws_ami" "linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-202*"]
  }
}

resource "aws_security_group" "ssh" {
  name        = "sec_group"
  description = "Security Group to allow SSH connection"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ns_ec2_1" {

  ami             = data.aws_ami.linux.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ssh.id]
  key_name        = var.key_name
  subnet_id       = var.subnet_id

  tags = {
    Name = "aws_ns_ec2_1"
  }
  depends_on = [aws_security_group.ssh]
}
