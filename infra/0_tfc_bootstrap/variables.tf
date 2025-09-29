variable "tfc_organization" {
  description = "Terraform Cloud organization name"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository in the format 'owner/repo'"
  type        = string
  default     = "rohitjha941/hello-fastapi-k8s"
}

variable "github_oauth_client_name" {
  description = "Name of the GitHub OAuth client in Terraform Cloud. Leave empty to skip VCS integration."
  type        = string
  default     = "GitHub"
}

variable "aws_regions" {
  description = "AWS regions for each environment"
  type        = map(string)
  default = {
    dev     = "us-west-2"
    staging = "us-west-2"
    prod    = "us-west-2"
  }
}

