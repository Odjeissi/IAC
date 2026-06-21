variable "s3_bucket_name" {
  description = "Unique name for the S3 bucket to be created"
  type        = string
}

variable "env" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
}
