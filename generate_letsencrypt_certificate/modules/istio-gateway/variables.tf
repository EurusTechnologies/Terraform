variable "env" {
  type        = string
  default     = "staging"
  description = "The target environment to configure letsencrypt. Allowed values are staging and prod"
}


variable "lets_encrypt_cluster_issuer_email" {
  type        = string
  description = "The email address to configure in lets encrypt issuer"
}

variable "domain_name" {
  type        = string
  description = "The domain name to issue the certificate for"
}
