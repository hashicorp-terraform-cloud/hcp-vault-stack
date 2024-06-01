resource "vault_auth_backend" "openshift" {
  type = "kubernetes"
  path = "openshift"
}

resource "vault_kubernetes_auth_backend_config" "openshift-backend-config" {
  backend            = vault_auth_backend.openshift.path
  kubernetes_host    = var.kubernetes_cluster_api
  kubernetes_ca_cert = var.kubernetes_ca_bundle
  token_reviewer_jwt = var.kubernetes_token_reviewer_jwt
}

resource "vault_kubernetes_auth_backend_role" "openshift-role" {
  backend                          = vault_auth_backend.openshift.path
  role_name                        = "openshift-role"
  bound_service_account_names      = ["*"]
  bound_service_account_namespaces = ["*"]
  token_policies                   = [vault_policy.openshift-policy.name]
}

resource "vault_policy" "openshift-policy" {
  name = "openshift-policy"

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