variable "organization" {
  description = "Terraform Cloud organization name"
  type        = string
}

variable "name" {
  description = "Name of the variable set"
  type        = string
}

variable "description" {
  description = "Description of the variable set"
  type        = string
  default     = ""
}

variable "global" {
  description = "Whether the variable set is globally available to all workspaces"
  type        = bool
  default     = false
}

variable "project_id" {
  description = "ID of the project to associate the variable set with (if not global)"
  type        = string
  default     = null
}

variable "workspace_ids" {
  description = "List of workspace IDs to apply the variable set to"
  type        = list(string)
  default     = []
}

variable "variables" {
  description = "Map of variables to create in the variable set"
  type = map(object({
    value       = string
    category    = string
    hcl         = optional(bool, false)
    sensitive   = optional(bool, false)
    description = optional(string, "")
  }))
  default = {}
}