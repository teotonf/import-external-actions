# Explanation of `create-gh-repository.yaml`

This file defines a GitHub Actions workflow named **"Create GH repository"**. Below is a detailed explanation of its structure and functionality:

## Workflow Name and Trigger

- **Name**: `Create GH repository`
- **Run Name**: `Create GH repository 🚀`
- **Triggers**:
  - `workflow_call`: Allows this workflow to be called by other workflows. It accepts several inputs and provides an output.
  - `workflow_dispatch`: Allows manual triggering of the workflow via the GitHub Actions interface. It also accepts similar inputs.

## Inputs

The workflow accepts the following inputs:

1. **`private_email`**: (Optional) Email associated with the repository.
2. **`gh_repo_name`**: (Required) Name of the new repository.
3. **`gh_repo_owner`**: (Optional) Owner of the new repository.
4. **`gh_repo_description`**: (Required) Description of the new repository.
5. **`gh_visibilty`**: (Optional) Visibility of the repository. Defaults to `private`.
6. **`create_repo`**: (Required) Boolean to determine whether to create the repository or just see the Terraform plan. Defaults to `true`.
7. **`remove_repo`**: (Required) Boolean to determine whether to remove the repository. Defaults to `false`.

## Outputs

- **`new_repo_url`**: The URL of the newly created repository. This is derived from the `configure-gh-repository` job.

## Jobs

### `configure-gh-repository`

This job is responsible for creating or managing the GitHub repository. It runs on an `ubuntu-latest` environment and has the following steps:

1. **Checkout Repository**:
   - Uses the `actions/checkout@v1` action to clone the repository.

2. **Configure SSH Key**:
   - Uses a custom action located at `.github/actions/generate-ssh-key`.
   - Generates an SSH key for the repository using the provided inputs (`gh_repo_name`, `private_email`) and a secret (`gh_ssh_key_password`).

3. **Terraform Init / Plan / Apply**:
   - Uses another custom action located at `.github/actions/configure-gh-repo`.
   - Executes Terraform commands to manage the repository's state.
   - Inputs include:
     - `tf_state_out`: Path to store the Terraform state.
     - `repository_name`, `repository_owner`, `gh_repo_description`, `gh_repo_visibility`: Details about the repository.
     - `gh_token`: GitHub token (retrieved from secrets).
     - `gh_pub_key_location`: Location of the public SSH key.
     - `create_repo`, `remove_repo`: Boolean flags to control repository creation or removal.

### Key Features

- **Custom Actions**: The workflow uses two custom actions:
  1. `.github/actions/generate-ssh-key`: For generating SSH keys.
  2. `.github/actions/configure-gh-repo`: For managing the repository using Terraform.
- **Terraform Integration**: The workflow leverages Terraform to handle repository creation, visibility, and other configurations.
- **Secrets Management**: Sensitive data like `gh_token` and `gh_ssh_key_password` are securely accessed via GitHub Secrets.

### Summary

This workflow is designed to automate the creation and management of GitHub repositories using Terraform. It supports both manual and programmatic triggers, making it versatile for various use cases. The use of custom actions and Terraform ensures flexibility and scalability in managing repositories.