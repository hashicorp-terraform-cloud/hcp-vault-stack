data "hcp_vault_secrets_secret" "tfe_token" {
  app_name    = "Stacks"
  secret_name = "TF_STACKS_TFE_TOKEN"
}

data "hcp_vault_secrets_secret" "kubernetes_ca_bundle" {
  app_name    = "Stacks"
  secret_name = "KUBERNETES_CA_BUNDLE"
}

data "hcp_vault_secrets_secret" "kubernetes_token_reviewer_jwt" {
  app_name    = "Stacks"
  secret_name = "KUBERNETES_TOKEN_REVIEWER_JWT"
}