terraform {
  required_version = ">= 1.0"
  
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.50"
    }
  }
  
  # This workspace manages other workspaces, so it should be created manually
  # or via CLI first, then connected to VCS
  cloud {
    organization = var.tfc_organization
    
    workspaces {
      name = "tfc-bootstrap"
    }
  }
}