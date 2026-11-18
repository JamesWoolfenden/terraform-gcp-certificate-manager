output "certificate_map" {
  value       = module.certificate_manager.certificate_map
  description = "Certificate map to attach to a target HTTPS proxy"
}
