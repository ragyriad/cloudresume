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
    region = "us-east-1"
    encrypt = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile = "default"
}

provider "github" {
  token = var.github_token
}
