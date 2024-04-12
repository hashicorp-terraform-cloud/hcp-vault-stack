data "hcp_vault_secrets_secret" "tfe_token" {
  app_name    = "Stacks"
  secret_name = "TF_STACKS_TFE_TOKEN"
}