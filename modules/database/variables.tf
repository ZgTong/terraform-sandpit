variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "subnet_id" {
  type        = string
  description = "The private subnet ID where Database will be placed"
}

variable "bastion_sg_id" {
  type        = string
  description = "Security Group ID of the Bastion Host"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block for allowing internal access"
}

variable "db_password" {
  type        = string
  description = "Initial password for PostgreSQL postgres user"
  sensitive   = true
}

variable "project_name" {
  type        = string
  default     = "express-starter"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}
