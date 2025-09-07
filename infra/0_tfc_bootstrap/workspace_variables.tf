# Workspace variables for environment
resource "tfe_variable" "environment" {
  for_each = local.workspace_map
  
  workspace_id = tfe_workspace.main[each.key].id
  key          = "environment"
  value        = each.value.environment
  category     = "terraform"
}

resource "tfe_variable" "aws_region" {
  for_each = local.workspace_map
  
  workspace_id = tfe_workspace.main[each.key].id
  key          = "aws_region"
  value        = var.aws_regions[each.value.environment]
  category     = "terraform"
}