variable "aws_region" {
  default     = "ap-southeast-2"
  description = "The AWS region to deploy resources in"
  type = string
}

variable "profile" {
  default     = "zuguangt"
  description = "The AWS profile to use"
  type = string
}

variable "instance_type" {
  default     = "t2.nano"
  description = "The type of instance to create"
  type = string
}

variable "instance_type_list" {
  description = "EC2 Instance Type List"
  type = list(string)
  default = ["t2.nano", "t2.micro", "t2.small"]
}

variable "instance_type_map" {
  description = "EC2 Instance Type Map"
  type = map(string)
  default = {
    "dev" = "t2.nano"
    "test" = "t2.micro"
    "prod" = "t2.small"
  }
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

variable "instance_keypair" {
  default     = "terraform-starter-key-pair"
  description = "The key pair to use for the EC2 instance"
  type = string
}