variable "kubernetes_ca_bundle" {
  type        = string
  description = "Kubernetes Cluster CA Bundle"
}

variable "kubernetes_token_reviewer_jwt" {
  type        = string
  description = "Kubernetes Cluster Token Reviewer JWT"
}