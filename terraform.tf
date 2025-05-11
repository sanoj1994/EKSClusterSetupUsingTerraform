terraform {
  required_version = "~>1.11.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.96.0"
    }
  }


backend "s3" {
  region = "ap-south-1"
  dynamodb_table = "terraform-state-lock"
  profile = "terraformprofile"
}
}

provider "aws" {
  # Configuration options
  region  = "ap-south-1"
  profile = "terraformprofile"
}
