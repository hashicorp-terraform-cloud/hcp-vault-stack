variable "cluster_id" {
  type = string
}

variable "cloud_provider" {
  type    = string
}

variable "cloud_region" {
  type    = string
}

variable "cluster_tier" {
  type    = string
  default = "standard_small"
}

variable "expose_public_endpoint" {
  type    = bool
  default = true
}