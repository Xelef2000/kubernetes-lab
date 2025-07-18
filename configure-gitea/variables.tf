# configure-gitea/variables.tf

variable "gitea_base_url" {
  description = "The base URL of the Gitea instance (e.g., http://gitea.example.com)"
  type        = string
}

variable "initial_repo_name" {
  description = "Name for the initial Gitea repository"
  type        = string
}

variable "initial_repo_description" {
  description = "Description for the initial Gitea repository"
  type        = string
}

variable "gitea_admin_username" {
  description = "Username for the initial Gitea admin user"
  type        = string
  default     = "terraform-admin"
}

variable "gitea_admin_password" {
  description = "Password for the initial Gitea admin user"
  type        = string
  #   sensitive   = true
  default = "StrongPassword123!"
}

variable "initial_argocd_repo" {
  description = "URL of the initial ArgoCD repository to mirror in Gitea"
  type        = string
  default     = "https://github.com/Xelef2000/kubernetes-lab-argocd-configs.git"
}