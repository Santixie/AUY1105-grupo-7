# Ejemplo de uso: Módulo EC2

Este ejemplo muestra cómo utilizar el módulo `ec2` para desplegar una instancia EC2 en AWS dentro de una subred y security group existentes.

## Recursos que se crean

- Instancia EC2 con la AMI y tipo de instancia configurados

## Prerequisitos

- Una VPC desplegada con al menos una subred y un security group. Se puede usar el módulo `vpc` de este mismo repositorio.

## Uso

```hcl
module "ec2" {
  source = "../"

  ami_id                 = "ami-0e86e20dae9224db8"
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.subnet_ids[0]
  vpc_security_group_ids = [module.vpc.security_group_id]
  environment            = "dev"
  project_name           = "mi-proyecto"
}
```

## Variables

| Variable | Tipo | Descripción | Valor por defecto |
|---|---|---|---|
| `ami_id` | string | ID de la AMI para la instancia | requerido |
| `instance_type` | string | Tipo de instancia EC2 | `t2.micro` |
| `subnet_id` | string | ID de la subred donde se despliega | requerido |
| `vpc_security_group_ids` | list(string) | Lista de IDs de security groups | requerido |
| `environment` | string | Entorno (dev, staging, prod) | `dev` |
| `project_name` | string | Nombre del proyecto para etiquetas | `AUY1105` |

## Outputs

| Output | Descripción |
|---|---|
| `instance_id` | ID de la instancia EC2 creada |
| `instance_ip` | Dirección IP privada de la instancia |

## Pasos para ejecutar el ejemplo

1. Actualizar `subnet_id` y `vpc_security_group_ids` con valores reales
2. Configurar credenciales de AWS
3. Ejecutar `terraform init`
4. Ejecutar `terraform plan` para revisar los cambios
5. Ejecutar `terraform apply` para desplegar
6. Ejecutar `terraform destroy` al terminar para limpiar los recursos
