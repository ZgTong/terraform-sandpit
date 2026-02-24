terraform {
  required_version = ">=1.14"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>6.33"
    }
  }

  # TODO: chicken and egg problem - as the bucket and table for remote state doesn't exist, we can't use remote state backend in this code. We can create the bucket and table manually and then use remote state backend.
  backend "s3" {
    bucket = "zuguangt-terraform-state"
    key    = "sandpit/terraform.tfstate"
    region = "ap-southeast-2"
    profile = "zuguangt"

    dynamodb_table = "zuguangt-terraform-state-locking"
  }
}

provider "aws" {
  region = var.aws_region
  profile = var.profile
}