variable "kubeconfig" {
  type = string
}

variable "kubecontext" {
  type = string
}

variable "argocd_namespace" {
  type    = string
  default = "default"
}

variable "argocd_url" {
  type    = string
  default = "default"
}

variable "argocd_release_name" {
  type    = string
  default = "default"
}