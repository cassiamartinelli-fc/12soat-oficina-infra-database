terraform {
  required_version = ">= 1.0"

  required_providers {
    neon = {
      source  = "kislerdm/neon"
      version = "~> 0.6.0"
    }
  }
}

provider "neon" {
  api_key = var.neon_api_key
}
