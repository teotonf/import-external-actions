# Project Documentation Summary

This document provides a summarized overview of the key components and functionalities described in the project files.

---

## GitHub Actions

### [GitHub Actions Overview](.github/actions/README.md)
The project includes custom GitHub Actions for automating repository management, SSH key generation, and Terraform operations. Key actions include:
- **Configure GitHub Repository**: Manages repositories using Terraform.
- **Download External Repository**: Clones external repositories via SSH or HTTPS.
- **Generate SSH Key**: Creates SSH key pairs for secure access.
- **Upload Repository to GitHub**: Pushes local repositories to GitHub.

Each action is designed to be integrated into workflows for automation.

---

## Workflows

### [Clone External Repository](.github/workflows/clone-repository-description.md)
This workflow automates cloning an external repository and optionally uploading it to GitHub. It supports both programmatic (`workflow_call`) and manual (`workflow_dispatch`) triggers. Key jobs include:
1. **Clone external repository**: Uses the `download-external-repo` action.
2. **Upload to GitHub**: Uses the `upload-repo` action (conditional).

### [Create GitHub Repository](.github/workflows/create-gh-repository-explanation.md)
This workflow automates the creation of GitHub repositories using Terraform. It supports:
- SSH key generation via the `generate-ssh-key` action.
- Repository management via the `configure-gh-repo` action.
- Both manual and programmatic triggers.

### [Import External Repository](.github/workflows/import-external-to-gh-description.md)
This workflow combines repository creation and external repository import. It consists of:
1. **Create GitHub Repository**: Uses the `create-gh-repository` workflow.
2. **Import External Repository**: Uses the `clone-repository` workflow to clone and upload external repositories.

---

## Docker Setup

### [Docker Setup Explanation](docker/README.md)
The Docker setup provides an environment with Terraform and additional tools. Key features include:
- A multi-stage `Dockerfile` for building images with Terraform, Git, and SSH tools.
- Support for custom certificates via `.pem` files.
- A user-friendly environment for Terraform operations.

---

## Terraform Configuration

### [Terraform GitHub Repository Management](terraform/terraform_overview.md)
The Terraform configuration automates GitHub repository management. Key features include:
- **Repository Creation**: Creates repositories with specified names, descriptions, and visibility.
- **Branch Protection**: Enforces rules for the `main` branch.
- **Deploy Key Management**: Adds SSH deploy keys for secure access.

### [Terraform Requirements and Resources](terraform/terraform.md)
The configuration uses the `github` provider and includes resources for:
- Repository creation.
- Branch protection.
- Deploy key management.

Inputs and outputs are defined for flexibility and integration.

---

## How to Use

1. Refer to the [GitHub Actions Overview](.github/actions/README.md) for details on custom actions.
2. Explore the [Workflows](#workflows) section for automation examples.
3. Use the [Docker Setup](docker/README.md) for a pre-configured Terraform environment.
4. Follow the [Terraform Documentation](terraform/terraform_overview.md) for repository management.

For more details, click on the respective links provided above.