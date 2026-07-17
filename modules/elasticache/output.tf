output "endpoint" {
  value = aws_elasticache_cluster.elasticache-voting.cache_nodes[1].address
}

output "port" {
  value = aws_elasticache_cluster.elasticache-voting.cache_nodes[0].port
}
