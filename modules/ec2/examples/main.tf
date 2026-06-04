provider "aws" {
  region = "us-east-1"
}

# Ejemplo asumiendo que ya existe una VPC y subred desplegadas
module "ec2" {
  source = "../"

  ami_id                 = "ami-0e86e20dae9224db8"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-xxxxxxxxxxxxxxxxx"
  vpc_security_group_ids = ["sg-xxxxxxxxxxxxxxxxx"]
  environment            = "dev"
  project_name           = "ejemplo-ec2"
}

output "instance_id" {
  description = "ID de la instancia EC2 del ejemplo"
  value       = module.ec2.instance_id
}

output "instance_ip" {
  description = "IP privada de la instancia EC2 del ejemplo"
  value       = module.ec2.instance_ip
}
