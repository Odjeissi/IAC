# VPC

variable "region" {
  description = "region to be deployed"
  type        = string
}

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


# SGs

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

variable "lb_ingress" {
  description = "value"
  type = object({
    cidr_ipv4   = string
    ports       = list(string)
    ip_protocol = string
  })
}

#LB

variable "load_balancer_type" {
  description = "Type of lb to create (application, network, or gateway)"
  type        = string
}

variable "target_type" {
  description = "Target type associated with the lb target group (instance, ip, or alb)"
  type        = string
}

# AWS Key deployer

variable "key_name" {
  description = "name of the key pair"
  type        = string
}

variable "PUB_KEY" {
  description = "path of the key pair"
  type        = string
}

# AWS Launch Template

variable "instance_type_template" {
  description = "EC2 instance type to use (e.g., t3.micro, t3.small)"
  type        = string
}

variable "user_data" {
  description = "Path of the user data file to be executed during instance launch"
  type        = string
}


# AWS Auto scaling group

variable "autoScaling_configuration" {
  description = "Configuration settings for the Auto Scaling Group"
  type = object({
    max_size = number
    min_size = number
  })
}

# AWS s3

variable "s3_bucket_name" {
  description = "Unique name for the S3 bucket to be created"
  type        = string
}

# AWS IAM Role

variable "iam_role_name" {
  description = "Name of the IAM role to create"
  type        = string
}

variable "iam_role_config" {
  description = "Configuration for the IAM role trust policy"
  type = object({
    Action = string
    Effect = string
    Sid    = string
    Principal = object({
      Service = string
    })
  })
}


variable "iam_role_policy_name" {
  description = "Name of the role policy to create"
  type        = string
}

variable "iam_role_policy_config" {
  description = "Configuration for the IAM role policy"
  type = object({
    Action = list(string)
    Effect = string
  })
}

variable "iam_instance_profile_name" {
  description = "Name of the instance profile to attach to the instances"
  type        = string
}

# AWS route53

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

# aws db

variable "db_configuration" {
  description = "Configurations for the db instance."

  type = object({
    db_name             = string
    engine              = string
    engine_version      = string
    instance_class      = string
    allocated_storage   = number
    skip_final_snapshot = bool
    multi_az            = bool
    storage_type        = string
    storage_encrypted   = bool
  })
}

variable "db_username" {
  description = "username for the db instance."
  type        = string
}

variable "db_password" {
  description = "password for the db instance."
  type        = string
  sensitive   = true
}
