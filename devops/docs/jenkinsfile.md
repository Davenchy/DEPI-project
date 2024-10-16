# Jenkinsfile Documentation

This Jenkinsfile defines a CI/CD pipeline for building, testing, deploying a React project (using Vite) with Docker, and notifying the team via Slack. It automates the following steps: initializing the pipeline, installing dependencies, running tests (if enabled), building the project, creating a Docker image, pushing it to Docker Hub, and finally deploying it using Ansible.

## Overview of Key Features

- **Slack Notifications:** Sends status updates to a Slack channel at different stages of the pipeline (start, success, failure).
- **Parameterized Pipeline:** Allows customization of the Docker image tag and whether to run tests.
- **Docker Integration:** Uses `oven/bun:alpine` for dependency management, tests, and building the React app.
- **Build and Push Docker Image:** Builds the deployment Docker image (based on `nginx:alpine`) and pushes it to Docker Hub.
- **Ansible Deployment:** Uses Ansible to deploy the application on a remote server.

## Pipeline Parameters

- **ImageTag:** Defines the Docker image tag to be used for building and pushing the image (default: `davenchy/depi-project:latest`).
- **RunTests:** A boolean flag to control whether to run tests or skip them (default: true).

## Pipeline Stages

### 1. `init`

- Sends a Slack message indicating that the pipeline has started.

### 2. `install deps`

- Runs in the `oven/bun:alpine` Docker image.
- Installs the project dependencies using `bun install`.

### 3. `tests`

- Runs in the `oven/bun:alpine` Docker image.
- Executes tests using `bun test` **only if** `RunTests` is set to `true`.

### 4. `build`

- Runs in the `oven/bun:alpine` Docker image.
- Builds the project using `bun run build`, which outputs a `dist/` directory with static assets.

### 5. `build and push image`

- Builds a Docker image using the `devops/deploy_dockerfile`, which serves the contents of the `dist/` directory via Nginx.
- Authenticates with Docker Hub using credentials (stored securely in Jenkins).
- Pushes the Docker image to Docker Hub using the `ImageTag` parameter.

### 6. `Deploy`

- Deploys the Docker image to a remote server using an Ansible playbook.
- Uses SSH credentials to connect to the remote server and execute the `Ansible.yml` playbook.

## Post Actions

- **Success:** If the pipeline succeeds, it sends a Slack notification with a green "Success" message, including the build duration.
- **Failure:** If the pipeline fails, it sends a Slack notification with a red "Failure" message, including the build duration.

## Credential Requirements

The following credentials are expected to be configured in Jenkins as per the setup:

- **DockerHub:**

  - **Kind:** Username with password
  - **ID:** `DockerHub`
  - **Usage:** This credential is used in the `build and push image` stage to log into Docker Hub and push the image.

- **DeployServerSSHPrivateKey:**

  - **Kind:** SSH Username with private key
  - **ID:** `DeployServerSSHPrivateKey`
  - **Usage:** Used in the `Deploy` stage to authenticate via SSH and run the Ansible playbook on the remote server.

- **SlackBotToken:**
  - **Kind:** Secret text
  - **ID:** `SlackBotToken`
  - **Usage:** Used in all stages to send notifications to a Slack channel about the pipeline's progress and status.

## Slack Integration

Slack messages are sent at the following points in the pipeline:

- Pipeline start (`init` stage)
- Dependency installation, testing, and building stages
- Image build and push stage
- Deployment stage
- On pipeline success or failure

The `slackSend` function is used to send notifications to Slack with details about the pipeline status and a link to the Jenkins build. Ensure that the `SlackBotToken` credential is set up as described in the Jenkins setup process.

## Ansible Deployment

- The pipeline uses the Ansible plugin to deploy the Docker image to the production server.
- The inventory file, playbook, and other Ansible configuration files are located in the `devops/ansible/` directory.
- The Ansible playbook installs Docker, configures the firewall, and runs the newly built Docker image.
- Make sure the `DeployServerSSHPrivateKey` credential is configured correctly for the deployment step.
