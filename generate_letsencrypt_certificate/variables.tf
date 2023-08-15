variable k8s_cluster_name {
  type        = string
  description = "k8s target cluster name"
}

variable k8s_cluster_location {
  type        = string
  description = "k8s target cluster location"
}

variable gcp_project_id {
  type        = string
  description = "The GCP project id"
}

variable email_issuer {
  type        = string
  description = "Lets Encrypt email issuer"
}

variable domain_name {
  type        = string
  description = "Domain"
}