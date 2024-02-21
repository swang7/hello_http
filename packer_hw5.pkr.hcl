packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu" {
  ami_name = "DevOps_hw5_ami_${local.timestamp}"
  instance_type = "t2.micro"
  region        = "${var.my_region}"
  source_ami_filter {
    filters = {
      name                = "${var.source_ami_name}"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "file" {
    sources = ["dummy_serv.c", "hello_serv.service"]
    destination = "/home/ubuntu/"
  }

  provisioner "shell" {
    inline = [
      "ls /home/ubuntu",
      "echo 'Install packages with apt'",
      "sudo apt install build-essential -y",
      "sudo apt install bash -y",
      "echo 'building Hello server'",
      "sudo gcc -o dummyserv dummy_serv.c",
      "echo 'Setup the Hello server service with systemd'",
      "sudo cp /home/ubuntu/hello_serv.service /etc/systemd/system/hello_serv.service",
      "sudo systemctl enable hello_serv",
    ]
  }
}

variable "my_region" {
  type = string
  default = "us-east-2"
}

variable "source_ami_name" {
  type = string
  default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}
