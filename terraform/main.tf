provider "aws" {
  region = var.region
}

module "vpc" {
  source = "git::https://github.com/Santixie/AUY1105-grupo-7.git//modules/vpc?ref=modules/vpc/v2.0.0"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
}

module "ec2" {
  source = "git::https://github.com/Santixie/AUY1105-grupo-7.git//modules/ec2?ref=modules/ec2/v1.0.0"

  project_name       = var.project_name
  environment        = var.environment
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.subnet_ids[0]
  security_group_ids = [var.existing_security_group_id]
}