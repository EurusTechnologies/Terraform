provider "kubernetes" {
  host  = "https://${data.google_container_cluster.cluster_1_information.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.cluster_1_information.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.cluster_1_information.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.cluster_1_information.master_auth[0].cluster_ca_certificate,
    )
  }
}