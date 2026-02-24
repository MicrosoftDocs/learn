Container runtime settings control how App Service executes your container. These settings affect container startup, network configuration, file system behavior, and health monitoring. Configuring these settings correctly ensures your application starts reliably and performs well under load.

## Startup commands

App Service runs containers using the entrypoint and command defined in the Dockerfile. You can override these defaults with a custom startup command when you need to pass runtime arguments, run initialization scripts, or modify the container's default behavior.

Common scenarios for custom startup commands include:

- Passing environment-specific arguments to the application
- Running database migrations before starting the application
- Starting multiple processes within the container
- Overriding default framework configurations

Configure a startup command using the Azure CLI:

```azurecli
az webapp config set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --startup-file "gunicorn --bind=0.0.0.0:8000 --workers=4 app:application"
```

The startup command replaces the CMD instruction from your Dockerfile. The ENTRYPOINT remains unchanged unless you modify the container configuration directly.

For containers that require shell processing, prefix the command with the shell:

```azurecli
az webapp config set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --startup-file "/bin/bash -c 'python migrate.py && gunicorn app:application'"
```

## Port configuration

App Service needs to know which port inside your container receives HTTP requests. For custom containers, App Service can automatically route traffic when your container listens on port 80 or 8080. If your container listens on a different port, configure the `WEBSITES_PORT` app setting so App Service forwards requests to the correct port.

```azurecli
az webapp config appsettings set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --settings WEBSITES_PORT=8000
```

App Service routes all incoming HTTP and HTTPS traffic to the specified port. The platform handles TLS termination before traffic reaches your container, so your container receives HTTP traffic even when clients connect over HTTPS.

App Service supports exposing only one port for HTTP requests to a custom container.

Common port configurations:

| Framework | Default Port | Setting |
|-----------|-------------|---------|
| Node.js (Express) | 3000 | `WEBSITES_PORT=3000` |
| Python (Gunicorn) | 8000 | `WEBSITES_PORT=8000` |
| Java (Spring Boot) | 8080 | `WEBSITES_PORT=8080` |
| ASP.NET Core | 80 | No change needed |

## Persistent storage

By default, writes to the container file system are ephemeral. Data written to the file system is lost when the app restarts or moves to different infrastructure. This behavior matches standard container expectations but requires explicit planning when your application needs persistent files.

App Service can mount persistent storage at `/home` for Linux custom containers. Persistent storage is disabled by default for Linux custom containers. When this storage is enabled, files written to `/home` survive app restarts and are shared across all instances of a scaled-out app.

Enable persistent storage by setting the `WEBSITES_ENABLE_APP_SERVICE_STORAGE` app setting to `true`:

```azurecli
az webapp config appsettings set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --settings WEBSITES_ENABLE_APP_SERVICE_STORAGE=true
```

With this setting enabled:

- The `/home` directory persists across container restarts
- All instances in a scaled-out app share the same `/home` content
- The `/home/LogFiles` directory stores container and application logs

Configure your application to write persistent data to `/home` or a subdirectory. For example, a document processing service might write processed output to `/home/output/`.

Storage capacity depends on your App Service plan. The storage quota is shared across all apps in the plan. For applications requiring large storage volumes or high I/O performance, consider mounting Azure Storage as an extra volume.

## Always-on

App Service apps can become idle after about 20 minutes of inactivity. The next request triggers a cold start, which means App Service has to start the app again and wait for it to become ready. Cold starts can take several seconds to minutes depending on image size, dependency initialization, and application startup time.

Enable always-on to keep your application loaded continuously:

```azurecli
az webapp config set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --always-on true
```

With always-on enabled, App Service sends periodic requests to keep the application warm. This configuration eliminates cold start latency but requires the Basic pricing tier or higher.

Always-on is recommended for:

- Production applications where response time matters
- Applications with long startup times
- Containers with large images that take time to pull
- Services that maintain background processes or connections

## Health checks

Health checks monitor container responsiveness and automatically restart unhealthy instances. App Service sends HTTP requests to a specified path and evaluates the response to determine container health.

Configure a health check path:

```azurecli
az webapp config set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --generic-configurations '{"healthCheckPath": "/health"}'
```

Your application should implement a health endpoint that returns an HTTP 200 status code when healthy. The endpoint can perform checks such as:

- Verifying database connectivity
- Confirming required services are reachable
- Checking available memory or disk space

App Service pings the health check path every minute. If an instance repeatedly fails (by default, after 10 failed pings), App Service removes that instance from the load balancer rotation. If the instance remains unhealthy for an extended period, App Service can replace it.

Health check configuration changes restart your app, so apply changes carefully in production.

A simple health endpoint implementation returns a 200 status when the application can handle requests:

```python
@app.route('/health')
def health_check():
    return {'status': 'healthy'}, 200
```

For more sophisticated checks, verify dependencies and return appropriate status codes:

```python
@app.route('/health')
def health_check():
    try:
        # Check database connection
        db.execute('SELECT 1')
        # Check storage access
        storage.list_containers()
        return {'status': 'healthy'}, 200
    except Exception as e:
        return {'status': 'unhealthy', 'error': str(e)}, 503
```

## Additional resources

- [Configure a custom container for Azure App Service](/azure/app-service/configure-custom-container)
- [Health check monitoring in App Service](/azure/app-service/monitor-instances-health-check)
- [Mount Azure Storage as a local share](/azure/app-service/configure-connect-to-azure-storage)
