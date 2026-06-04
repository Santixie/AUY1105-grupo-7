provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"

  vpc_cidr         = var.vpc_cidr
  subnet_cidr      = var.subnet_cidr
  environment      = var.environment
  project_name     = var.project_name
  ssh_ingress_cidr = var.ssh_ingress_cidr
}

module "ec2" {
  source = "../modules/ec2"

  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.subnet_ids[0]
  vpc_security_group_ids = [module.vpc.security_group_id]
  environment            = var.environment
  project_name           = var.project_name
}
