# terraform-gcp-certificate-manager

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-certificate-manager/workflows/Verify/badge.svg?branch=main)](https://github.com/JamesWoolfenden/terraform-gcp-certificate-manager/actions)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-certificate-manager.svg)](https://github.com/JamesWoolfenden/terraform-gcp-certificate-manager/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-gcp-certificate-manager.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-gcp-certificate-manager/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D1.5.0-blue.svg)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Terraform module for Certificate Manager. It issues a Google-managed certificate validated through DNS authorizations (one per base domain, covering wildcards), publishes it through a certificate map with one entry per hostname, and, when a Cloud DNS managed zone name is given, creates the authorization CNAME records too. The `certificate_map` output plugs straight into `terraform-gcp-https-lb`.

## Usage

Add **module.certificate_manager.tf** to your code:-

```terraform
module "certificate_manager" {
  source           = "jameswoolfenden/certificate-manager/gcp"
  name             = "example-web"
  domains          = ["example.com", "*.example.com"]
  dns_managed_zone = google_dns_managed_zone.public.name
}
```

See [example/examplea](example/examplea) for a complete working example.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_certificate_manager_certificate.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate) | resource |
| [google_certificate_manager_certificate_map.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate_map) | resource |
| [google_certificate_manager_certificate_map_entry.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate_map_entry) | resource |
| [google_certificate_manager_dns_authorization.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_dns_authorization) | resource |
| [google_dns_record_set.authorization](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_dns_managed_zone"></a> [dns\_managed\_zone](#input\_dns\_managed\_zone) | Name of the Cloud DNS managed zone in which to create the DNS authorization CNAME records. When null, create them yourself from the dns\_authorization\_records output | `string` | `null` | no |
| <a name="input_dns_ttl"></a> [dns\_ttl](#input\_dns\_ttl) | TTL in seconds for the DNS authorization CNAME records | `number` | `300` | no |
| <a name="input_domains"></a> [domains](#input\_domains) | Domains on the certificate, e.g. ["example.com", "*.example.com"]. Each gets a certificate map entry; each base domain gets a DNS authorization | `list(string)` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels applied to the certificate, DNS authorizations, map and map entries, for cost allocation and ownership tracking | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix for the certificate (suffixed with a hash of var.domains so a domain change can replace it in place), the DNS authorizations, map and map entries | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_certificate_id"></a> [certificate\_id](#output\_certificate\_id) | ID of the Google-managed certificate |
| <a name="output_certificate_map"></a> [certificate\_map](#output\_certificate\_map) | Certificate map in the form target HTTPS proxies expect (pass to terraform-gcp-https-lb's certificate\_map) |
| <a name="output_certificate_map_id"></a> [certificate\_map\_id](#output\_certificate\_map\_id) | ID of the certificate map |
| <a name="output_dns_authorization_records"></a> [dns\_authorization\_records](#output\_dns\_authorization\_records) | DNS records that must exist for each authorization, keyed by domain (created automatically when dns\_managed\_zone is set) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Role and Permissions

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
# apply role
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "certificatemanager.certmapentries.create",
    "certificatemanager.certmapentries.delete",
    "certificatemanager.certmapentries.get",
    "certificatemanager.certmapentries.update",
    "certificatemanager.certmaps.create",
    "certificatemanager.certmaps.delete",
    "certificatemanager.certmaps.get",
    "certificatemanager.certmaps.update",
    "certificatemanager.certs.create",
    "certificatemanager.certs.delete",
    "certificatemanager.certs.get",
    "certificatemanager.certs.use",
    "certificatemanager.dnsauthorizations.create",
    "certificatemanager.dnsauthorizations.delete",
    "certificatemanager.dnsauthorizations.get",
    "certificatemanager.dnsauthorizations.update",
    "certificatemanager.dnsauthorizations.use",
    "certificatemanager.operations.delete",
    "certificatemanager.operations.get",
    "dns.changes.create",
    "dns.changes.get",
    "dns.changes.list",
    "dns.resourceRecordSets.create",
    "dns.resourceRecordSets.delete",
    "dns.resourceRecordSets.get",
    "dns.resourceRecordSets.list",
    "dns.resourceRecordSets.update"
  ]
}

# plan role
resource "google_project_iam_custom_role" "terraform_pike_plan" {
  project     = "pike-477416"
  role_id     = "terraform_pike_plan"
  title       = "terraform_pike_plan"
  description = "A user with least privileges"
  permissions = [
    "certificatemanager.certmapentries.get",
    "certificatemanager.certmaps.get",
    "certificatemanager.certs.get",
    "certificatemanager.dnsauthorizations.get",
    "certificatemanager.operations.get",
    "dns.changes.get",
    "dns.changes.list",
    "dns.resourceRecordSets.get",
    "dns.resourceRecordSets.list"
  ]
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-gcp-certificate-manager/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-gcp-certificate-manager/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2026 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
