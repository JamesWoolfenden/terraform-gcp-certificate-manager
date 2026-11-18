output "certificate_id" {
  value       = google_certificate_manager_certificate.main.id
  description = "ID of the Google-managed certificate"
}

output "certificate_map_id" {
  value       = google_certificate_manager_certificate_map.main.id
  description = "ID of the certificate map"
}

output "certificate_map" {
  value       = "//certificatemanager.googleapis.com/${google_certificate_manager_certificate_map.main.id}"
  description = "Certificate map in the form target HTTPS proxies expect (pass to terraform-gcp-https-lb's certificate_map)"
}

output "dns_authorization_records" {
  value = { for k, a in google_certificate_manager_dns_authorization.main : k => {
    name = a.dns_resource_record[0].name
    type = a.dns_resource_record[0].type
    data = a.dns_resource_record[0].data
  } }
  description = "DNS records that must exist for each authorization, keyed by domain (created automatically when dns_managed_zone is set)"
}
