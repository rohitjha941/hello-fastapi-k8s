module "agent_pool" {
  source = "aws-ia/tf-cloud-agents/aws"

  name                   = "${var.name}-${var.environment}-agent-pool"
  hcp_terraform_org_name = var.hcp_terraform_org_name

  use_spot_instances = true
  agent_cpu          = 1024
  agent_memory       = 2048

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

}
