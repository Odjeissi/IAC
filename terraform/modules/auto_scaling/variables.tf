variable "env" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
}

variable "autoScaling_configuration" {
  description = "Configuration settings for the Auto Scaling Group"
  type = object({
    max_size = number
    min_size = number
  })
}

variable "launch_template_id" {
  description = "ID of the Launch Template"
  type        = string
}

variable "template_lasted_version" {
  description = "Latest version of the Launch Template"
  type        = string
}

variable "tg_arn" {
  description = "List of TG arns to associate with the Auto Scaling Group"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of VPC subnet IDs where the Auto Scaling Group instances will be deployed."
  type        = list(string)
}
