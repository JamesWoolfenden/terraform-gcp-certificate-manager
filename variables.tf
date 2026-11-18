variable "name" {
  type        = string
  description = "Name of the certificate; also the prefix for the DNS authorizations, map and map entries"

  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]{0,30}[a-z0-9])?$", var.name))
    error_message = "var.name must be lowercase letters, digits and hyphens, starting with a letter, at most 32 characters (leaves room for per-domain suffixes)"
  }
}

variable "domains" {
  type        = list(string)
  description = "Domains on the certificate, e.g. [\"example.com\", \"*.example.com\"]. Each gets a certificate map entry; each base domain gets a DNS authorization"

  validation {
    condition     = length(var.domains) > 0 && length(var.domains) <= 100
    error_message = "var.domains must contain between 1 and 100 domains"
  }

  validation {
    condition     = alltrue([for d in var.domains : can(regex("^(\\*\\.)?([a-z0-9]([-a-z0-9]*[a-z0-9])?\\.)+[a-z]{2,63}$", d))])
    error_message = "var.domains entries must be fully qualified, lowercase domain names without a trailing dot, optionally prefixed with *."
  }

  validation {
    condition     = length(distinct(var.domains)) == length(var.domains)
    error_message = "var.domains must not contain duplicates"
  }
}

variable "dns_managed_zone" {
  type        = string
  description = "Name of the Cloud DNS managed zone in which to create the DNS authorization CNAME records. When null, create them yourself from the dns_authorization_records output"
  default     = null

  validation {
    condition     = var.dns_managed_zone == null || can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", var.dns_managed_zone))
    error_message = "var.dns_managed_zone must be a valid Cloud DNS managed zone name when set"
  }
}

variable "dns_ttl" {
  type        = number
  description = "TTL in seconds for the DNS authorization CNAME records"
  default     = 300

  validation {
    condition     = var.dns_ttl >= 30 && var.dns_ttl <= 86400
    error_message = "var.dns_ttl must be between 30 and 86400"
  }
}

variable "labels" {
  type        = map(string)
  description = "Labels applied to the certificate, DNS authorizations, map and map entries, for cost allocation and ownership tracking"
  default     = {}

  validation {
    condition     = alltrue([for k, v in var.labels : can(regex("^[a-z][a-z0-9_-]{0,62}$", k)) && can(regex("^[a-z0-9_-]{0,63}$", v))])
    error_message = "var.labels keys and values must be lowercase alphanumerics, underscores, or hyphens, 1-63 characters (GCP label constraints)"
  }
}
