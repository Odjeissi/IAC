
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

variable "env" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
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


variable "iam_role_policy_resource_arn" {
  description = "resource arn to be attached to the policy"
  type        = string
}


variable "iam_instance_profile_name" {
  description = "Name of the instance profile to attach to the instances"
  type        = string
}
