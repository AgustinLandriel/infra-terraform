variable "aws_region" {
  default = "us-east-2"
}

variable "cluster_name" {
  default = "voting-app-staging"
}

variable "node_instance_type" {
  default = "t3.small"
}

variable "region" {
  type = set(string)
}

variable "private_subnets" {
  type = set(string)
}
variable "public_subnets" {
  type = set(string)
}

variable "cidr" {
  type = string
}
