output "id" {
  description = "ID of the variable set"
  value       = tfe_variable_set.this.id
}

output "name" {
  description = "Name of the variable set"
  value       = tfe_variable_set.this.name
}

output "variable_ids" {
  description = "Map of variable names to their IDs"
  value       = { for k, v in tfe_variable.this : k => v.id }
}