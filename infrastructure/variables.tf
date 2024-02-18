variable "region" {
  type = string
  default = "us-east-1"
}

variable "s3_name" {
  type = string
  default="ragy-cloud-resume"
}

variable "github_token" {
  type = string
  sensitive = true
}

variable "github_repo" {
  type = string
  sensitive = true
}

variable "gh_s3_bucket_secret_title" {
  type = string
  sensitive = true
}

variable "gh_aws_region_secret" {
  type = string
  sensitive = true
}

variable "gh_aws_region_secret_title" {
  type = string
  sensitive = true
}

variable "gh_aws_oidc_role_arn" {
  type = string
  sensitive = true
}

variable "gh_aws_oidc_role_title" {
  type = string
  sensitive = true
}

variable "dynamodb_arn" {
  type = string
  sensitive = true
}