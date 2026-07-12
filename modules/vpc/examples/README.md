# Ejemplo de uso — Módulo VPC

Este ejemplo muestra cómo usar el módulo `vpc` para crear una VPC con dos subnets y un security group personalizado.

## Recursos que se crean

- 1 VPC con CIDR `10.10.0.0/16`
- 2 Subnets (`10.10.1.0/24` y `10.10.2.0/24`)

## Uso

```bash
cd examples/
terraform init
terraform plan
terraform apply
```

## Variables de ejemplo

| Variable       | Valor usado        |
|----------------|--------------------|
| `project_name` | `ejemplo-vpc`      |
| `environment`  | `dev`              |
| `vpc_cidr`     | `10.10.0.0/16`     |
| `subnet_cidrs` | dos subnets /24    |

## Outputs

| Output       | Descripción                   |
|--------------|-------------------------------|
| `vpc_id`     | ID de la VPC creada           |
| `subnet_ids` | Lista de IDs de las subnets   |
