variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "subnet_id" {
  type        = string
  description = "The public subnet ID where Bastion will be placed"
}

variable "allowed_ip" {
  type        = string
  description = "The IP address allowed to SSH into the Bastion"
}

variable "project_name" {
  type        = string
  description = "Project name used for tagging"
  default     = "express-starter"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the Bastion host"
  default     = "t3.nano"
}
