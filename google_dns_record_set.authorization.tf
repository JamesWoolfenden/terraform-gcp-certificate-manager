resource "google_dns_record_set" "authorization" {
  for_each = var.dns_managed_zone == null ? toset([]) : local.authorization_domains

  managed_zone = var.dns_managed_zone
  name         = google_certificate_manager_dns_authorization.main[each.key].dns_resource_record[0].name
  type         = "CNAME" # Certificate Manager DNS authorizations are always CNAME records
  ttl          = var.dns_ttl
  rrdatas      = [google_certificate_manager_dns_authorization.main[each.key].dns_resource_record[0].data]
}
