variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "state_bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
  type        = string
  default     = "voting-app-terraform-state"
}

variable "lock_table_name" {
  description = "The name of the DynamoDB table to lock Terraform state"
  type        = string
  default     = "voting-app-terraform-lock"
}
