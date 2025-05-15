# Workflow Description: Import External Repository

This GitHub Actions workflow is designed to automate the process of importing an external repository into a new GitHub repository. It consists of two main jobs:

## Workflow Trigger
The workflow is triggered manually using `workflow_dispatch`. It accepts several input parameters to customize the import process:

### Input Parameters
- **private_email**: The email associated with the new repository.
- **gh_repo_name**: The name of the new GitHub repository (required).
- **gh_repo_owner**: The owner of the new GitHub repository.
- **gh_repo_description**: A description for the new GitHub repository (required).
- **gh_visibilty**: The visibility of the new GitHub repository (default: private).
- **external_host**: The host of the external repository (required).
- **external_repo_url**: The URL of the external repository (required).
- **external_repo_user**: The username to access the external repository.
- **external_repo_ssh_key_location**: The file location of the SSH key used to access the external repository.
- **external_repo_ssh_key_password**: The password for the SSH key, if required.

---

## Jobs

### 1. `create-gh-repository`
This job creates a new GitHub repository using a reusable workflow located at `.github/workflows/create-gh-repository.yaml`. It uses the input parameters provided to configure the repository.

#### Inputs:
- `private_email`
- `gh_repo_name`
- `gh_repo_owner`
- `gh_repo_description`
- `gh_visibilty`

#### Secrets:
- Secrets are inherited from the parent workflow.

---

### 2. `import-to-gh-repository`
This job imports the external repository into the newly created GitHub repository. It uses another reusable workflow located at `.github/workflows/clone-repository.yaml`.

#### Dependencies:
- This job depends on the `create-gh-repository` job and uses its output (`new_repo_url`) to locate the newly created repository.

#### Inputs:
- `external_host`
- `external_repo_url`
- `external_repo_user`
- `external_repo_ssh_key_location`
- `external_repo_ssh_key_password`
- `gh_repo_url` (from the output of `create-gh-repository`)
- `import_external_repo`: A flag set to `true` to indicate that the external repository should be imported.

#### Secrets:
- `gh_token`: A GitHub token used for authentication.

---

## Summary
This workflow simplifies the process of importing external repositories into GitHub by automating the creation of a new repository and the subsequent import of external code. It leverages reusable workflows for modularity and reusability.