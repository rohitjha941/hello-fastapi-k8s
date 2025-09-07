terraform {
  required_version = "~> 1.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "0.67.1"
    }
  }

  cloud {
    organization = "rohit-jha"
    workspaces {
      name = "hello-fastapi-k8s-base-dev"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.name
      Environment = var.environment
      ManagedBy   = "terraform"
      Component   = "base"
    }
  }
}

provider "tfe" {}

