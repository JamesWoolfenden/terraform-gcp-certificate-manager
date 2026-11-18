locals {
  # A DNS authorization covers a domain and its wildcard, so "*.example.com" and
  # "example.com" share one authorization keyed by the base domain.
  authorization_domains = toset([for d in var.domains : trimprefix(d, "*.")])

  # Resource-name-safe slug for each domain, e.g. "*.www.example.com" -> "wildcard-www-example-com".
  domain_slugs = { for d in var.domains : d => replace(replace(d, "*.", "wildcard."), ".", "-") }

  # Certificate Manager resource names are limited to 63 characters, so long
  # "<name>-<domain>" names are truncated and suffixed with a hash of the domain.
  authorization_names = {
    for d in local.authorization_domains : d => (
      length("${var.name}-${replace(d, ".", "-")}") <= 63
      ? "${var.name}-${replace(d, ".", "-")}"
      : "${substr("${var.name}-${replace(d, ".", "-")}", 0, 54)}-${substr(sha1(d), 0, 8)}"
    )
  }

  map_entry_names = {
    for d, slug in local.domain_slugs : d => (
      length("${var.name}-${slug}") <= 63
      ? "${var.name}-${slug}"
      : "${substr("${var.name}-${slug}", 0, 54)}-${substr(sha1(d), 0, 8)}"
    )
  }

  # managed.domains forces replacement, and the certificate is create_before_destroy
  # (map entries keep serving the old one until the new one exists), so the name
  # must change whenever the domain list does or the replacement collides with
  # the certificate it replaces.
  certificate_name = "${var.name}-${substr(sha1(join(",", var.domains)), 0, 8)}"
}
