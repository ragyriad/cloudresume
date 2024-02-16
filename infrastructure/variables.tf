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

variable "cloud_resume_s3_name_secret" {
  type = string
  sensitive = true
}