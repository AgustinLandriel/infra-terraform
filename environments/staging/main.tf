module "rds" {
  source                 = "../modules/rds"
  identifier             = "${var.cluster_name}-postgres"
  instance_class         = "db.t3.micro"
  secret_name            = "postgres-secret"
  subnet_ids             = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.postgres.id]
  secret                 = "voting-app"
}