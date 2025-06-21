data "aws_eks_cluster" "cluster" {
  name = "${var.name}-${var.environment}"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "${var.name}-${var.environment}"
}

data "kubernetes_secret" "argocd_admin" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
}