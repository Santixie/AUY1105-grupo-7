output "vpc_id" {
  description = "ID de la VPC creada por el módulo de redes"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "IDs de las subredes creadas por el módulo de redes"
  value       = module.vpc.subnet_ids
}

output "instance_id" {
  description = "ID de la instancia EC2 creada por el módulo de cómputo"
  value       = module.ec2.instance_id
}

output "instance_ip" {
  description = "Dirección IP privada de la instancia EC2"
  value       = module.ec2.instance_ip
}
