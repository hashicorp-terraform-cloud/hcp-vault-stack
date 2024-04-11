output "public_endpoint_url" {
  value = hcp_vault_cluster.hcp-vault-cluster.vault_public_endpoint_url
}

output "private_endpoint_url" {
  value = hcp_vault_cluster.hcp-vault-cluster.vault_private_endpoint_url
}

output "cluster_id" {
  value = hcp_vault_cluster.hcp-vault-cluster.cluster_id
}

output "hvn_id" {
  value = hcp_hvn.hcp-hvn.hvn_id
}