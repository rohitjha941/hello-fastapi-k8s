variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "namespace" {
  description = "Target Kubernetes namespace"
  type        = string
}

variable "service_account_name" {
  description = "Service account name used by the workload"
  type        = string
}

variable "iam_role_name" {
  description = "Name for IAM role (IRSA)"
  type        = string
}

variable "managed_policy_arns" {
  description = "Map of managed policy ARNs to attach to the IAM role"
  type        = map(string)
  default     = {}
}

variable "application_name" {
  description = "Argo CD application / Helm release name"
  type        = string
}

variable "chart_repo" {
  description = "Helm chart repository URL"
  type        = string
}

variable "chart_name" {
  description = "Helm chart name"
  type        = string
}

variable "chart_version" {
  description = "Helm chart version"
  type        = string
}

variable "argocd_project" {
  description = "Argo CD project"
  type        = string
  default     = "default"
}

variable "argocd_namespace" {
  description = "Namespace where Argo CD is installed"
  type        = string
  default     = "argocd"
}

variable "cluster_server" {
  description = "Kubernetes API server URL"
  type        = string
  default     = "https://kubernetes.default.svc"
}

variable "extra_helm_values" {
  description = "Additional Helm values YAML"
  type        = string
  default     = ""
}

variable "sync_options" {
  description = "List of Argo CD sync options to apply to the application"
  type        = list(string)
  default     = ["CreateNamespace=true"]
}