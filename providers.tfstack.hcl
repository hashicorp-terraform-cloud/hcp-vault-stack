required_providers {
    hcp = {
        source  = "hashicorp/hcp"
        version = "~> 0.86.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.6.0"
    }
}

provider "hcp" "this" {
  config {
    workload_identity {
      resource_name = var.workload_idp_name
      token_file    = var.identity_token_file
    }
  }
}

provider "random" "this" {}