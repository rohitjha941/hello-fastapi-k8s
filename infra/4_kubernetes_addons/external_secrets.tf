module "external_secrets" {
  source = "./modules/argocd_irsa"

  cluster_name          = "${var.name}-${var.environment}"
  namespace             = "kube-system"
  service_account_name  = "external-secrets-sa"
  iam_role_name         = "${var.name}-${var.environment}-external-secrets-irsa"

  managed_policy_arns = {
    SecretsManagerReadWrite = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  }

  application_name = "external-secrets"
  chart_repo       = "https://charts.external-secrets.io"
  chart_name       = "external-secrets"
  chart_version    = "0.9.13"
} 