# variables.tf


variable "kubeconfig" {
  type = string
  default     = "~/.kube/config"
}

variable "kubecontext" {
  type = string
  default = "minikube"
}


variable "gitea_namespace" {
  description = "Kubernetes namespace where Gitea will be deployed"
  type        = string
  default     = "gitea"
}

variable "gitea_release_name" {
  description = "Name of the Helm release for Gitea"
  type        = string
  default     = "my-gitea"
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
  default     = "StrongPassword123!"
}

variable "gitea_admin_email" {
  description = "Email for the initial Gitea admin user"
  type        = string
  default     = "admin@example.com"
}

variable "gitea_url" {
  description = "External URL for Gitea (domain name)"
  type        = string
  default     = "gitea.playground.local"
}