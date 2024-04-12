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
}

provider "hcp" "this" {
    config {
        project_id = var.hcp_project_id

        workload_identity {
            resource_name = var.workload_idp_name
            token_file    = var.identity_token_file
        }
    }
}

provider "random" "this" {}

provider "vault" "this" {
    config {
        address = component.cluster.public_endpoint_url
        token   = component.cluster.bootrstrap_token
    }
}