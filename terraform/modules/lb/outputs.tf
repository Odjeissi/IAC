output "lb_arn" {
  value = aws_lb.lb_main.arn
}

output "lb_dns_name" {
  value = aws_lb.lb_main.dns_name
}

output "lb_zone_id" {
  value = aws_lb.lb_main.zone_id
}

output "target_group_arn" {
  value = aws_lb_target_group.lb_tg.arn
}
