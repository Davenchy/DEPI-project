# Gogs Setup

When running the Gogs container for the first time, the `gogs-config.ini` file, which contains the default Gogs configuration, will automatically set up your server and prevent the default first-time setup page from appearing. The Gogs server will open directly on the login screen.

For more details about the configuration file fields, refer to the [official documentation](https://github.com/gogs/gogs/blob/main/conf/app.ini).

The only thing you need to do is create your first account. **By default, the first account will be an admin account**.

## Pushing Code to the Gogs Repository

- Create an **empty** repository in Gogs.
- Add the new repository as a remote to your local repository:

  ```sh
  # Since the local repository is on your host machine,
  # the 'gogs' hostname will be 'localhost'
  git remote add gogs http://localhost:3000/<username>/<repository>.git
  ```

- Now push the code:

  ```sh
  git push gogs main
  ```

## Setting Up the Webhook

To set up a webhook in your Gogs repository, follow these steps:

1. Click on the `Settings` button.
2. Select `Webhooks` from the **Settings** menu.
3. In the `Add a new webhook` dropdown, select `Gogs`.
4. Set the **Payload URL** to `http(s)://<< jenkins-server >>/gogs-webhook/?job=<< jobname >>` (e.g., `http://jenkins:8080/gogs-webhook/?job=depi-project`).
5. Set the **Secret** to the secret you defined in the Jenkins pipeline (e.g., `my_webhook_secret`).
6. Click the `Add webhook` button.
7. Click on the created webhook in the list and then click the `Test Delivery` button at the bottom of the page.
8. If everything is set up correctly, you will see a new delivery entry in the list with a green checkmark.
