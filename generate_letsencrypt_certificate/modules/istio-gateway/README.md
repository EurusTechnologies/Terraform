<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="module_install_istio"></a> [install\_istio module](#module\_install\_istio) | n/a |
| <a name="module_install_cert_manager"></a> [install\_cert\_manager module](#module\_install\_cert\_manager) | n/a |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.demo_app](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.istio_gateway](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_labels.istio_injection](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/labels) | resource |
| [kubernetes_manifest.clusterissuer_letsencrypt](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.domain_certificate](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.gateway](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.virtual_service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name to issue the certificate for | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | The target environment to configure letsencrypt. Allowed values are staging and prod | `string` | `"staging"` | no |
| <a name="input_lets_encrypt_cluster_issuer_email"></a> [lets\_encrypt\_cluster\_issuer\_email](#input\_lets\_encrypt\_cluster\_issuer\_email) | The email address to configure in lets encrypt issuer | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->