terraform {
  required_version = ">=1.14"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>6.33"
    }
  }
  # backend "s3" {
  #   bucket = "zuguangt-terraform-sandpit-state"
  #   key    = "terraform.tfstate"
  #   region = "ap-southeast-2"
  #   # state locking with DynamoDB
  #   dynamodb_table = "terraform-sandpit-state-table"
  # }
}

provider "aws" {
  region = "ap-southeast-2"
  profile = "zuguangt"
}

resource "aws_instance" "terraform_ec2" {
  ami           = "ami-0a11f7293cd9a562e"
  instance_type = var.instance_type
  tags = {
    Name = "Terraform Managed EC2 Instance"
  }
}

variable "instance_type" {
  default     = "t2.nano"
  description = "The type of instance to create"
  type = string
}

variable "app_name" {
  default     = "my-app"
  description = "The name of the application"
  type = string
}

variable "environment_name" {
  default     = "dev"
  description = "The environment name"
  type = string
}

output "ec2_instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value = aws_instance.terraform_ec2.public_ip
}

locals {
  bucket-name-prefix = "${var.app_name}-${var.environment_name}"
}

data "aws_ami" "amzlinux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.2"
  name = "terraform-ec2-cluster"
  ami = data.aws_ami.amzlinux.id
  instance_type = var.instance_type
  count = 3
  monitoring = true
  key_name = "terraform-starter-key-pair"
  vpc_security_group_ids = ["sg-033ea6e3eaa6c12c1"]
  subnet_id = "subnet-081a5711bd720fe90"
  user_data = file("app1-install.sh")
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}