provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../"

  project_name = "ejemplo-vpc"
  environment  = "dev"
  vpc_cidr     = "10.10.0.0/16"
  subnet_cidrs = ["10.10.1.0/24", "10.10.2.0/24"]

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["10.10.0.0/16"]
      description = "SSH solo desde la VPC"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["10.10.0.0/16"]
      description = "HTTP desde la VPC"
    }
  ]

  tags = {
    Project = "AUY1105"
    Owner   = "grupo-7"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}
