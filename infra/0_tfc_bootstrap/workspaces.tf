# IPAM workspace (global, no environment)
resource "tfe_workspace" "ipam" {
  name         = "ipam-global"
  organization = data.tfe_organization.main.name
  project_id   = tfe_project.hello_fastapi.id
  description  = "IP Address Management - Global"
  
  vcs_repo {
    identifier     = var.github_repository
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
    branch         = "main"
  }
  
  working_directory = "infra/1_ipam"
  
  auto_apply            = false
  file_triggers_enabled = true
  trigger_patterns      = ["infra/1_ipam/**/*"]
  global_remote_state   = true  # Allow other workspaces to access state
  terraform_version     = "~> 1.5"
  
  tag_names = ["ipam", "global", "networking"]
}

# Create workspaces for each layer and environment
resource "tfe_workspace" "main" {
  for_each = local.workspace_map
  
  name         = each.value.name
  organization = data.tfe_organization.main.name
  project_id   = tfe_project.hello_fastapi.id
  description  = "${title(each.value.layer)} infrastructure - ${upper(each.value.environment)}"
  
  vcs_repo {
    identifier     = var.github_repository
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
    branch         = each.value.environment == "prod" ? "main" : each.value.environment
  }
  
  working_directory     = each.value.path
  auto_apply           = each.value.auto_apply
  file_triggers_enabled = true
  trigger_patterns     = ["${each.value.path}/**/*"]
  terraform_version    = "~> 1.5"
  
  tag_names = [
    each.value.layer,
    each.value.environment,
    each.value.auto_apply ? "auto-apply" : "manual-apply"
  ]
}