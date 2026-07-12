variable "project_name" {
  description = "Nombre del proyecto, usado como prefijo en los recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "Lista de bloques CIDR para las subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad para las subnets"
  type        = list(string)
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Mapa de etiquetas adicionales para todos los recursos"
  type        = map(string)
  default     = {}
}
