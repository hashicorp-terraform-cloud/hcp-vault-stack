output "uuid" {
  value = random_uuid.this.result
}

output "tfe_token" {
  value = data.hcp_vault_secrets_secret.tfe_token.secret_value
  sensitive = true
}