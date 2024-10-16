# Jenkins Setup

After starting the Jenkins server using Docker Compose, follow these steps to set up the Jenkins pipeline:

## Credentials

The `Jenkinsfile` requires specific credentials to be set up.

To add credentials:

1. From `Manage Jenkins`, select `Credentials`.
2. Select the `System` scope, then the `Global credentials` domain.
3. Click `Add Credentials`.
4. Select the credential type and fill in the required parameters.

### Docker Hub Credentials

Used to log in to Docker Hub.

- **Kind:** Username with password
- **ID:** The `Jenkinsfile` expects this to be `DockerHub`.
- **Username:** Your Docker Hub username.
- **Password:** Your Docker Hub password or an access token with **Read & Write** permissions.

### Deployment Server SSH Private Key

Used by Ansible to connect to the deployment server via SSH.

- **Kind:** SSH Username with private key
- **ID:** The `Jenkinsfile` expects this to be `DeployServerSSHPrivateKey`.
- **Username:** The deployment server's username (e.g., **ubuntu** for Ubuntu servers).

Next:

- Check `Enter directly`.
- Click `Add`.
- Paste your private key.
- If your private key has a passphrase, enter it in the **passphrase** field.

### Slack Credentials

Used by the `slackSend` command to send notifications.

- **Kind:** Secret text
- **ID:** SlackBotToken
- **Secret:** Enter the token from your Slack bot's authentication page (for more details, refer [here](#slack-notifications)).

## Ansible Tool Configuration

To configure Ansible:

1. From `Manage Jenkins`, select `Tools`.
2. Under `Ansible installations`, click `Add Ansible`.
3. Use the following parameters:
   - **Name:** The `Jenkinsfile` expects this to be `Ansible`.
   - **Path to ansible executable:** This is expected to be `/usr/bin` (already installed by the Dockerfile).

## Slack Notifications

To configure Slack notifications:

1. From `Manage Jenkins`, select `System`.
2. Under the `Slack` section, provide the following details:
   - **Workspace:** Your Slack workspace (e.g., `https://example.slack.com`).
   - **Credentials:** Select the credentials created [earlier](#slack-credentials) (`SlackBotToken`).
   - **Default channel/member ID:** The channel where notifications will be sent (e.g., `#jenkins`).
   - Check `Custom Slack app bot user`.

For more information on credentials and access tokens, check the [Slack Notifications Jenkins plugin](https://github.com/jenkinsci/slack-plugin) documentation under the **Create your app** section.

## The Pipeline

After setting up everything, follow these steps to create the pipeline:

1. From the `Dashboard`, add a new job.
2. Name it, for example, `depi-project`.
3. Select `Pipeline` as the job type.

Under the **Gogs Webhook** section:

- Check the **Use Gogs secret** checkbox and enter your webhook secret (e.g., `my_webhook_secret`).
- Check the **Branch Filter** checkbox and specify the branch (e.g., `main`) that should trigger the pipeline.

Under the **Build Triggers** section:

- Check the `Build when a change is pushed to Gogs` checkbox.

Under the **Pipeline** section:

- Set **Definition** to `Pipeline script from SCM`.
- Select `Git` under **SCM**.

Then:

- Enter your Gogs repository URL (e.g., `http://gogs:3000/davenchy/depi-project.git`).
- Set credentials if the repository is private.
- Under **Branches to build**, specify `*/main` or the branch you want to build.
- Set **Script Path** to `devops/Jenkinsfile`, as the `Jenkinsfile` is located in the `devops/` directory.
