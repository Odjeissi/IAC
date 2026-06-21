# AWS S3 Resource

resource "aws_s3_bucket" "s3_main" {
  bucket        = var.s3_bucket_name
  force_destroy = true
  tags = {
    Name        = "${var.env}-s3-main"
    Environment = var.env
  }
}

# AWS s3 Bucket Ownership

resource "aws_s3_bucket_ownership_controls" "s3_ownership" {
  bucket = aws_s3_bucket.s3_main.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# AWS s3 Bucket Versioning

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3_main.id

  versioning_configuration {
    status = "Enabled"
  }
}
