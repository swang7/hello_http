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
  region  = "us-east-2"
}

variable "vpc_id" {}
variable "cidr" {}

resource "aws_security_group" "sg_ssh_only" {
  name = "sg_ssh_only"
  vpc_id = var.vpc_id
  
  tags = {
    Name = "HW5_ssh"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["73.93.72.74/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_hello_serv" {
  name = "sg_hello_serv"
  vpc_id = var.vpc_id
  
  tags = {
    Name = "HW5_server"
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [var.cidr]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["DevOps_hw5_ami_*"]
  }

  owners = ["107940293319"]
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_ssh_only.id, aws_security_group.sg_hello_serv.id]
  key_name = "aws_devops"

  tags = {
    Name = "hello_server"
  }
}

output "hostid" {
  value = aws_instance.server.*.public_dns
}