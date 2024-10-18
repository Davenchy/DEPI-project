# Prometheus and Grafana Guide

You can use Grafana to visualize the metrics collected by Prometheus for a more insightful display.

Here’s a simple guide to connect Prometheus to Grafana and set up a basic dashboard.

### Step 1: Log in to Grafana

Grafana is accessible on port **3001**.

> **Note:** After starting the Grafana container, it may take a few minutes to fully initialize, especially on the first run.

- Default login credentials are `admin/admin`. After logging in, you'll be prompted to set a new password.

### Step 2: Add Prometheus as a Data Source

- From the side menu, click on **Connections**.
- If no data sources exist, you’ll be redirected to the **Add new connection** page.
- Search for `Prometheus`, then click on it.
- On the connection details page, click **Add new data source**. You can also find the [official documentation](http://docs.grafana.org/datasources/prometheus) for more details.
- Under **Connection**, enter the **Prometheus server URL** (e.g., `http://prometheus:9090`).
  > Since the Prometheus and Grafana containers share the same virtual network, use the container name as the hostname.
- Under **TLS settings**, check **Skip TLS certificate verification**.
- Click **Save & Test** to confirm.

### Step 3: Add a Dashboard

- From the side menu, click **Dashboards**.
- Click **New**, then select **New dashboard**.
- Click the **Import dashboard** button.

  We’ll use a pre-built dashboard designed for Prometheus Node Exporter: [Node Exporter Full](https://grafana.com/grafana/dashboards/1860-node-exporter-full), with ID: **1860**.

- In the **Dashboard URL or ID** field, type `1860`. You can also explore other [dashboards](https://grafana.com/grafana/dashboards/).
- Click **Load**.

A new page will open.

- In the **Prometheus** dropdown, select the Prometheus data source we just created.
- Finally, click **Import**.

Your dashboard is now ready, and you should see metrics displayed.
