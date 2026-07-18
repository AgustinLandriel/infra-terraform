output "state_bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "lock_table_name" {
  description = "The name of the DynamoDB table to lock Terraform state"
  value       = aws_dynamodb_table.lock_table.name
}

output "github_actions_role_arn" {
  description = "ARN of the IAM role assumed by GitHub Actions via OIDC"
  value       = aws_iam_role.github_actions_terraform.arn
}
