data "github_repository" "main" {
  full_name = var.github_repo
}

resource "github_actions_secret" "s3_bucket" {
  repository       = "cloudresume"
  secret_name      = var.gh_s3_bucket_secret_title
  plaintext_value  = aws_s3_bucket.cloud_resume_bucket.bucket
}

resource "github_actions_secret" "aws_region" {
  repository       = "cloudresume"
  secret_name      = var.gh_aws_region_secret_title
  plaintext_value  = var.gh_aws_region_secret
}

resource "github_actions_secret" "aws_iam_gh_actions_role" {
  repository       = "cloudresume"
  secret_name      = var.gh_aws_oidc_role_title
  plaintext_value  = var.gh_aws_oidc_role_arn
}