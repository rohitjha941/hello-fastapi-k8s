module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "${var.name}-${var.environment}"
  cluster_version = "1.33"

  cluster_endpoint_public_access = false

  enable_cluster_creator_admin_permissions = true

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets


  fargate_profiles = {
    default = {
      name = "default-fargate"
      selectors = [
        {
          labels = {
            "eks.amazonaws.com/compute-type" = "fargate"
          }
        }
      ]
      subnet_ids = module.vpc.private_subnets
    }
  }
}