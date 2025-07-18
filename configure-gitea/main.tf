# configure-gitea/main.tf

# Gitea provider configuration
terraform {
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.6.0"
    }
  }
}


provider "gitea" {
  base_url = var.gitea_base_url
  username = var.gitea_admin_username
  password = var.gitea_admin_password


  insecure = true
}

# Resource to create an initial Gitea repository
resource "gitea_repository" "initial_repo" {
  username     = var.gitea_admin_username
  name         = var.initial_repo_name
  private      = false
  issue_labels = "Default"
  license      = "MIT"
  gitignores   = "Go"
}

resource "gitea_repository" "argocd-configs" {
  username              = var.gitea_admin_username
  name                  = "kubernetes-lab-argocd-configs"
  description           = "ArgoCD Configs"
  migration_clone_address = var.initial_argocd_repo
  private               = false
}

