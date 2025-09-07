variable "tfc_organization" {
  description = "Terraform Cloud organization name"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository in the format 'owner/repo'"
  type        = string
  default     = "yourusername/hello-flask-k8s"
}

variable "github_oauth_client_name" {
  description = "Name of the GitHub OAuth client in Terraform Cloud"
  type        = string
  default     = "GitHub"
}

variable "aws_access_key_id" {
  description = "AWS Access Key ID for Terraform Cloud"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key for Terraform Cloud"
  type        = string
  sensitive   = true
}

variable "aws_regions" {
  description = "AWS regions for each environment"
  type        = map(string)
  default = {
    dev     = "us-east-1"
    staging = "us-east-1"
    prod    = "us-west-2"
  }
}

