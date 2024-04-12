resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "ca_cert" {
  private_key_pem = tls_private_key.private_key.private_key_pem

  is_ca_certificate = true

  subject {
    country             = "UK"
    province            = "Warwickshire"
    locality            = "Warwick"
    common_name         = "OnmiCloud Root CA"
    organization        = "OnmiCloud"
    organizational_unit = "OnmiCloud Root Certification Authority"
  }

  validity_period_hours = 8760 // 12 months

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

resource "vault_mount" "intermediate_ca" {
  path                      = "int"
  type                      = "pki"
  description               = "OnmiCloud Demo Intermediate CA"
}

locals {
  ca_pem_bundle           = "${tls_self_signed_cert.ca_cert.private_key_pem}${trimspace(tls_self_signed_cert.ca_cert.cert_pem)}"
  intermediate_pem_bundle = "${vault_pki_secret_backend_root_sign_intermediate.intermediate_ca.certificate}\n${tls_self_signed_cert.ca_cert.cert_pem}"
}

resource "vault_pki_secret_backend_config_ca" "root_ca" {
  depends_on = [ tls_self_signed_cert.ca_cert, vault_mount.intermediate_ca ]
  backend    = vault_mount.intermediate_ca.path
  pem_bundle = local.ca_pem_bundle
}

resource "vault_pki_secret_backend_intermediate_cert_request" "intermediate_csr" {
  depends_on = [ vault_pki_secret_backend_config_ca.root_ca ]
  backend            = vault_mount.intermediate_ca.path
  type               = "internal"
  common_name        = "OnmiCloud Intermediate CA"
  format             = "pem"
  private_key_format = "der"
  key_type           = "rsa"
  key_bits           = "4096"
}

resource "vault_pki_secret_backend_root_sign_intermediate" "intermediate_ca" {
  backend = vault_mount.intermediate_ca.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.intermediate_csr.csr
  common_name          = "OnmiCloud Intermediate CA"
  exclude_cn_from_sans = true
  ou                   = "Demo"
  ttl                  = "2190h"

}

resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate_ca" {
  backend = vault_mount.intermediate_ca.path

  certificate = local.intermediate_pem_bundle
}

resource "vault_pki_secret_backend_issuer" "intermediate_ca" {

  backend    = vault_mount.intermediate_ca.path
  issuer_ref = vault_pki_secret_backend_intermediate_set_signed.intermediate_ca.imported_issuers[0]
  issuer_name = "int-ca"
}

resource "vault_pki_secret_backend_config_issuers" "intermediate_ca" {
  backend                       = vault_mount.intermediate_ca.path
  default                       = vault_pki_secret_backend_issuer.intermediate_ca.issuer_id
  default_follows_latest_issuer = true
}

resource "vault_pki_secret_backend_role" "short_lived_role" {
  backend                     = vault_mount.intermediate_ca.path
  name                        = "short-lived-role"
  ttl                         = 300
  max_ttl                     = 600
  key_type                    = "rsa"
  key_bits                    = 4096
  allowed_domains             = ["short.onmi.cloud"]
  allow_subdomains            = true
  allow_glob_domains          = true
  allow_wildcard_certificates = true
  no_store                    = true
}

resource "vault_pki_secret_backend_role" "long_lived_role" {
  backend                     = vault_mount.intermediate_ca.path
  name                        = "long-lived-role"
  ttl                         = 600
  max_ttl                     = 3600
  key_type                    = "rsa"
  key_bits                    = 4096
  allowed_domains             = ["long.onmi.cloud"]
  allow_subdomains            = true
  allow_glob_domains          = true
  allow_wildcard_certificates = true
  no_store                    = false
}