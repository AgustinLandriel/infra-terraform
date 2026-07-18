variable "identifier" {
  type = string
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "allocated_storage" {
  default = 20
}

variable "engine_version" {
  default = "15.4"
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "skip_final_snapshot" {
  default = true
}

variable "backup_retention_period" {
  default = 0
}

variable "secret" {
  type        = string
  description = "AWS Secret Manager"
}
