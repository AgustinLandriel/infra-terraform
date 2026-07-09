terraform {
  backend "s3" {
    bucket         = "voting-app-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "voting-app-terraform-lock"
    encrypt        = true
  }
}
