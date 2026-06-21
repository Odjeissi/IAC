variable "env" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
}

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

variable "sg_ids_db" {
  description = "List of sg IDs to associate with the db instance."
  type        = list(string)
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


variable "db_subnet_ids" {
  description = "List of subnet IDs to associate with the db instance."
  type        = list(string)
}
