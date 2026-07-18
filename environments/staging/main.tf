terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source          = "../../modules/vpc"
  cluster_name    = var.cluster_name
  region          = var.region
  cidr            = var.cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

module "eks" {
  source             = "../../modules/eks"
  cluster_name       = var.cluster_name
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnets
  node_instance_type = var.node_instance_type
  node_min_size      = 2
  node_max_size      = 3
  node_desired_size  = 2
}

resource "aws_security_group" "postgres" {
  name_prefix = "${var.cluster_name}-postgres-"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redis" {
  name_prefix = "${var.cluster_name}-redis-"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "rds" {
  source                 = "../../modules/rds"
  identifier             = "${var.cluster_name}-postgres"
  instance_class         = "db.t3.micro"
  subnet_ids             = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.postgres.id]
  secret                 = "voting-app"
}

module "elasticache" {
  source             = "../../modules/elasticache"
  cluster_id         = "${var.cluster_name}-redis"
  node_type          = "cache.t3.micro"
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [aws_security_group.redis.id]
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "postgres_endpoint" {
  value = module.rds.endpoint
}

output "redis_endpoint" {
  value = module.elasticache.endpoint
}

output "configure_kubectl" {
  value = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
}
