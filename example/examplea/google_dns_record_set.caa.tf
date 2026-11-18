# Only Google Trust Services (and Let's Encrypt, Google's fallback CA) may issue for this zone.
resource "google_dns_record_set" "caa" {
  managed_zone = google_dns_managed_zone.public.name
  name         = google_dns_managed_zone.public.dns_name
  type         = "CAA"
  ttl          = 3600
  rrdatas = [
    "0 issue \"pki.goog\"",
    "0 issue \"letsencrypt.org\"",
    "0 issuewild \"pki.goog\"",
    "0 issuewild \"letsencrypt.org\"",
  ]
}
