terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "3.0.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "1.13.3"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.0.1"
    }
  }
}
