output "alb_dns_name" {
  value = module.lb_main.lb_dns_name
}

output "route53_record" {
  value = module.route53_main.fqdn
}

output "rds_endpoint" {
  value     = module.db_main.db_endpoint
  sensitive = true
}

output "s3_bucket_id" {
  value = module.s3_main.s3_main_id
}
