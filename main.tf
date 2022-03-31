terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.23"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}
