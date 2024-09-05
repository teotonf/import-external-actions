variable "gh_repository_name" {
  description = "Name of the repository on GH"
  type        = string
}

variable "gh_repository_owner" {
  description = "Name of the repository on GH"
  type        = string
}

variable "visibility" {
  description = "Is the repository private"
  type        = string
  default     = "private"
}

variable "gh_admin_token" {
  description = "Admin token for GH"
  type        = string
}

variable "gh_repo_description" {
  description = "A description on github repository"
  type        = string
}
