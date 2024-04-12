output "ca_pem_bundle" {
  value = nonsensitive(local.ca_pem_bundle)
}

output "intermediate_pem_bundle" {
  value = nonsensitive(local.intermediate_pem_bundle)
}

output "ca_expiry" {
  value = tls_self_signed_cert.ca_cert.validity_end_time
}

output "imported_issuers" {
  value = vault_pki_secret_backend_intermediate_set_signed.intermediate_ca.imported_issuers
}