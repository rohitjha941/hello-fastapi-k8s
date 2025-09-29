# Data source for current organization
data "tfe_organization" "main" {
  name = var.tfc_organization
}

# GitHub OAuth Client - Optional lookup
data "tfe_oauth_client" "github" {
  count            = var.github_oauth_client_name != "" ? 1 : 0
  organization     = data.tfe_organization.main.name
  service_provider = "github"
  name             = var.github_oauth_client_name
}