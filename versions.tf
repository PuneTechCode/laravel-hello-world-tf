terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
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