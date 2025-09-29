# Environment-specific variable sets
module "env_variable_sets" {
  for_each = toset(["dev", "staging", "prod"])
  source   = "./modules/tfe_variable_set"

  organization = data.tfe_organization.main.name
  name         = "${each.key}-environment"
  description  = "Variables for ${each.key} environment"
  project_id   = tfe_project.hello_fastapi.id
}

# Common tags variable set
module "common_tags" {
  source = "./modules/tfe_variable_set"

  organization = data.tfe_organization.main.name
  name         = "common-tags"
  description  = "Common tags for all resources"
  project_id   = tfe_project.hello_fastapi.id

  variables = {
    common_tags = {
      value = jsonencode({
        Project    = "hello-fastapi-k8s"
        ManagedBy  = "terraform"
        Repository = var.github_repository
      })
      category = "terraform"
      hcl      = true
    }
  }
}