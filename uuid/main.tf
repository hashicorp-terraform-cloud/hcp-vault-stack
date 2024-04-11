terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

resource "random_uuid" "this" {}

output "uuid" {
  value = random_uuid.this.id
}