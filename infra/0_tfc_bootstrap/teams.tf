# Team access
resource "tfe_team" "developers" {
  name         = "developers"
  organization = data.tfe_organization.main.name
  visibility   = "secret"
  
  organization_access {
    read_workspaces   = true
    read_projects     = true
    manage_workspaces = false
  }
}

resource "tfe_team_project_access" "developer_access" {
  access     = "write"
  team_id    = tfe_team.developers.id
  project_id = tfe_project.hello_fastapi.id
}

# Production workspace restrictions
resource "tfe_team_access" "prod_restrictions" {
  for_each = {
    for ws in local.workspaces : ws.name => ws
    if ws.environment == "prod"
  }
  
  access       = "plan"
  team_id      = tfe_team.developers.id
  workspace_id = tfe_workspace.main[each.key].id
}