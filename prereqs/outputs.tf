output "uuid" {
  value = random_uuid.this.result
}

output "tfe_token" {
  value     = data.hcp_vault_secrets_secret.tfe_token.secret_value
  sensitive = true
}

output "kubernetes_ca_bundle" {
  value = data.hcp_vault_secrets_secret.kubernetes_ca_bundle.secret_value
  sensitive = true
}

output "kubernetes_token_reviewer_jwt" {
  value = data.hcp_vault_secrets_secret.kubernetes_token_reviewer_jwt.secret_value
  sensitive = true
}