variable "env" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
}

variable "instance_type_template" {
  description = "EC2 instance type to use (e.g., t3.micro, t3.small)"
  type        = string
}

variable "key_name" {
  description = "Name of the key pair used to enable SSH access"
  type        = string
}

variable "user_data" {
  description = "Path of the user data file to be executed during instance launch"
  type        = string
}

variable "sg_ids" {
  description = "List of sg IDs to associate with the launch template"
  type        = list(string)
}


variable "instance_profile_name" {
  description = "name of the instance profile"
}
