provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
}

module "ec2" {
  source = "../modules/ec2"

  project_name       = var.project_name
  environment        = var.environment
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.subnet_ids[0]
  security_group_ids = [var.existing_security_group_id]
}
