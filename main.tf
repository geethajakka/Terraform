terraform {
   required_version = ">= 1.5.0"
   backend "s3" {
    bucket         = "mytfstatefile987"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    #encrypt        = true
    #dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
   region = "ap-south-1"
}