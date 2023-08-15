module "install_istio" {
  source = "./modules/istio"
}

module "install_cert_manager" {
  depends_on = [module.install_istio]
  source     = "./modules/cert-manager"
}

module "install_istio_gateway" {
  depends_on                        = [module.install_cert_manager]
  source                            = "./modules/istio-gateway"
  lets_encrypt_cluster_issuer_email = var.email_issuer
  domain_name                       = var.domain_name
}