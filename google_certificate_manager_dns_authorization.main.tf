resource "google_certificate_manager_dns_authorization" "main" {
  for_each = local.authorization_domains

  name        = local.authorization_names[each.key]
  description = "DNS authorization proving control of ${each.key} for Google-managed certificate issuance"
  location    = "global"
  domain      = each.key
  labels      = var.labels
}
