App Service provides diagnostic tools for monitoring container health, viewing logs, and troubleshooting issues. Understanding these tools helps you identify problems quickly and maintain reliable production deployments.

## Container logs

App Service captures output from your container's stdout and stderr streams. This output includes application logs, framework messages, and error output. Enable container logging to persist these logs and make them available through the portal and CLI.

Enable container logging:

```azurecli
az webapp log config \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --docker-container-logging filesystem
```

The `filesystem` option stores logs in the App Service file system. Logs are available at `/home/LogFiles/` and through the diagnostic tools described in this unit.

Container logs capture several types of output:

- **Application output:** Messages your application writes to stdout
- **Error output:** Exception traces and error messages written to stderr
- **Framework logs:** Web server startup messages, request logs, and framework diagnostics
- **Platform messages:** App Service messages about container lifecycle events

Configure your application to write meaningful log output to stdout. Most logging frameworks support console output that App Service captures automatically.

## Log stream

The log stream provides real-time access to container output. This tool is useful for debugging startup issues, monitoring live traffic, and observing application behavior during testing.

Stream logs using the Azure CLI:

```azurecli
az webapp log tail \
    --resource-group myResourceGroup \
    --name myDocumentProcessor
```

The log stream displays new log entries as they appear. Press Ctrl+C to stop streaming.

In the Azure portal, navigate to your web app and select **Log stream** under **Monitoring**. The portal displays the same real-time log output in a browser-based viewer.

The log stream shows output from all instances in a scaled-out app. Each line includes an instance identifier to help you correlate logs across instances.

## Diagnostic console (Kudu)

Kudu (the SCM site) is the advanced diagnostic console for App Service. It provides access to app configuration views, log files in mounted storage, and diagnostic endpoints. Access the SCM site at:

```
https://<app-name>.scm.azurewebsites.net
```

The SCM site runs as a separate site for your app and requires authentication with credentials that can manage your web app.

Key Kudu features for container troubleshooting:

- **Environment variables:** The Environment page displays all environment variables available to your container. This view helps verify that app settings are configured correctly and shows system-provided variables.

- **File system browser:** The Debug console provides access to files in the mounted storage paths (such as `/home`). Browse log files at `/home/LogFiles/` and inspect any content you write to `/home`.

- **Limitations:** The SCM site isn't the same environment as your app container, so it doesn't let you browse the full container file system or inspect running processes inside the app container. Use SSH (when enabled in your image) for in-container inspection.

- **Diagnostic dump:** Download a ZIP file containing log files, configuration, and diagnostic information. This dump is useful for offline analysis or sharing with support.

## Platform diagnostics

For long-term log retention and advanced analysis, configure diagnostic settings to send logs to Azure Monitor, Event Hubs, or storage accounts.

Configure diagnostic settings to send logs to a Log Analytics workspace:

```azurecli
resourceId=$(az webapp show -g myResourceGroup -n myDocumentProcessor --query id -o tsv)
workspaceId=$(az monitor log-analytics workspace show -g myResourceGroup -n myLogAnalyticsWorkspace --query id -o tsv)

az monitor diagnostic-settings create \
    --resource "$resourceId" \
    --name myDiagnosticSettings \
    --workspace "$workspaceId" \
    --logs '[{"category":"AppServiceConsoleLogs","enabled":true},{"category":"AppServiceHTTPLogs","enabled":true}]'
```

Available log categories for containerized apps include:

| Category | Description |
|----------|-------------|
| AppServiceConsoleLogs | Container stdout and stderr output |
| AppServiceHTTPLogs | HTTP request and response information |
| AppServicePlatformLogs | Container lifecycle events and platform messages |
| AppServiceAppLogs | Application-level logs (when configured) |

With logs flowing to Log Analytics, you can write queries to analyze patterns, create alerts, and build dashboards. For example, query recent errors:

```kusto
AppServiceConsoleLogs
| where Level == "Error"
| where TimeGenerated > ago(1h)
| project TimeGenerated, ResultDescription
| order by TimeGenerated desc
```

## SSH access

For interactive troubleshooting, you can connect to a running container using SSH. This capability requires SSH to be enabled in your container image.

Configure your container to support SSH by including the OpenSSH server and configuring it to listen on port 2222. The container must:

1. Install the `openssh-server` package
1. Configure SSH to listen on port 2222
1. Set the root password to `Docker!` (required by App Service)
1. Start the SSH daemon alongside your application

Example Dockerfile additions for SSH support:

```dockerfile
RUN apt-get update && apt-get install -y openssh-server \
    && echo "root:Docker!" | chpasswd

COPY sshd_config /etc/ssh/

EXPOSE 8000 2222

CMD ["/bin/bash", "-c", "service ssh start && gunicorn app:application"]
```

After configuring SSH in your container, access the SSH console through the Azure portal by navigating to your web app and selecting **SSH** under **Development Tools**.

## Common issues and solutions

Understanding common container deployment issues helps you troubleshoot problems efficiently.

### Container fails to start

**Symptoms:** The application URL returns an error, and container logs show startup failures.

**Diagnosis:**

1. Check container logs for application errors using the log stream
1. Verify the image exists in the registry and credentials are correct
1. Confirm the container runs locally with the same configuration

**Common causes:**

- Missing environment variables that the application requires at startup
- Port mismatch between `WEBSITES_PORT` and the port the container listens on
- Application crashes during initialization due to missing dependencies

### 404 responses after deployment

**Symptoms:** The container appears to start, but requests return 404 Not Found errors.

**Diagnosis:**

1. Verify `WEBSITES_PORT` matches the port your application listens on
1. Check that the application binds to `0.0.0.0` rather than `localhost`
1. Confirm the application serves requests at the root path or expected routes

**Common causes:**

- Application listening on localhost instead of all interfaces
- Incorrect port configuration
- Application routing not configured for the expected paths

### Missing environment variables

**Symptoms:** The application logs errors about missing configuration or undefined values.

**Diagnosis:**

1. Verify app settings are saved in the portal or CLI
1. Check environment variables in Kudu to confirm injection
1. If you use SSH for troubleshooting, verify variables using the SCM `/Env` view when shell output seems incomplete

**Common causes:**

- Settings not saved after editing
- Typos in setting names
- Application checking for variables before App Service injects them

### Slow cold starts

**Symptoms:** First requests after idle periods take longer than subsequent requests.

**Diagnosis:**

1. Check container image size using `docker images`
1. Review application startup time in logs
1. Verify always-on setting

**Solutions:**

- Enable always-on to keep the application warm
- Reduce container image size by using smaller base images and multi-stage builds
- Optimize application startup by deferring heavy initialization

## Additional resources

- [Enable diagnostic logging for apps in Azure App Service](/azure/app-service/troubleshoot-diagnostic-logs)
- [Troubleshoot an app in Azure App Service using Visual Studio](/azure/app-service/troubleshoot-dotnet-visual-studio)
- [Azure App Service diagnostics overview](/azure/app-service/overview-diagnostics)
