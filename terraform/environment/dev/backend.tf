terraform {
  backend "s3" {
    bucket       = "backup-terraform-tf"
    key          = "IAC/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
