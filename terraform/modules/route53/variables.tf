variable "domain_name" {
  description = "the domain name"
  type        = string
}

variable "route53_record_name" {
  description = "The DNS record name to create in Route 53"
  type        = string
}

variable "route53_record_type" {
  description = "The Route 53 DNS record type (example, A, AAAA, CNAME, TXT, or MX)."
  type        = string
}


variable "route53_record_alias" {
  description = "Configuration for the Route 53 alias target"
  type = object({
    name                   = string
    zone_id                = string
    evaluate_target_health = bool
  })
}
