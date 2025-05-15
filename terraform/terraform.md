## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.9.1 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_branch_protection.new_repo_protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.new_repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_deploy_key.new_repo_key](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gh_admin_token"></a> [gh\_admin\_token](#input\_gh\_admin\_token) | Admin token for GH | `string` | n/a | yes |
| <a name="input_gh_repo_description"></a> [gh\_repo\_description](#input\_gh\_repo\_description) | A description on github repository | `string` | n/a | yes |
| <a name="input_gh_repository_name"></a> [gh\_repository\_name](#input\_gh\_repository\_name) | Name of the repository on GH | `string` | n/a | yes |
| <a name="input_gh_repository_owner"></a> [gh\_repository\_owner](#input\_gh\_repository\_owner) | Name of the repository on GH | `string` | n/a | yes |
| <a name="input_gh_ssh_key"></a> [gh\_ssh\_key](#input\_gh\_ssh\_key) | A ssh key to add to the repository | `string` | n/a | yes |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Is the repository private | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gh_address"></a> [gh\_address](#output\_gh\_address) | The address of the new repo |
