terraform {
  required_providers {
    local = {
      version = ">= 2.1.0"
    }
    aws = {
      version = ">= 3.28.0"
      source  = "hashicorp/aws"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=2.3.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

