identity_token "hcp" {
  audience = ["hcp.workload.identity"]
}

deployment "azure" {
  variables = {
    cloud_provider = "azure"
    cloud_region = "uksouth"
    workload_idp_name         = "iam/project/d4563bbd-e376-463a-adfc-e7e428190f22/service-principal/terraform-stacks/workload-identity-provider/my-workload-identity-provider"
    identity_token_file       = identity_token.hcp.jwt_filename
  }
}
