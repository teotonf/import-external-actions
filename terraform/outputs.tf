output "gh_address" {
  value       = github_repository.new_repo.http_clone_url
  description = "The address of the new repo"
}