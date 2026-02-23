

resource "aws_instance" "terraform_ec2" {
  ami = data.aws_ami.amzlinux.id
  instance_type = var.instance_type
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  count = 3
  tags = {
    Name = "TerraformEC2Instance=${count.index + 1}"
  }
}

locals {
  bucket-name-prefix = "${var.app_name}-${var.environment_name}"
}

# module "ec2_cluster" {
#   source = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 6.2"
#   name = "terraform-ec2-cluster"
#   ami = data.aws_ami.amzlinux.id
#   instance_type = var.instance_type
#   count = 3
#   monitoring = true
#   key_name = "terraform-starter-key-pair"
#   vpc_security_group_ids = ["sg-033ea6e3eaa6c12c1"]
#   subnet_id = "subnet-081a5711bd720fe90"
#   user_data = file("app1-install.sh")
#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }