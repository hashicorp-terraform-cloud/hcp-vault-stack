identity_token "hcp" {
  audience                  = ["hcp.workload.identity"]
}

identity_token "vault" {
  audience                  = ["vault.workload.identity"]
}

deployment "azure" {
  variables = {
    cloud_provider          = "azure"
    cloud_region            = "uksouth"
    hcp_project_id          = "d4563bbd-e376-463a-adfc-e7e428190f22"
    workload_idp_name       = "iam/project/d4563bbd-e376-463a-adfc-e7e428190f22/service-principal/terraform-stacks/workload-identity-provider/my-workload-identity-provider"
    hcp_identity_token_file = identity_token.hcp.jwt_filename
    tfc_organisation        = "ben-holmes"

    vault_identity_token_file = identity_token.vault.jwt_filename
    vault_namespace           = "admin"
    vault_role                = "vault-jwt-auth-stack"
  }
}
