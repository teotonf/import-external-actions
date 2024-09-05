terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
  backend "local" {
  }

  required_version = "1.9.1"
}

provider "github" {
  token = var.gh_admin_token
  owner = var.gh_repository_owner
}
