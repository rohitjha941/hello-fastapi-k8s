# Data source for current organization
data "tfe_organization" "main" {
  name = var.tfc_organization
}

# GitHub App Installation
data "tfe_github_app_installation" "github" {
  name = var.github_organization_name
}