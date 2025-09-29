# TFE Variable Set Module

This module creates a Terraform Cloud/Enterprise variable set with associated variables and assignments.

## Features

- Create variable sets with multiple variables
- Support for global, project-level, or workspace-specific assignments
- Handles both environment and terraform variables
- Supports HCL values and sensitive variables

## Usage

```hcl
module "aws_credentials" {
  source = "./modules/tfe_variable_set"

  organization = "my-org"
  name         = "aws-credentials"
  description  = "AWS credentials for deployments"
  global       = true

  variables = {
    AWS_ACCESS_KEY_ID = {
      value     = var.aws_access_key_id
      category  = "env"
      sensitive = true
    }
    AWS_SECRET_ACCESS_KEY = {
      value     = var.aws_secret_access_key
      category  = "env"
      sensitive = true
    }
  }
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| organization | Terraform Cloud organization name | string | - |
| name | Name of the variable set | string | - |
| description | Description of the variable set | string | "" |
| global | Whether the variable set is globally available | bool | false |
| project_id | ID of the project to associate with | string | null |
| workspace_ids | List of workspace IDs to apply to | list(string) | [] |
| variables | Map of variables to create | map(object) | {} |

## Outputs

| Name | Description |
|------|-------------|
| id | ID of the variable set |
| name | Name of the variable set |
| variable_ids | Map of variable names to their IDs |