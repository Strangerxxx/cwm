variable "values" {
  default = ["../values/local.yaml"]
}

resource "kubernetes_namespace" "cwm" {
  metadata {
    name = "cwm"
  }
}

resource "tls_private_key" "jwt" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

locals {
  jwtPublicKeyRef = "public.pem"
  jwtPrivateKeyRef = "private.pem"
}

resource "kubernetes_secret" "jwt" {
  metadata {
    name = "jwt"
    namespace = kubernetes_namespace.cwm.metadata[0].name
  }

  data = {
    "${local.jwtPublicKeyRef}" = tls_private_key.jwt.public_key_pem
    "${local.jwtPrivateKeyRef}" = tls_private_key.jwt.private_key_pem
  }
}

resource "helm_release" "cwm" {
  chart = "../cwm"
  name = "cwm"
  namespace = kubernetes_namespace.cwm.metadata[0].name
  values = [for path in var.values: file(path)]
  dependency_update = true

  set {
    name = "global.jwt.existingSecret"
    value = kubernetes_secret.jwt.metadata[0].name
  }

  set {
    name = "global.jwt.publicKey.secretRefKey"
    value = local.jwtPublicKeyRef
  }

  set {
    name = "global.jwt.privateKey.secretRefKey"
    value = local.jwtPrivateKeyRef
  }
}
