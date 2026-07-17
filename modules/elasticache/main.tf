resource "aws_elasticache_subnet_group" "elasticache-subnet-group" {
  name       = "${var.cluster_id}-subnets"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "elasticache-voting" {
  cluster_id         = var.cluster_id
  engine             = "redis"
  engine_version     = var.engine_version
  node_type          = var.node_type
  num_cache_nodes    = var.num_cache_nodes
  subnet_group_name  = aws_elasticache_subnet_group.elasticache-subnet-group.name
  security_group_ids = var.security_group_ids
}