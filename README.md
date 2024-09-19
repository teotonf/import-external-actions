# GitHub Actions Workflow for import an external repository to GitHub

This repository is being used to run github actions locally using [act][nektos-act] to create and import an external repository to github.
Act repository can be found in [act-repo][nektos-act-repo] 

> Note: no vars nor secrets where created on repo, so trying to run it on GH will not work.

## Repository organization
- .github: contains the workflow code
- docker: contains the configurations for generate a runner locally. The image has all tools required for the complete workflow execution.
- terraform: Terraform code to create the GH repository.

## Configuration requirements
- Docker installed
- Nektos act installed

### Creating the runner
To configure a runner use the [Dockerfile](./docker/Dockerfile) to create an image with the name `gh-runner` (the name of container will be used for the example)

### Configuring inputs and secrets
For the example we will use files to configure inputs and secrets.
Create a folder called `act-scripts` in `$HOME` folder, for example.
Then supposing we want to migrate more than once repository, create a folder within `act-scripts` let's say `foo`. Then in `$HOME/act-scripts/foo` create a file called `inputs` with the contents as follows:

```sh
# This the private key generated for read-only access in the new GH repo
private_key_location=/tmp/tf-output/foo-ssh-key
# For the key generation
private_email=<your better email>
# The name of the new repo to be created
gh_repo_name=my-foo
# The new repo owner
gh_repo_owner=<repo owner>

# Some description for your repository
gh_repo_description="Applications to be used by flux"

# These configurations are to use when you configured ssh access in the external repository to be imported
external_host=bitbucket.org
external_repo_ssh_key_location=/tmp/certificates/bitbucket/read-only

# Define it accordingly to the approach to access external repo (SSH / HTTPS). If both access was configured, SSH has precedence
external_repo_url=git@bitbucket.org:fred-bede/foo

# Create / Remove / Plan (changing default values)
# If you want to just create the repo in GH uncomment the next line
#import_external_repo=false

# You can create or delete the repo, based on Terraform plan
# Note that setting create and remove to "true" Terraform will just run the plan and do not apply any changes
# create_repo=true
# remove_repo=true

# New repo visibility. If set to "public" default branch will be protected with PR requirement at least
# gh_visibilty=public
```

Configure secrets in file `$HOME/act-scripts/foo/secrets` as follows:
```sh
# Personal token with admin permission at least on repos
gh_token=<your personal token in GH>

# git ssh approach for external access
# if you protected your private key with password
external_repo_ssh_key_password=<your external pkey password>

# git https approach for external access
external_repo_password=<your external repository password>

# Note that if both HTTPS/SSH aproaches where defined, SSH has precedence

# protect your GH repository read-only key with a password 
gh_ssh_key_password=<GH pkey password>
```

At last, define a script in `$HOME/act-scripts/import-repos.sh` to run act as follows:

```sh
#!/bin/bash

# You can input the name of the folder that has the "inputs" and "secrets" files
REPO_NAME=$1

# Where you downloaded this repository
REPO_LOCATION="$HOME/github/import-repository"

# Location of the scripts. For this tutorial 
SCRIPT_ARGS_LOCATION="$HOME/act-scripts/$REPO_NAME"

# Terraform state output location
TF_STAT_DIR="$REPO_LOCATION/my-tf-state"

act \
--secret-file=$SCRIPT_ARGS_LOCATION/secrets \
--input-file=$SCRIPT_ARGS_LOCATION/inputs \
--rm \
-C $REPO_LOCATION \
-P ubuntu-latest=gh-runner \ # Name of the runner we defined when building the docker image in the beggining of this document
--action-offline-mode \
-W $REPO_LOCATION/.github/workflows/import-external.yaml \
--local-repository github.com@main=$REPO_LOCATION \
--container-options "-v $HOST_CERTIFICATES_LOCATION:/tmp/certificates \
-v $TF_STAT_DIR/my-tf-state:/tmp/import-tf-state \ 
-v $TF_STAT_DIR/tf-output:/tmp/tf-output" # Map your ssh keys for external access to a place within gh-runner container
```

At the end, you should have something like:
- $HOME
  - act-scripts
    - foo
      - secrets
      - inputs
    - import-repos.sh

So to execute on `foo` repository config run:
```sh
cd $HOME/act-scripts
. ./import-repos.sh "foo"
```

After run, you can get your GH read-only keys in `<Root folder you'd downloaded this repo>/my-tf-state/tf-output` folder

[nektos-act-repo]: <https://github.com/nektos/act>
[nektos-act]: <https://nektosact.com>
