resource "google_certificate_manager_certificate_map_entry" "main" {
  for_each = local.domain_slugs

  name         = local.map_entry_names[each.key]
  description  = "Serves the ${var.name} certificate for ${each.key}"
  map          = google_certificate_manager_certificate_map.main.name
  hostname     = each.key
  certificates = [google_certificate_manager_certificate.main.id]
  labels       = var.labels
}
