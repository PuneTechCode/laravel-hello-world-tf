terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
  }
  backend "s3" {
    bucket  = "terraform-backend-ap-south-1-rajpawaritworks"
    key     = "dev-laravel-app"
    region  = "ap-south-1"
    profile = "dev"
  }
}

provider "aws" {
  region  = var.region
  profile = "dev"
  default_tags {
    tags = {
      App         = "laravel",
      Environment = "dev",
      Owner       = "SRE"
    }
  }
}