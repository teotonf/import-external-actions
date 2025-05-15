# Terraform GitHub Repository Management

This project is a Terraform configuration designed to manage GitHub repositories. Below is an overview of the key components and functionality provided by the code.

## Overview

The Terraform configuration automates the creation and management of a GitHub repository, including branch protection rules and deploy keys. It uses the `github` provider to interact with the GitHub API.

### Key Features

1. **Repository Creation**:
   - Creates a new GitHub repository with a specified name, description, and visibility (public or private).
   - The repository is initialized without any default files (e.g., README).

2. **Branch Protection**:
   - Applies branch protection rules to the `main` branch if the repository is public.
   - Enforces the following rules:
     - Admins must follow branch protection rules.
     - Allows branch deletions.
     - Requires pull request reviews with:
       - Dismissal of stale reviews.
       - Restriction on who can dismiss reviews.
       - Mandatory code owner reviews.

3. **Deploy Key Management**:
   - Adds an SSH key as a read-only deploy key to the repository for secure access.

4. **Outputs**:
   - Provides the HTTP clone URL of the newly created repository as an output.

## Requirements

The project has the following requirements:

| Name | Version |
|------|---------|
| [Terraform](https://www.terraform.io/) | 1.9.1 |
| [GitHub Provider](https://registry.terraform.io/providers/integrations/github/latest) | ~> 6.0 |

## Inputs

The configuration accepts the following inputs:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `gh_admin_token` | Admin token for GitHub | `string` | n/a | yes |
| `gh_repo_description` | A description for the GitHub repository | `string` | n/a | yes |
| `gh_repository_name` | Name of the repository on GitHub | `string` | n/a | yes |
| `gh_repository_owner` | Owner of the repository on GitHub | `string` | n/a | yes |
| `gh_ssh_key` | An SSH key to add to the repository | `string` | n/a | yes |
| `visibility` | Visibility of the repository (`public` or `private`) | `string` | `"private"` | no |

## Outputs

The configuration provides the following output:

| Name | Description |
|------|-------------|
| `gh_address` | The HTTP clone URL of the new repository |

## Resources

The following Terraform resources are used in this configuration:

- [GitHub Repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository): Creates a new GitHub repository.
- [GitHub Branch Protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection): Configures branch protection rules for the repository.
- [GitHub Repository Deploy Key](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key): Adds an SSH deploy key to the repository.

## How to Use

1. Ensure you have Terraform installed (version 1.9.1 or later).
2. Configure the required input variables in a `.tfvars` file or through environment variables.
3. Run the following Terraform commands:
   - `terraform init` to initialize the project.
   - `terraform plan` to preview the changes.
   - `terraform apply` to create the resources.

For more details, refer to the [Terraform Documentation](terraform/terraform.md).