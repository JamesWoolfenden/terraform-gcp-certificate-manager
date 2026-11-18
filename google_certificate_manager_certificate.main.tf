resource "google_certificate_manager_certificate" "main" {
  name        = var.name
  description = "Google-managed certificate for ${join(", ", var.domains)}"
  location    = "global"
  scope       = "DEFAULT"
  labels      = var.labels

  managed {
    domains            = var.domains
    dns_authorizations = [for a in google_certificate_manager_dns_authorization.main : a.id]
  }

  lifecycle {
    create_before_destroy = true
  }
}
