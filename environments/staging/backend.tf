terraform {
  backend "s3" {
    bucket         = "voting-app/staging/terraform-state"
    key            = "terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "voting-app-terraform-lock"
    encrypt        = true
  }
}
