variable "cluster_name" {
  type = string
}


variable "region" {

  type        = set(string)
  description = "The AWS region to deploy resources"
}

variable "cidr" {
  type = string
}

variable "private_subnets" {

  type        = list(string)
  description = "The private subnets to deploy"
}


variable "public_subnets" {

  type        = list(string)
  description = "The public subnets to deploy"
}
