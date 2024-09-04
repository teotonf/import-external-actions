# Custom GitHub Actions Workflow

This repository contains a GitHub Actions workflow that automates the following steps:

1. **Checkout Repository**: Checks out the code from the repository.
2. **Create Repository on GH**: Creates a new repository on GitHub.
3. **Download External Git Repository**: Downloads an external Git repository specified by the URL.
4. **Upload New Repository**: Uploads the new repository to GitHub.

## Usage

To use this workflow, ensure you have created the necessary custom actions in the `.github/actions` folder. Each action should be able to accept the required inputs as specified in the workflow.

### Secrets

Make sure to set the following secrets in your GitHub repository settings:

- `GH_USER`: Your GitHub username.
- `GH_PASSWORD`: Your GitHub password or personal access token.

## Requirements

- This workflow is designed to run on `ubuntu-latest`.
- Ensure that your necessary permissions are granted for repository creation and access.

Feel free to customize the actions to suit your needs!