# AUY1105-grupo-7

## Descripción
Repositorio del proyecto de Infraestructura como Código (IaC)
para la asignatura AUY1105 - Infraestructura como código II.

## Objetivo
Implementar módulos reutilizables de Terraform para gestionar infraestructura en AWS, siguiendo buenas prácticas de codificación, documentación y versionado semántico.

## Estructura del repositorio
```
├── terraform/            # Código principal que orquesta los módulos
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── versions.tf
├── modules/
│   ├── vpc/              # Módulo de redes (VPC, subnet)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── versions.tf
│   │   └── examples/
│   └── ec2/              # Módulo de cómputo (instancia EC2)
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── versions.tf
│       └── examples/
├── .github/
│   └── workflows/        # GitHub Actions
├── policies/             # Políticas OPA
├── .gitignore
├── CHANGELOG.md
└── README.md
```

## Integrantes
- Benjamin Santis (@Santixie)
- Jose Osorio (@Cosm09)
- Katalina Inostroza (@katalinaino)

## Módulos

### Módulo VPC (`modules/vpc`)
Gestiona la creación de la red base en AWS:
- VPC con bloque CIDR configurable
- Una o más subredes dentro de la VPC, definidas mediante `for_each` sobre una lista de CIDRs

> **Nota:** hasta la versión `v1.0.0`, este módulo también gestionaba un `aws_security_group`. A partir de `v2.0.0` ese recurso fue removido del módulo (ver Escenario 3 de la EP3): el security group ahora se gestiona fuera de Terraform y se referencia desde `terraform/main.tf` mediante la variable `existing_security_group_id`.

**Outputs principales:** `vpc_id`, `subnet_ids`, `subnet_cidrs`

### Módulo EC2 (`modules/ec2`)
Gestiona el despliegue de instancias de cómputo en AWS:
- Instancia EC2 con AMI y tipo de instancia configurables
- Asociación con subred y security groups existentes

**Outputs principales:** `instance_id`, `instance_ip`

## Instrucciones de uso

### Prerrequisitos
- Terraform >= 1.0.0
- Credenciales de AWS configuradas (`aws configure`)

### Despliegue

1. Clonar el repositorio
2. Ingresar a la carpeta `terraform/`
3. Inicializar los módulos y proveedores:
   ```bash
   terraform init
   ```
4. Revisar los cambios antes de aplicar:
   ```bash
   terraform plan
   ```
5. Aplicar la infraestructura:
   ```bash
   terraform apply
   ```

### Variables configurables

| Variable | Descripción | Valor por defecto |
|---|---|---|
| `region` | Región de AWS | `us-east-1` |
| `vpc_cidr` | CIDR de la VPC | `10.1.0.0/16` |
| `subnet_cidrs` | Lista de CIDRs de subredes | `["10.1.1.0/24"]` |
| `environment` | Entorno de despliegue | `dev` |
| `project_name` | Nombre del proyecto | `AUY1105-miapp` |
| `ami_id` | ID de la AMI | `ami-0e86e20dae9224db8` |
| `instance_type` | Tipo de instancia | `t2.micro` |
| `existing_security_group_id` | ID del security group gestionado fuera de Terraform | `sg-0dbcde7ac47e9d869` |

### Outputs

| Output | Descripción |
|---|---|
| `vpc_id` | ID de la VPC creada |
| `subnet_ids` | IDs de las subredes |
| `instance_id` | ID de la instancia EC2 |
| `instance_ip` | IP privada de la instancia EC2 |

## Automatización (CI)

El workflow `.github/workflows/terraform-ci.yml` se ejecuta en cada pull request hacia `main` y realiza:
1. **TFLint** — análisis estático sobre `terraform/`, `modules/vpc` y `modules/ec2`
2. **Checkov** — análisis de seguridad sobre los tres directorios anteriores (modo informativo, `soft_fail`)
3. **Conftest (OPA)** — validación de políticas sobre el código Terraform principal, actúa como gate de aprobación/denegación
4. **terraform validate** — validación de sintaxis del código principal

Adicionalmente, la rama `main` está protegida y requiere al menos una aprobación de un integrante con permisos de escritura antes de permitir el merge.

## Versionado

Este proyecto sigue el estándar de [Versionado Semántico](https://semver.org/). Los módulos siguen su propio ciclo de versiones, publicado mediante tags de Git (`modules/vpc/vX.Y.Z`, `modules/ec2/vX.Y.Z`) y consumido desde `terraform/main.tf` mediante referencia versionada (`?ref=`). La evolución de cada versión está documentada en el [CHANGELOG](./CHANGELOG.md).