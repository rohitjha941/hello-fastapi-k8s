module "irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = var.iam_role_name

  oidc_providers = {
    default = {
      provider_arn               = data.aws_iam_openid_connect_provider.oidc.arn
      namespace_service_accounts = ["${var.namespace}:${var.service_account_name}"]
    }
  }

  role_policy_arns = var.managed_policy_arns
}


locals {
  base_values = <<-EOF
    installCRDs: true
    serviceAccount:
      name: ${var.service_account_name}
      annotations:
        eks.amazonaws.com/role-arn: ${module.irsa.iam_role_arn}
  EOF

  final_values = length(trimspace(var.extra_helm_values)) == 0 ? local.base_values : "${local.base_values}\n${var.extra_helm_values}"
}

resource "argocd_application" "this" {
  metadata {
    name      = var.application_name
    namespace = var.argocd_namespace
  }

  spec {
    project = var.argocd_project

    source {
      repo_url        = var.chart_repo
      chart           = var.chart_name
      target_revision = var.chart_version

      helm {
        release_name = var.application_name
        values       = local.final_values
      }
    }

    destination {
      server    = var.cluster_server
      namespace = var.namespace
    }

    sync_policy {
      automated {
        prune     = true
        self_heal = true
      }
      sync_options = var.sync_options
    }
  }

  depends_on = [module.irsa]
} 