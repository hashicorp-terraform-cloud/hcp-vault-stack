required_providers {
    hcp = {
        source  = "hashicorp/hcp"
        version = "~> 0.86.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.6.0"
    }
    vault = {
        source = "hashicorp/vault"
        version = "~> 4.2.0" 
    }
    tfe = {
        source = "hashicorp/tfe"
        version = "~> 0.53.0"
    
    }
}

provider "hcp" "this" {
    config {
        project_id = var.hcp_project_id

        workload_identity {
            resource_name = var.workload_idp_name
            token_file    = var.hcp_identity_token_file
        }
    }
}

provider "vault" "this" {
    config {
        address = component.cluster.public_endpoint_url
        token   = component.cluster.bootstrap_token
    }
}

provider "tfe" "this" {
    config {
        organization = var.tfc_organisation
        token    = component.prereqs.tfe_token
    }
}

provider "random" "this" {}