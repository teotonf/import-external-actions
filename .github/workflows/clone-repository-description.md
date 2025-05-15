# Workflow: Clone External Repository

This GitHub Actions workflow is designed to clone an external repository and optionally upload it to a GitHub repository. It supports both `workflow_call` and `workflow_dispatch` triggers, allowing it to be invoked programmatically or manually.

## Workflow Details

### Name
**Clone external repository**

### Triggers
1. **workflow_call**: Allows this workflow to be called by other workflows. It accepts the following inputs:
   - `external_host`: Host of the external repository (required).
   - `external_repo_url`: URL of the external repository (required).
   - `external_repo_user`: User to access the external repository.
   - `external_repo_ssh_key_location`: Location of the SSH key file for read access to the external repository.
   - `external_repo_ssh_key_password`: Password for the SSH key file, if required.
   - `gh_repo_url`: Name of the new GitHub repository (required).
   - `import_external_repo`: Boolean flag to indicate whether the external repository should be imported into GitHub.

   Secrets:
   - `gh_token`: GitHub token for authentication (required).

2. **workflow_dispatch**: Allows manual triggering of the workflow. It accepts the same inputs as `workflow_call`.

### Jobs
#### `import-to-gh-repository`
This job runs on `ubuntu-latest` and performs the following steps:

1. **Checkout repository**:
   - Uses the `actions/checkout@v1` action to check out the current repository.

2. **Clone external repository**:
   - Uses a custom action located at `.github/actions/download-external-repo` to clone the external repository.
   - Inputs:
     - `host`: Host of the external repository.
     - `repository_address`: URL of the external repository.
     - `private_key_location`: Location of the SSH key file.
     - `key_file_password`: Password for the SSH key file (retrieved from secrets).
     - `username`: Username for accessing the external repository.
     - `password`: Password for accessing the external repository (retrieved from secrets).

3. **Upload the repository to GitHub**:
   - Uses a custom action located at `.github/actions/upload-repo` to upload the cloned repository to GitHub.
   - This step is conditional and only runs if `import_external_repo` is set to `true`.
   - Inputs:
     - `repo_location`: Location of the cloned repository (output from the previous step).
     - `gh_token`: GitHub token for authentication.
     - `gh_repo_url`: URL of the target GitHub repository.

### Notes
- The workflow uses custom actions (`download-external-repo` and `upload-repo`) located in the `.github/actions` directory.
- Secrets are used to securely pass sensitive information like passwords and tokens.

This workflow is ideal for automating the process of cloning external repositories and importing them into GitHub.