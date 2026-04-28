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

## [1.4.0] - 2026-04-27
### Fixed
- Eliminado `soft_fail: true` en Checkov para que el pipeline falle ante vulnerabilidades de seguridad
### Added
- Archivo `.tflint.hcl` con plugin AWS y reglas de nomenclatura, documentación y versión requerida
- Job `opa-validate` en el workflow: genera plan Terraform en JSON y ejecuta políticas OPA con Conftest


## [1.5.0] - 2026-04-27
### Fixed
- Corregir vulnerabilidades detectadas por Checkov en main.tf
- Agregar descripción al Security Group y sus reglas (CKV_AWS_23)
- Restringir egress del Security Group a CIDR de la VPC (CKV_AWS_382)
- Habilitar monitoreo detallado en EC2 (CKV_AWS_126)
- Cifrar volumen EBS raíz de EC2 (CKV_AWS_8)
- Forzar IMDSv2 en EC2 (CKV_AWS_79)
- Agregar IAM Role e Instance Profile para EC2 (CKV2_AWS_41)
- Agregar VPC Flow Logs con CloudWatch y rol IAM (CKV2_AWS_11)
- Bloquear default security group de la VPC (CKV2_AWS_12)
### Changed
- Skip solo CKV_AWS_135 en Checkov: t2.micro no soporta EBS optimizado


