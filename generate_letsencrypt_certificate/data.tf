data "google_client_config" "provider" {}

data "google_container_cluster" "cluster_1_information" {
  name     = var.k8s_cluster_name
  location = var.k8s_cluster_location
  project  = var.gcp_project_id
}