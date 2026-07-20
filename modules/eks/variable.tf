variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  default = "1.36"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "node_instance_type" {
  default = "t3.medium"
}

variable "node_ami_type" {
  default = "AL2023_x86_64_STANDARD"
}

variable "node_min_size" {
  default = 2
}

variable "node_max_size" {
  default = 4
}

variable "node_desired_size" {
  default = 2
}
