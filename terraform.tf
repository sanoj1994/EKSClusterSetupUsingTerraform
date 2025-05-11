terraform {
  required_version = "~>1.11.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.96.0"
    }
  }


backend "s3" {
   bucket = "terraform-lock-state-bucket-sanojtech"
   key = "eks/terraform.tfstate"
   region = "ap-south-1"
   use_lockfile = true 
 # region = "ap-south-1"
  #dynamodb_table = "terraform-state-lock"
  #profile = "terraformprofile"

}
}

provider "aws" {
  # Configuration options
  region  = "ap-south-1"
  profile = "terraformprofile"
}
