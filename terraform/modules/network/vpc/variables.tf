variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "env" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
}

variable "numb_az" {
  description = "number of AZs for the project"
  type        = number
}

variable "enable_nat" {
  description = "Enable NAT for internet access from private subnets"
  type        = bool
}
