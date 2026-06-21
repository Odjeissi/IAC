# Fetch hosted zone

data "aws_route53_zone" "main_zone" {
  name         = var.domain_name
  private_zone = false
}

# aws acm certifcate

resource "aws_acm_certificate" "acm_main" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"
}

# aws acm validation

resource "aws_route53_record" "this" {
  for_each = {
    for dvo in aws_acm_certificate.acm_main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main_zone.zone_id
}


resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.acm_main.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}
