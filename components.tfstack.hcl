component "prereqs" {
  source = "./prereqs"

  providers = {
    random = provider.random.this
    hcp = provider.hcp.this
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
        cluster_id   = component.prereqs.uuid
    }
}

component "dynamic_credentials" {
    source = "./dynamic_credentials"

    providers = {
        vault = provider.vault.this
        tfe   = provider.tfe.this
    }

    inputs = {
        tfc_organisation = var.tfc_organisation
        endpoint         = component.cluster.public_endpoint_url
    }
}