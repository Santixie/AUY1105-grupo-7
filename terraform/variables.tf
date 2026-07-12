variable "region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto, usado para etiquetar los recursos"
  type        = string
  default     = "AUY1105-miapp"
}

variable "environment" {
  description = "Nombre del entorno de despliegue"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "subnet_cidrs" {
  description = "Lista de bloques CIDR para las subnets"
  type        = list(string)
  default     = ["10.1.1.0/24"]
}

variable "ami_id" {
  description = "ID de la AMI de Ubuntu 24.04 LTS"
  type        = string
  default     = "ami-0e86e20dae9224db8"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.small"
}

variable "existing_security_group_id" {
  description = "ID del security group existente, gestionado fuera de Terraform tras el Escenario 3 de la EP3"
  type        = string
  default     = "sg-0dbcde7ac47e9d869"
}
