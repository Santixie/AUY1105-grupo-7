# Changelog

## [1.0.0] - 2024-11-01
### Added
- Configuración inicial del repositorio
- Archivo README.md con descripción del proyecto
- Archivo .gitignore para excluir archivos sensibles
- Archivo CHANGELOG.md para registro de cambios

## [1.1.0] - 2024-11-01
### Added
- Código Terraform para infraestructura AWS
- VPC con CIDR 10.1.0.0/16
- Subred con máscara /24
- Security Group con acceso SSH restringido a 10.1.0.0/16
- Instancia EC2 Ubuntu 24.04 LTS tipo t2.micro

## [1.2.0] - 2024-11-01
### Added
- Workflow de automatización con GitHub Actions
- Análisis estático con TFLint
- Análisis de seguridad con Checkov
- Validación con terraform validate
- Workflow activado solo por pull request hacia main

## [1.3.0] - 2024-11-01
### Added
- Políticas de seguridad con OPA
- Política para bloquear SSH público
- Política para restringir tipo de instancia a t2.micro

---

## Módulo VPC

### [v0.1.0] - 2024-11-15
### Added
- Estructura inicial del módulo VPC
- Archivos main.tf, variables.tf, outputs.tf, versions.tf
- Recursos: aws_vpc, aws_subnet, aws_security_group parametrizados

### [v1.0.0] - 2024-11-15
### Added
- Módulo VPC estable y funcional
- Carpeta examples/ con ejemplo de uso y README
- Output security_group_id añadido

---

## Módulo EC2

### [v0.1.0] - 2024-11-15
### Added
- Estructura inicial del módulo EC2
- Archivos main.tf, variables.tf, outputs.tf, versions.tf
- Recurso: aws_instance parametrizado

### [v1.0.0] - 2024-11-15
### Added
- Módulo EC2 estable y funcional
- Carpeta examples/ con ejemplo de uso y README
- Output instance_ip añadido

---

## [2.0.0] - 2024-11-15
### Changed
- Refactorización completa del código Terraform en módulos independientes
- terraform/main.tf reescrito para consumir los módulos vpc y ec2
- terraform/variables.tf ampliado con variables de red y proyecto
- terraform/outputs.tf actualizado con outputs de ambos módulos
### Added
- Módulo reutilizable de redes en modules/vpc/
- Módulo reutilizable de cómputo en modules/ec2/
- Archivo versions.tf en cada módulo y en terraform/
- Carpeta examples/ en cada módulo con ejemplos funcionales
- Workflow CI actualizado para validar módulos con TFLint y Checkov
- README.md actualizado con nueva estructura modular
