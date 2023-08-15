# Generate LetsEncrypt Certificate For Your K8s Cluster

```A Kubernetes terraform module is available to seamlessly deploy cert-manager alongside an istio gateway and configure it for a specific website. By invoking this module from the main.tf file and providing the desired domain name as a variable, you can effortlessly install cert-manager in the cluster with the istio-gateway and obtain a certificate issued for the specified domain.```

# RunBook
1. Initialize the terraform by executing the following command
`terraform init`
2. Plan the terraform for istio module by executing the following command
`terraform plan -target=module.istio`
3. Execute the terraform module named `install_istio` by executing the following command.
`terraform apply -target=module.install_istio`
4. Plan the terraform for install_cert_manager module by executing the following command
`terraform plan -target=module.install_cert_manager`
5. Execute the terraform module named `install_cert_manager` by executing the following command.
`terraform apply -target=module.install_cert_manager`
6. Plan the terraform without specifying target as all pre-reqs are setup by executing the following command
`terraform plan`
7. Now all the pre-requisites including the custom CRDs and istio are setup. Now apply the terraform without specifying any target. It will generate the certificate, install the istio gateway, install the sample application and configure the ingress(virtual service).
`terraform apply`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.8 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.33.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | = 2.6.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.33.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_install_cert_manager"></a> [install\_cert\_manager](#module\_install\_cert\_manager) | ./modules/cert-manager | n/a |
| <a name="module_install_istio"></a> [install\_istio](#module\_install\_istio) | ./modules/istio | n/a |
| <a name="module_install_istio_gateway"></a> [install\_istio\_gateway](#module\_install\_istio\_gateway) | ./modules/istio-gateway | n/a |

## Resources

| Name | Type |
|------|------|
| [google_client_config.provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_container_cluster.cluster_1_information](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain | `string` | n/a | yes |
| <a name="input_email_issuer"></a> [email\_issuer](#input\_email\_issuer) | Lets Encrypt email issuer | `string` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The GCP project id | `string` | n/a | yes |
| <a name="input_k8s_cluster_location"></a> [k8s\_cluster\_location](#input\_k8s\_cluster\_location) | k8s target cluster location | `string` | n/a | yes |
| <a name="input_k8s_cluster_name"></a> [k8s\_cluster\_name](#input\_k8s\_cluster\_name) | k8s target cluster name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->