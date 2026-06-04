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
│   ├── vpc/              # Módulo de redes (VPC, subnet, security group)
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
- Subred dentro de la VPC
- Security group con reglas de acceso SSH restringido

**Outputs principales:** `vpc_id`, `subnet_ids`, `security_group_id`

### Módulo EC2 (`modules/ec2`)
Gestiona el despliegue de instancias de cómputo en AWS:
- Instancia EC2 con AMI y tipo de instancia configurables
- Asociación con subred y security group existentes

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
| `subnet_cidr` | CIDR de la subred | `10.1.1.0/24` |
| `environment` | Entorno de despliegue | `dev` |
| `project_name` | Nombre del proyecto | `AUY1105-miapp` |
| `ssh_ingress_cidr` | CIDR con acceso SSH | `10.1.0.0/16` |
| `ami_id` | ID de la AMI | `ami-0e86e20dae9224db8` |
| `instance_type` | Tipo de instancia | `t2.micro` |

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
2. **Checkov** — análisis de seguridad sobre los tres directorios anteriores
3. **Conftest (OPA)** — validación de políticas sobre el código Terraform principal
4. **terraform validate** — validación de sintaxis del código principal

## Versionado

Este proyecto sigue el estándar de [Versionado Semántico](https://semver.org/). Los módulos siguen su propio ciclo de versiones, documentado en el [CHANGELOG](./CHANGELOG.md).
