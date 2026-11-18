resource "google_certificate_manager_certificate_map" "main" {
  name        = "${var.name}-map"
  description = "Certificate map serving ${var.name} to global external Application Load Balancers"
  labels      = var.labels
}
