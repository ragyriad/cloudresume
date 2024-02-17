terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "ragy-terraform-state-cloud-resume"
    dynamodb_table = "state-lock"
    key = "global/mystatefile/terraform_tfstate"
    region = var.cloud_resume_region
    encrypt = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.cloud_resume_region
  profile = "default"
}

provider "github" {
  token = var.github_token
}
