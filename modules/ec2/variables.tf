variable "project_name" {
  description = "Nombre del proyecto, usado como prefijo en los recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "ami_id" {
  description = "ID de la AMI para la instancia EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "ID de la subnet donde se desplegará la instancia"
  type        = string
}

variable "security_group_ids" {
  description = "Lista de IDs de security groups asociados a la instancia"
  type        = list(string)
}

variable "associate_public_ip" {
  description = "Asociar una IP pública a la instancia"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Mapa de etiquetas adicionales para todos los recursos"
  type        = map(string)
  default     = {}
}
