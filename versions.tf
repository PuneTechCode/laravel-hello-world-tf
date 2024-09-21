terraform {
    required_version = ">=1.0.0"
    required_provider {
        aws = {
            source = "hashicorp/aws"
            version = ">=5.0"
        }
    }
}

provider "aws" {
    region = "ap-south-1"
    profile = "dev"
}