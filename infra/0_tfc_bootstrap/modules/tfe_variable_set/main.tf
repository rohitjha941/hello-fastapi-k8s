resource "tfe_variable_set" "this" {
  name         = var.name
  description  = var.description
  organization = var.organization
  global       = var.global
}

resource "tfe_variable" "this" {
  for_each = var.variables

  key             = each.key
  value           = each.value.value
  category        = each.value.category
  hcl             = each.value.hcl
  sensitive       = each.value.sensitive
  description     = each.value.description
  variable_set_id = tfe_variable_set.this.id
}

resource "tfe_project_variable_set" "this" {
  variable_set_id = tfe_variable_set.this.id
  project_id      = var.project_id
}

resource "tfe_workspace_variable_set" "this" {
  for_each = toset(var.workspace_ids)

  variable_set_id = tfe_variable_set.this.id
  workspace_id    = each.value
}