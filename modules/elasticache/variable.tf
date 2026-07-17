variable "cluster_id" {
  type = string
}

variable "node_type" {
  default = "cache.t3.micro"
}

variable "num_cache_nodes" {
  default = 1
}

variable "engine_version" {
  default = "7.1"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}
