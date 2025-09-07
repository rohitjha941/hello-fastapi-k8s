# Global variable set for AWS credentials
resource "tfe_variable_set" "aws_credentials" {
  name         = "aws-global-credentials"
  description  = "AWS credentials for all workspaces"
  organization = data.tfe_organization.main.name
  global       = true
}

resource "tfe_variable" "aws_access_key_id" {
  key             = "AWS_ACCESS_KEY_ID"
  value           = var.aws_access_key_id
  category        = "env"
  sensitive       = true
  variable_set_id = tfe_variable_set.aws_credentials.id
}

resource "tfe_variable" "aws_secret_access_key" {
  key             = "AWS_SECRET_ACCESS_KEY"
  value           = var.aws_secret_access_key
  category        = "env"
  sensitive       = true
  variable_set_id = tfe_variable_set.aws_credentials.id
}

# Environment-specific variable sets
resource "tfe_variable_set" "env" {
  for_each = toset(["dev", "staging", "prod"])
  
  name         = "${each.key}-environment"
  description  = "Variables for ${each.key} environment"
  organization = data.tfe_organization.main.name
}

resource "tfe_project_variable_set" "env_assignment" {
  for_each = tfe_variable_set.env
  
  variable_set_id = each.value.id
  project_id      = tfe_project.hello_fastapi.id
}

# Common tags variable set
resource "tfe_variable_set" "common_tags" {
  name         = "common-tags"
  description  = "Common tags for all resources"
  organization = data.tfe_organization.main.name
}

resource "tfe_project_variable_set" "tags_assignment" {
  variable_set_id = tfe_variable_set.common_tags.id
  project_id      = tfe_project.hello_fastapi.id
}

resource "tfe_variable" "common_tags" {
  key     = "common_tags"
  value   = jsonencode({
    Project     = "hello-fastapi-k8s"
    ManagedBy   = "terraform"
    Repository  = var.github_repository
  })
  category        = "terraform"
  hcl             = true
  variable_set_id = tfe_variable_set.common_tags.id
}