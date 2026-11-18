# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "certificate_manager" {
  source           = "../../"
  name             = "example-web"
  domains          = ["example.com", "*.example.com"]
  dns_managed_zone = google_dns_managed_zone.public.name
}
