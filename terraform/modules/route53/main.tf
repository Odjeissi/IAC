# Fetch hosted zone

data "aws_route53_zone" "main_zone" {
  name         = var.domain_name
  private_zone = false
}

# AWS route53 Record

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main_zone.zone_id
  name    = "${var.route53_record_name}.${var.domain_name}"
  type    = var.route53_record_type
  alias {
    name                   = var.route53_record_alias.name
    zone_id                = var.route53_record_alias.zone_id
    evaluate_target_health = var.route53_record_alias.evaluate_target_health
  }

}
