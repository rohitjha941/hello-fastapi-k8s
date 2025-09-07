# Run triggers for dependencies
resource "tfe_run_trigger" "dependencies" {
  for_each = {
    for ws in local.workspaces : ws.name => ws
    if length(ws.depends_on) > 0
  }
  
  workspace_id  = tfe_workspace.main[each.key].id
  sourceable_id = each.value.depends_on[0] == "ipam-global" ? 
    tfe_workspace.ipam.id : 
    tfe_workspace.main["${each.value.depends_on[0]}-${each.value.environment}"].id
}