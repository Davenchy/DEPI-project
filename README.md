# DevOps Pipeline DEPI Project

This project is an automated CI/CD pipeline designed to streamline the development, testing, and deployment processes. It integrates Gogs, Jenkins, Ansible, Docker, Prometheus, and Grafana for source code management, continuous integration, monitoring, and automated deployment. With each push to the repository, a Jenkins pipeline is triggered to run tests, build Docker images, and deploy the application to a production server. Ansible handles server configuration and deployment automation, while Slack notifications keep the team informed of the pipeline’s status in real time.

The application itself is based on a default Vite + React + TypeScript template, generated using `bun create vite my-app --template react-swc-ts`. A `tests/` directory with a basic passing test case has been added to demonstrate the testing stage.

All DevOps-related code is located in the `devops/` directory. For more details, see the [DevOps Docs](devops/README.md).

This project was developed as part of a team graduation project in the [Digital Egypt Pioneers Initiative - DEPI](https://depi.gov.eg/) DevOps track.

---

## Resources

- **Docker Image:** `davenchy/depi-project:latest`
- **Slides:** [React App CI/CD Pipeline Slides](https://www.canva.com/design/DAGURjduqyQ/iwJD2VckKB9XEvXUlsNSyA/view?utm_content=DAGURjduqyQ&utm_campaign=designshare&utm_medium=link&utm_source=editor).

## Tools

- **Jenkins**: Automates the CI/CD pipeline.
- **Ansible**: Automates server configuration and deployment.
- **Gogs**: Source Code Management (SCM) tool.
  > Why Gogs? It’s lightweight, easy to use, and handles both source code management and webhook-based pipeline triggers.
  > GitLab CE was considered but was too resource-heavy for a local machine with modest capabilities.
- **Bun**: A TypeScript runtime used for package management (instead of npm), testing, and building/bundling.
- **Docker**: The backbone of the infrastructure, used to containerize all services.
- **Prometheus & Grafana**: Used for monitoring and visualizing metrics. Prometheus collects and stores metrics, while Grafana provides powerful dashboards to visualize them.

## Jenkins Plugins

- **docker-workflow**: Enables Docker integration in the pipeline to run Bun and build deployment images.
- **ansible**: Enables the use of Ansible within the pipeline.
- **gogs-webhook**: Triggers the Jenkins pipeline on Gogs webhook requests.
- **slack**: Sends notifications to Slack for pipeline updates.
