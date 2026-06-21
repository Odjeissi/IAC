variable "vpc_id" {
  description = "The ID of the VPC resource"
  type        = string
}

variable "env" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
}

variable "ec2_ingress" {
  description = "value"
  type = object({
    cidr_ipv4   = string
    ports       = list(string)
    ip_protocol = string
  })
}

variable "db_ingress" {
  description = "value"
  type = object({
    ports       = list(string)
    ip_protocol = string
  })
}

variable "db_cidr_ipv4_ingress" {
  description = "IPv4 CIDR block allowed to access the db"
  type        = string
}

variable "lb_ingress" {
  description = "value"
  type = object({
    cidr_ipv4   = string
    ports       = list(string)
    ip_protocol = string
  })
}
