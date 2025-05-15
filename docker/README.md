# Docker Setup Explanation

This project contains a Docker setup for creating an environment with Terraform and additional tools. Below is an explanation of the files and their purposes:

## Files

### 1. Dockerfile
The `Dockerfile` is used to build a Docker image with the following features:

#### Base Image
- The base image is `ubuntu:latest`.

#### First Stage: Base
- Installs essential tools like `tar`, `wget`, `gnupg`, and `unzip`.
- Defines build arguments:
  - `PRODUCT`: Specifies the product to install (default is `terraform`).
  - `VERSION`: Specifies the version of the product (default is `1.9.1`).
  - `TMP_APPS_DIR`: Temporary directory for installation files.
- Downloads and verifies the Terraform binary:
  - Fetches the Terraform binary, checksum, and signature files.
  - Imports the HashiCorp GPG key and verifies the checksum and signature.
  - Extracts the Terraform binary to a temporary directory.

#### Second Stage: Final Image
- Installs additional tools like `git`, `ca-certificates`, `openssh-client`, and `jq`.
- Copies `.pem` certificate files into the container and updates the CA certificates.
- Copies the Terraform binary from the first stage to `/usr/local/bin/`.
- Creates a new user (`guest` by default) and sets the working directory to the user's home directory.

### 2. tf.pem
The `tf.pem` file contains a certificate in PEM format. It is used to add a trusted certificate to the container's CA store. This is useful for secure communication with specific services.

## Summary
This setup creates a Docker image with:
- Terraform installed and verified.
- Additional tools for development and deployment.
- A custom user environment.
- Support for custom certificates.

You can use this Docker image to work with Terraform and related tools in a secure and isolated environment.