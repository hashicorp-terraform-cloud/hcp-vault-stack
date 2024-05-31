resource "vault_auth_backend" "openshift" {
  type      = "kubernetes"
  path      = "openshift"
}

resource "vault_kubernetes_auth_backend_config" "openshift-backend-config" {
  backend            = vault_auth_backend.openshift.path
  kubernetes_host    = "https://api.hoth.onmi.cloud:6443"
  kubernetes_ca_cert = var.kubernetes_ca_bundle
  token_reviewer_jwt = var.kubernetes_token_reviewer_jwt
}

resource "vault_kubernetes_auth_backend_role" "openshift-role" {
  backend                          = vault_auth_backend.openshift.path
  role_name                        = "openshift-role"
  bound_service_account_names      = ["*"]
  bound_service_account_namespaces = ["*"]
  token_policies                   = [vault_policy.kubernetes-policy.name]
}

resource "vault_policy" "kubernetes-policy" {
  name = "kubernetes-policy"

  policy = <<EOT

path "int/issue/long-lived-role" {
  capabilities = ["create","update"]
}

path "int/issue/short-lived-role" {
  capabilities = ["create","update"]
}

path "acme/*" {
  capabilities = ["create","update"]
}

EOT

}