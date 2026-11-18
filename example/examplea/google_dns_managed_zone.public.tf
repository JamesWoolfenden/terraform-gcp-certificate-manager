resource "google_dns_managed_zone" "public" {
  name        = "example-com"
  dns_name    = "example.com."
  description = "Public zone holding the certificate DNS authorization records"
  visibility  = "public"

  dnssec_config {
    state = "on"

    default_key_specs {
      algorithm  = "rsasha256"
      key_length = 2048
      key_type   = "keySigning"
    }

    default_key_specs {
      algorithm  = "rsasha256"
      key_length = 1024
      key_type   = "zoneSigning"
    }
  }

  cloud_logging_config {
    enable_logging = true
  }
}
