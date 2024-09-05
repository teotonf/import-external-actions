resource "github_repository" "new_repo" {
  name        = var.gh_repository_name
  description = var.gh_repo_description

  visibility = var.visibility

  auto_init = false
}

resource "github_branch_protection" "new_repo_protection" {
  repository_id = github_repository.new_repo.node_id
  count         = var.visibility == "public" ? 1 : 0

  pattern          = "main"
  enforce_admins   = true
  allows_deletions = true

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    restrict_dismissals        = true
    require_code_owner_reviews = true
  }
}

# Add the ssh key as a deploy key
resource "github_repository_deploy_key" "new_repo_key" {
  depends_on = [github_repository.new_repo]

  title      = "${var.gh_repository_name} read key"
  repository = var.gh_repository_name
  key        = file(var.gh_ssh_key)
  read_only  = true
}
