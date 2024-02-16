data "github_repository" "main" {
  full_name = var.github_repo
}


resource "github_actions_secret" "CLOUD_RESUME_S3_BUCKET" {
  repository       = data.github_repository.main.id
  secret_name      = var.cloud_resume_s3_name_secret
  plaintext_value  = aws_s3_bucket.cloud_resume_bucket.bucket
}