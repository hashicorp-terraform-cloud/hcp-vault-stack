component "uuid" {
  source = "./uuid"

  providers = {
    random = provider.random.this
  }
}

component "cluster" {
    source = "./cluster"

    providers = {
        hcp = provider.hcp.this
    }

    inputs = {
        cloud_provider = var.cloud_provider
        cloud_region = var.cloud_region
        cluster_id = component.uuid.uuid
    }
}