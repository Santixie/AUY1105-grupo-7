output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = aws_vpc.this.cidr_block
}

output "subnet_ids" {
  description = "Lista de IDs de las subnets creadas"
  value       = aws_subnet.this[*].id
}

output "subnet_cidrs" {
  description = "Lista de bloques CIDR de las subnets creadas"
  value       = aws_subnet.this[*].cidr_block
}

output "security_group_id" {
  description = "ID del security group creado"
  value       = aws_security_group.this.id
}
