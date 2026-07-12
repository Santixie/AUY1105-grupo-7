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

