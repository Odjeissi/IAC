variable "env" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
}

variable "load_balancer_type" {
  description = "Type of lb to create (application, network, or gateway)"
  type        = string
}

variable "security_groups" {
  description = "List of sg IDs to associate with the lb"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnet IDs to associate with the lb"
  type        = list(string)
}

variable "target_type" {
  description = "Target type associated with the lb target group (instance, ip, or alb)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC resource"
  type        = string
}

variable "acm_certificate_Arn" {
  description = "The certificate arn"
  type        = string
}
