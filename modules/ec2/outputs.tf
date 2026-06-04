output "instance_id" {
  description = "ID de la instancia EC2 creada"
  value       = aws_instance.this.id
}

output "instance_ip" {
  description = "Dirección IP privada de la instancia EC2"
  value       = aws_instance.this.private_ip
}

output "instance_public_ip" {
  description = "Dirección IP pública de la instancia EC2 (si fue asignada)"
  value       = aws_instance.this.public_ip
}

output "instance_arn" {
  description = "ARN de la instancia EC2"
  value       = aws_instance.this.arn
}
