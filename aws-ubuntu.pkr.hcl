packer {
  required_version = ">= 1.7.0"

  required_plugins {
    amazon = {
      version = ">= 1.0.0, <2.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_source_ami" {
  type    = string
  default = "ami-0360c520857e3138f"
}
variable "ami_name" {
  type    = string
  default = "jenkins_ami"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

source "amazon-ebs" "ubuntu" {
  ami_name        = "${var.ami_name}-${formatdate("YYYY_MM_DD_HHmmss", timestamp())}"
  instance_type   = var.instance_type
  region          = var.aws_region
  source_ami      = var.aws_source_ami
  ssh_username    = var.ssh_username
  ami_description = "AMI for setting up Jenkins"

  tags = {
    Name    = "Jenkins AMI"
    Builder = "Packer"
  }

  vpc_filter {
    filters = {
      "isDefault" : "true"
    }
  }

  ami_users = []
}

build {
  name    = "jenkins-ami"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    script = "scripts/setup.sh"
  }
}