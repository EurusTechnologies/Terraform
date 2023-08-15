terraform {
  required_version = ">= 1.2.8"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.33.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.13.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.6.0"
    }
  }
}