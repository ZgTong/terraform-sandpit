variable "aws_region" {
  type        = string
  description = "AWS Region to deploy to"
}

variable "allowed_ip" {
  type        = string
  description = "Your local IP address to allow SSH into Bastion"
}

variable "db_password" {
  type        = string
  description = "PostgreSQL password"
  sensitive   = true
}

variable "project_name" {
  type        = string
  default     = "express-starter"
}
