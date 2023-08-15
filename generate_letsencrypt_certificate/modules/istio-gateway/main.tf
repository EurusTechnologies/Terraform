########################################
#            Locals                    #
########################################
locals {
  istio_ingress_namespace = "app"
  lets_encrypt_config = var.env == "staging" ? {
    server                 = "https://acme-staging-v02.api.letsencrypt.org/directory",
    private_key_secret_ref = "letsencrypt-staging"
    } : {
    server                 = "https://acme-v02.api.letsencrypt.org/directory",
    private_key_secret_ref = "letsencrypt-prod"
  }
  domain_certificate_name = "mydomain"
}

########################################
#            ISTIO  GATEWAY            #
########################################

resource "helm_release" "istio_gateway" {
  name             = "istio-ingressgateway"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "gateway"
  namespace        = local.istio_ingress_namespace
  create_namespace = true
  values           = try(file("./helm_values/istio_gateway.yaml"), [])
  atomic           = true
}

resource "kubernetes_labels" "istio_injection" {
  depends_on = [ helm_release.istio_gateway ]
  api_version = "v1"
  kind        = "Namespace"
  metadata {
    name = local.istio_ingress_namespace
  }
  labels = {
    "istio-injection" = "enabled"
  }
}

########################################
#            LETS ENCRYPT              #
########################################

# # create letsencrypt cluster issuer resource
resource "kubernetes_manifest" "clusterissuer_letsencrypt" {
  depends_on = [helm_release.istio_gateway, kubernetes_labels.istio_injection]

  manifest = yamldecode(templatefile("${path.module}/manifests_templates/cluster_issuer.tftpl", {
    email                  = var.lets_encrypt_cluster_issuer_email,
    server                 = local.lets_encrypt_config.server,
    private_key_secret_ref = local.lets_encrypt_config.private_key_secret_ref
  }))
}

########################################
#          DOMAIN CERTIFICATE          #
########################################
# create certificate for the provided domain
resource "kubernetes_manifest" "domain_certificate" {
  depends_on = [kubernetes_manifest.clusterissuer_letsencrypt]

  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Certificate"
    "metadata" = {
      "name"      = local.domain_certificate_name
      "namespace" = local.istio_ingress_namespace
    }
    "spec" = {
      "secretName" = "${local.domain_certificate_name}_secret"
      "issuerRef" = {
        "name" = local.lets_encrypt_config.private_key_secret_ref
        "kind" = "ClusterIssuer"
      }
      "dnsNames" = [
        var.domain_name
      ]
    }
  }
}
########################################
#          DEMO WEBSITE                #
########################################

resource "helm_release" "demo_app" {
  name             = "demo-app"
  repository       = "https://bbriggs.github.io/charts"
  chart            = "static-site"
  namespace        = local.istio_ingress_namespace
  values           = []
  atomic           = true

  set {
    name  = "containerPort"
    value = "1313"
  }

  set {
    name  = "ingress.enabled"
    value = "false"
  }

  set {
    name  = "fullnameOverride"
    value = "myapp"
  }
}

########################################
#          ISTIO GATEWAY               #
########################################

resource "kubernetes_manifest" "gateway" {
  depends_on = [
    kubernetes_manifest.domain_certificate
  ]
  manifest = yamldecode(templatefile("${path.module}/manifests_templates/gateway.tftpl", {
    domain_name             = var.domain_name,
    istio_ingress_namespace = local.istio_ingress_namespace,
    secret_name             = "${local.domain_certificate_name}_secret"
  }))
}


resource "kubernetes_manifest" "virtual_service" {
  depends_on = [
    kubernetes_manifest.gateway
  ]
  manifest = yamldecode(templatefile("${path.module}/manifests_templates/virtual_service.tftpl", {
    istio_ingress_namespace = local.istio_ingress_namespace
  }))
}