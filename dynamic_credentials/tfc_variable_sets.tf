resource "tfe_variable_set" "hcp-vault-workspaces" {
  name         = "HCP Vault - Dynamic Provider Credential Config - Workspaces"
  description  = "Dynamic Provider Credential Config for Terraform Cloud Workspaces."
  global       = false
  organization = data.tfe_organization.this.name
}

# Variable Set for TFC Workspace Dynamic Provider Credentials

resource "tfe_variable" "tfc_vault_provider_auth_workspace" {
  key             = "TFC_VAULT_PROVIDER_AUTH"
  value           = true
  category        = "env"
  description     = "Set to true to enable Vault Dynamic Provider Credentials."
  variable_set_id = tfe_variable_set.hcp-vault-workspaces.id
}

resource "tfe_variable" "tfc_vault_addr_workspace" {
  key             = "TFC_VAULT_ADDR"
  value           = var.endpoint
  category        = "env"
  description     = "The address of the Vault instance to authenticate against."
  variable_set_id = tfe_variable_set.hcp-vault-workspaces.id
}

resource "tfe_variable" "tfc_vault_namespace_workspace" {
  key             = "TFC_VAULT_NAMESPACE"
  value           = "admin"
  category        = "env"
  description     = "The namespace to use when authenticating to Vault."
  variable_set_id = tfe_variable_set.hcp-vault-workspaces.id
}

resource "tfe_variable" "tfc_vault_run_role_workspace" {
  key             = "TFC_VAULT_RUN_ROLE"
  value           = vault_jwt_auth_backend_role.workspace.role_name
  category        = "env"
  description     = "The name of the Vault role to authenticate against."
  variable_set_id = tfe_variable_set.hcp-vault-workspaces.id
}

resource "tfe_variable" "tfc_vault_auth_path_workspace" {
  key             = "TFC_VAULT_AUTH_PATH"
  value           = vault_jwt_auth_backend.jwt.path
  category        = "env"
  description     = "The path where the JWT auth backend is mounted in Vault."
  variable_set_id = tfe_variable_set.hcp-vault-workspaces.id
}