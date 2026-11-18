locals {
  # A DNS authorization covers a domain and its wildcard, so "*.example.com" and
  # "example.com" share one authorization keyed by the base domain.
  authorization_domains = toset([for d in var.domains : trimprefix(d, "*.")])

  # Resource-name-safe slug for each domain, e.g. "*.www.example.com" -> "wildcard-www-example-com".
  domain_slugs = { for d in var.domains : d => replace(replace(d, "*.", "wildcard."), ".", "-") }
}
