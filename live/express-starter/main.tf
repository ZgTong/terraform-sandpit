module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "${var.aws_region}a"
  project_name        = var.project_name
}

module "bastion" {
  source = "../../modules/bastion"

  depends_on = [module.vpc]

  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
  allowed_ip    = var.allowed_ip
  project_name  = var.project_name
  instance_type = "t3.nano"
}

module "database" {
  source = "../../modules/database"

  depends_on = [module.vpc]

  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.private_subnet_id
  bastion_sg_id = module.bastion.bastion_security_group_id
  vpc_cidr      = module.vpc.vpc_cidr
  db_password   = var.db_password
  project_name  = var.project_name
  instance_type = "t3.micro"
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "db_private_ip" {
  value = module.database.db_private_ip
}

output "db_instance_id" {
  value = module.database.db_instance_id
}
