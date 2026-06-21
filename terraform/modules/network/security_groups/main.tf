# AWS EC2 SG

resource "aws_security_group" "allow_ec2_traffic" {
  name        = "allow_ec2_traffic"
  description = "Allow ec2 inbound and outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.env}-allow-ec2-traffic"
    Environment = var.env
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ec2_inbound_traffic" {
  for_each          = toset(var.ec2_ingress.ports)
  security_group_id = aws_security_group.allow_ec2_traffic.id
  cidr_ipv4         = var.ec2_ingress.cidr_ipv4
  from_port         = each.value
  ip_protocol       = var.ec2_ingress.ip_protocol
  to_port           = each.value
}

resource "aws_vpc_security_group_egress_rule" "allow_ec2_outbound_traffic" {
  security_group_id = aws_security_group.allow_ec2_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# AWS DB SG

resource "aws_security_group" "allow_db_traffic" {
  name        = "allow_db_traffic"
  description = "Allow db inbound and outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.env}-allow-db-traffic"
    Environment = var.env
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_inbound_traffic" {
  for_each          = toset(var.db_ingress.ports)
  security_group_id = aws_security_group.allow_db_traffic.id
  cidr_ipv4         = var.db_cidr_ipv4_ingress
  from_port         = each.value
  ip_protocol       = var.db_ingress.ip_protocol
  to_port           = each.value
}

resource "aws_vpc_security_group_egress_rule" "allow_db_outbound_traffic" {
  security_group_id = aws_security_group.allow_db_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# AWS LB SG

resource "aws_security_group" "allow_lb_traffic" {
  name        = "allow_lb_traffic"
  description = "Allow lb inbound and outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.env}-allow-lb-traffic"
    Environment = var.env
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_lb_inbound_traffic" {
  for_each          = toset(var.lb_ingress.ports)
  security_group_id = aws_security_group.allow_lb_traffic.id
  cidr_ipv4         = var.lb_ingress.cidr_ipv4
  from_port         = each.value
  ip_protocol       = var.lb_ingress.ip_protocol
  to_port           = each.value
}

resource "aws_vpc_security_group_egress_rule" "allow_lb_outbound_traffic" {
  security_group_id = aws_security_group.allow_lb_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
