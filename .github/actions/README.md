# GitHub Actions Overview

This repository contains custom GitHub Actions designed to automate various tasks related to repository management, SSH key generation, and Terraform operations. Below is an overview of each action and its purpose.

---

## Actions

### 1. **Configure GitHub Repository**
**File:** `configure-gh-repo/action.yaml`  
**Purpose:**  
This action is used to manage GitHub repositories using Terraform. It supports initializing, planning, applying, and destroying Terraform configurations for repository creation and management.

**Key Features:**
- Initializes Terraform with a backend configuration.
- Plans Terraform changes for repository creation or destruction.
- Applies Terraform plans to create a repository.
- Destroys Terraform-managed repositories.

**Inputs:**
- `tf_state_out`: Directory for Terraform state files.
- `repository_name`: Name of the repository.
- `repository_owner`: Owner of the repository.
- `gh_token`: GitHub token for authentication.
- `gh_repo_description`: Description of the repository.
- `gh_repo_visibility`: Visibility of the repository (e.g., public or private).
- `gh_pub_key_location`: Location of the public SSH key.
- `create_repo`: Boolean to create the repository.
- `remove_repo`: Boolean to remove the repository.

**Outputs:**
- `new_repo_url`: URL of the created repository.

---

### 2. **Download External Repository**
**File:** `download-external-repo/action.yaml`  
**Purpose:**  
This action clones an external repository, either using SSH or HTTPS authentication.

**Key Features:**
- Configures SSH for secure access to external repositories.
- Supports password-protected SSH keys.
- Clones the repository and identifies its default branch.

**Inputs:**
- `private_key_location`: Path to the private SSH key.
- `host`: Host for SSH configuration.
- `repository_address`: Address of the repository to clone.
- `key_file_password`: Password for the SSH key file.
- `username`: Username for HTTPS authentication.
- `password`: Password for HTTPS authentication.

**Outputs:**
- `repo_location`: Location of the cloned repository.
- `repo_default_branch`: Default branch of the cloned repository.

---

### 3. **Generate SSH Key**
**File:** `generate-ssh-key/action.yaml`  
**Purpose:**  
This action generates an SSH key pair for secure access to GitHub repositories.

**Key Features:**
- Creates an SSH key pair with a specified name, password, and email.
- Ensures the key is stored in a temporary directory.

**Inputs:**
- `key_name`: Name of the SSH key.
- `key_password`: Password for the SSH key.
- `email`: Email associated with the SSH key.

**Outputs:**
- `repo_key_location`: Location of the generated SSH key.

---

### 4. **Upload Repository to GitHub**
**File:** `upload-repo/action.yaml`  
**Purpose:**  
This action uploads a local repository to a GitHub repository.

**Key Features:**
- Configures the local repository to push to a GitHub repository.
- Pushes all branches and tags to the remote repository.

**Inputs:**
- `repo_location`: Path to the local repository.
- `gh_token`: GitHub token for authentication.
- `gh_repo_url`: URL of the GitHub repository.

---

## Usage
Each action is designed to be used as part of a GitHub workflow. You can include these actions in your workflows to automate tasks such as repository creation, cloning, SSH key generation, and uploading repositories.

For more details, refer to the individual `action.yaml` files in their respective directories.