########################################
#            ISTIO                     #
########################################

resource "helm_release" "istio_base" {
  name             = "istio-base"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  namespace        = "istio-system"
  create_namespace = true
  values           = []
  atomic           = true
}

resource "helm_release" "istio_d" {
  depends_on       = [helm_release.istio_base]
  name             = "istio-d"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "istiod"
  namespace        = "istio-system"
  create_namespace = true
  values           = []
  atomic           = true
}