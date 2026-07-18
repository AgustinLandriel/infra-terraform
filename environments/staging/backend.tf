terraform {
  backend "s3" {
    bucket       = "voting-app-terraform-state-325503636955"
    key          = "staging/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
    encrypt      = true
  }
}
