variable "tfc_organisation" {
  type        = string
  description = "The Terraform Cloud organisation used in the bound claim"
}

variable "endpoint" {
  type = string
  description = "The address of the Vault instance to authenticate against."
}