locals {
  environments = ["dev", "staging", "prod"]
  
  # Layer definitions with dependencies
  layers = {
    base = {
      path       = "infra/2_base"
      depends_on = ["ipam-global"]
      auto_apply = {
        dev     = true
        staging = false
        prod    = false
      }
    }
    argo = {
      path       = "infra/3_argo"
      depends_on = ["base"]
      auto_apply = {
        dev     = true
        staging = false
        prod    = false
      }
    }
    addons = {
      path       = "infra/4_kubernetes_addons"
      depends_on = ["base", "argo"]
      auto_apply = {
        dev     = true
        staging = false
        prod    = false
      }
    }
  }
  
  # Flatten workspace configurations
  workspaces = flatten([
    for layer_name, layer in local.layers : [
      for env in local.environments : {
        name        = "${layer_name}-${env}"
        layer       = layer_name
        environment = env
        path        = layer.path
        depends_on  = layer.depends_on
        auto_apply  = layer.auto_apply[env]
      }
    ]
  ])
  
  # Create workspace map for easy lookup
  workspace_map = {
    for ws in local.workspaces : ws.name => ws
  }
}