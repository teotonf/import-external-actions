resource "github_repository" "new_repo" {
  name        = var.gh_repository_name
  description = var.gh_repo_description

  visibility = var.visibility

  auto_init = false
}

resource "github_branch_protection" "new_repo_protection" {
  repository_id = github_repository.new_repo.node_id

  pattern          = "main"
  enforce_admins   = true
  allows_deletions = true

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    restrict_dismissals        = true
    require_code_owner_reviews = true
  }
}
