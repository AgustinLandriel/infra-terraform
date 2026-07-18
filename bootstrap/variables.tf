variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "state_bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
  type        = string
  default     = "voting-app-terraform-state-325503636955"
}

variable "lock_table_name" {
  description = "The name of the DynamoDB table to lock Terraform state"
  type        = string
  default     = "voting-app-terraform-lock"
}

variable "github_repo" {
  description = "GitHub repo in format owner/repo"
  type        = string
  default     = "AgustinLandriel/infra-terraform"
}

variable "github_actions_role_name" {
  description = "Name of the IAM role assumed by GitHub Actions"
  type        = string
  default     = "github-actions-terraform"
}
