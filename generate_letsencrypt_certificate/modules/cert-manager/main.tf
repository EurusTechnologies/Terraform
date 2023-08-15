########################################
#            Locals                    #
########################################
locals {
  certmanager_namespace = "cert-manager"
}

########################################
#            CERT MANAGER              #
########################################

# install crds
resource "null_resource" "install_custom_crds" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.crds.yaml"
  }
}

# uninstall crds
resource "null_resource" "uninstall_custom_crds" {
  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.crds.yaml"
  }
}

# install cert-manager helm chart
resource "helm_release" "cert" {
  depends_on       = [null_resource.install_custom_crds]
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.9.1"
  namespace        = local.certmanager_namespace
  create_namespace = true
  values           = try(file("./helm_values/cert_manager.yaml"), [])
  atomic           = false
}
