terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name        = "AUY1105-miapp-vpc"
    Environment = "dev"
  }
}

# Bloquear default security group de la VPC (CKV2_AWS_12)
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "AUY1105-miapp-default-sg"
    Environment = "dev"
  }
}

# Subred
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.1.0/24"
  tags = {
    Name        = "AUY1105-miapp-subnet"
    Environment = "dev"
  }
}

# Security Group
resource "aws_security_group" "main" {
  vpc_id      = aws_vpc.main.id
  description = "Security group para AUY1105-miapp: permite SSH interno"

  ingress {
    description = "SSH desde la VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  egress {
    description = "Trafico saliente restringido a la VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.1.0.0/16"]
  }

  tags = {
    Name        = "AUY1105-miapp-sg"
    Environment = "dev"
  }
}

# IAM Role para EC2 (CKV2_AWS_41)
resource "aws_iam_role" "ec2_role" {
  name = "AUY1105-miapp-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
  tags = {
    Name        = "AUY1105-miapp-ec2-role"
    Environment = "dev"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "AUY1105-miapp-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# CloudWatch Log Group para VPC Flow Logs (CKV2_AWS_11)
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name = "/aws/vpc/AUY1105-miapp-flow-logs"
  tags = {
    Name        = "AUY1105-miapp-flow-logs"
    Environment = "dev"
  }
}

resource "aws_iam_role" "flow_logs_role" {
  name = "AUY1105-miapp-flow-logs-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "vpc-flow-logs.amazonaws.com" }
    }]
  })
  tags = {
    Name        = "AUY1105-miapp-flow-logs-role"
    Environment = "dev"
  }
}

resource "aws_iam_role_policy" "flow_logs_policy" {
  name = "AUY1105-miapp-flow-logs-policy"
  role = aws_iam_role.flow_logs_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_flow_log" "main" {
  vpc_id          = aws_vpc.main.id
  traffic_type    = "ALL"
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_logs.arn
  tags = {
    Name        = "AUY1105-miapp-flow-log"
    Environment = "dev"
  }
}

# EC2
resource "aws_instance" "main" {
  ami                  = var.ami_id
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.main.id
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [aws_security_group.main.id]

  monitoring = true

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = {
    Name        = "AUY1105-miapp-ec2"
    Environment = "dev"
  }
}
