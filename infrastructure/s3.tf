resource "aws_s3_bucket" "cloud_resume_bucket" {
  bucket = var.s3_name
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.cloud_resume_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership]
  bucket = aws_s3_bucket.cloud_resume_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.cloud_resume_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.cloud_resume_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "AllowGetObjects"
    Statement = [
      {
        Sid       = "AllowPublic"
        Effect    = "Allow"
        Principal = {"Service"= "cloudfront.amazonaws.com"},
        Action    = ["s3:GetObject","s3:PutObject", "s3:PutObjectAcl"],
        Resource  = "${aws_s3_bucket.cloud_resume_bucket.arn}/*"
        Condition = {
                "StringEquals": {
                    "AWS:SourceArn": "${aws_cloudfront_distribution.cf_distribution.arn}"
                }
            }
      }
    ]
  })
}


resource "aws_s3_bucket_cors_configuration" "cors_config" {
  bucket = aws_s3_bucket.cloud_resume_bucket.id  

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }  
}

resource "aws_s3_bucket_public_access_block" "bucket_acess_block" {
  bucket = aws_s3_bucket.cloud_resume_bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}