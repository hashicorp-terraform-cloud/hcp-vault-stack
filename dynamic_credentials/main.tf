resource "vault_jwt_auth_backend" "jwt" {
  description        = "JWT Auth Backend for Dynamic Provider Credentials"
  path               = "jwt"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

resource "vault_policy" "vdpc" {

  name = "tfc-policy"

  policy = <<EOT

path "*" {
  capabilities = ["sudo","read","create","update","delete","list","patch"]
}
EOT

}

resource "vault_jwt_auth_backend_role" "vdpc" {
  backend        = vault_jwt_auth_backend.jwt.path
  role_name      = "vault-jwt-auth-role"
  token_policies = ["tfc-policy"]

  bound_audiences   = ["vault.workload.identity"]
  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${var.tfc_organisation}:project:*:workspace:*:run_phase:*"
  }
  user_claim    = "terraform_full_workspace"
  role_type     = "jwt"
  token_ttl     = 1800
  token_max_ttl = 3600
}