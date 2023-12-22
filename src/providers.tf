## TERRAFORM CONFIG

terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

## PROVIDERS ##

provider "aws" {
  region = var.aws_region
  access_key = ""
  secret_key = ""
}
