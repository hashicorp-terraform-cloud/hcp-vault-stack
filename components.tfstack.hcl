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

component "pki" {
    source = "./pki"

    providers = {
        vault = provider.vault.this
        tls   = provider.tls.this
    }

    inputs = {
        endpoint         = component.cluster.public_endpoint_url
    }
}

component "kubernetes" {
    source = "./kubernetes"

    providers = {
        vault = provider.vault.this
    }

    inputs = {
        kubernetes_ca_bundle = component.prereqs.kubernetes_ca_bundle
        kubernetes_token_reviewer_jwt = component.prereqs.kubernetes_token_reviewer_jwt
    }
}