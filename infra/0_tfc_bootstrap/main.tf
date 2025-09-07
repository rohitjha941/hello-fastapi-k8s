# Main configuration file for Terraform Cloud bootstrap
# This module creates and manages all Terraform Cloud workspaces,
# variable sets, teams, and access controls for the hello-fastapi-k8s project.

# All configuration is split into logical files:
# - versions.tf: Terraform and provider version constraints
# - providers.tf: Provider configurations
# - data.tf: Data sources
# - locals.tf: Local values and computed configurations
# - project.tf: TFC project configuration
# - variable_sets.tf: Variable sets and variables
# - workspaces.tf: Workspace definitions
# - workspace_variables.tf: Workspace-specific variables
# - run_triggers.tf: Dependencies between workspaces
# - teams.tf: Team and access control configuration
# - notifications.tf: Notification settings (placeholder)
# - variables.tf: Input variables
# - outputs.tf: Output values