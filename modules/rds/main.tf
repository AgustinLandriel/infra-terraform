data "aws_secretsmanager_secret" "postgres" {
  name = var.secret
}

data "aws_secretsmanager_secret_version" "postgres" {
  secret_id = data.aws_secretsmanager_secret.postgres.id
}

locals {
  postgres_secret = jsondecode(data.aws_secretsmanager_secret_version.postgres.secret_string)
}


resource "aws_db_subnet_group" "postgres-subnet-group" {
  name       = "${var.identifier}-subnets"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "postgres" {
  identifier     = var.identifier
  engine         = "postgres"
  engine_version = var.engine_version

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  db_subnet_group_name   = aws_db_subnet_group.postgres-subnet-group.name
  vpc_security_group_ids = var.vpc_security_group_ids

  db_name  = local.postgres_secret.POSTGRES_DB
  username = local.postgres_secret.POSTGRES_USER
  password = local.postgres_secret.POSTGRES_PASSWORD

  publicly_accessible     = false
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
}
