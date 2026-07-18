output "endpoint" {
  value = aws_elasticache_cluster.elasticache-voting.cache_nodes[0].address
}

output "port" {
  value = aws_elasticache_cluster.elasticache-voting.cache_nodes[0].port
}
