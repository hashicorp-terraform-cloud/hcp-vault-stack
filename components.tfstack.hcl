component "uuid" {
  source = "./uuid"

  providers = {
    azurerm = provider.random.this
  }
}