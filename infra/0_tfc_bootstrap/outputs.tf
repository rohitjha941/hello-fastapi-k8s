output "workspace_ids" {
  description = "Map of workspace names to their IDs"
  value = merge(
    { "ipam-global" = tfe_workspace.ipam.id },
    { for k, v in tfe_workspace.main : k => v.id }
  )
}

output "workspace_urls" {
  description = "URLs to access each workspace"
  value = merge(
    { "ipam-global" = "https://app.terraform.io/app/${var.tfc_organization}/workspaces/${tfe_workspace.ipam.name}" },
    { for k, v in tfe_workspace.main : k => "https://app.terraform.io/app/${var.tfc_organization}/workspaces/${v.name}" }
  )
}

output "project_id" {
  description = "The ID of the Terraform Cloud project"
  value       = tfe_project.hello_fastapi.id
}

output "variable_set_ids" {
  description = "IDs of the variable sets"
  value = {
    aws_credentials = tfe_variable_set.aws_credentials.id
    common_tags     = tfe_variable_set.common_tags.id
    environments    = { for k, v in tfe_variable_set.env : k => v.id }
  }
}