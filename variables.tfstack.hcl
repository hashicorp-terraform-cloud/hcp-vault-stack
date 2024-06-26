# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "hcp_identity_token_file" {
    type        = string
}

variable "workload_idp_name" {
    description = "The name of the workload IDP configured in the HCP Platform for Terraform Cloud to use"
    type        = string
}

variable "cloud_provider" {
    description = "the cloud provider to use for the HCP Vault cluster"
    type        = string
}

variable "cloud_region" {
    description = "the cloud region to use for the HCP Vault cluster"
    type        = string
}

variable "hcp_project_id" {
    description = "the HCP project ID to use for the HCP Vault cluster"
    type        = string
}

variable "tfc_organisation" {
    description = "The Terraform Cloud organisation used in the bound claim"
    type        = string
}