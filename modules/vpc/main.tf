resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      Name        = "${var.project_name}-vpc"
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_subnet" "this" {
  count = length(var.subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = length(var.availability_zones) > 0 ? var.availability_zones[count.index] : null

  tags = merge(
    {
      Name        = "${var.project_name}-subnet-${count.index + 1}"
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_security_group" "this" {
  name        = "${var.project_name}-sg"
  description = "Security group gestionado por el modulo vpc"
  vpc_id      = aws_vpc.this.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = lookup(ingress.value, "description", "")
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite todo el trafico saliente"
  }

  tags = merge(
    {
      Name        = "${var.project_name}-sg"
      Environment = var.environment
    },
    var.tags
  )
}
