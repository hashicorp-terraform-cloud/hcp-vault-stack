resource "hcp_hvn" "hcp-hvn" {
  hvn_id         = "hvn-${var.cloud_provider}"
  cloud_provider = var.cloud_provider
  region         = var.cloud_region
  cidr_block     = "172.25.16.0/20"
}

resource "hcp_vault_cluster" "hcp-vault-cluster" {
  cluster_id      = var.cluster_id
  hvn_id          = hcp_hvn.hcp-hvn.hvn_id
  tier            = var.cluster_tier
  public_endpoint = var.expose_public_endpoint
}