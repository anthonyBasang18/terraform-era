provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

terraform {
  backend "s3" {
    bucket = "cloud-foundation-terraform"
    key    = "project/test/terraform.tfstate"
    region = "ap-southeast-1"
    # dynamodb_table = "terraform-lock-table"
    # encrypt        = true
  }
}
