output "allow_ec2_traffic_id" {
  value = aws_security_group.allow_ec2_traffic.id
}

output "allow_ec2_traffic_arn" {
  value = aws_security_group.allow_ec2_traffic.arn
}

output "allow_db_traffic_id" {
  value = aws_security_group.allow_db_traffic.id
}

output "allow_db_traffic_arn" {
  value = aws_security_group.allow_db_traffic.arn
}


output "allow_lb_traffic_id" {
  value = aws_security_group.allow_lb_traffic.id
}

output "allow_lb_traffic_arn" {
  value = aws_security_group.allow_lb_traffic.arn
}
