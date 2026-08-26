::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=bf79b410-f9b1-40c6-a290-ec5863c822f6]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

A sidecar failure often appears as a main-app error because the containers run as one App Service application. A useful investigation separates deployment, image pull, process startup, resource pressure, and local communication into distinct boundaries. Container-specific logs and App Service metrics help you identify the failing boundary before you change capacity or configuration.

> [!NOTE]
> The commands in this unit use placeholders for resource and container names. Diagnostic output can contain image names, environment details, or application data, so handle exported logs according to your organization's data-protection requirements.

## Establish a symptom-first workflow

You can start with the externally visible symptom and trace the request toward the sidecar. You should avoid changing several settings at once because multiple changes make the original cause harder to prove. You can record the failure time, app instance, request correlation identifier, and container name whenever those values are available.

You can use the following sequence:

1. Confirm that the expected container definitions reached App Service.
1. Identify whether the container image was pulled successfully.
1. Confirm that the sidecar process starts and remains active.
1. Review CPU and memory metrics for shared resource pressure.
1. Test the `localhost` connection from the main app.
1. Validate the request and response at the sidecar application layer.

The `list` command shows every site container associated with the app. Use the output to catch a missing sidecar, an unexpected image tag, or multiple main roles.

```azurecli
az webapp sitecontainers list \
  --name <app-name> \
  --resource-group <resource-group> \
  --output table
```

The `show` command returns one complete definition. You can compare its image, target port, identity settings, environment variables, startup command, and explicit mount configuration with the release configuration.

```azurecli
az webapp sitecontainers show \
  --name <app-name> \
  --resource-group <resource-group> \
  --container-name model-server
```

You can then check whether App Service reports the container as running:

```azurecli
az webapp sitecontainers status \
  --name <app-name> \
  --resource-group <resource-group> \
  --container-name model-server
```

Configuration inspection is important because a runtime log can't show a setting that never reached the resource. The status command adds platform state before you inspect the container's process output.

## Diagnose image pull and startup failures

An image pull failure occurs before the application process starts. The likely causes are an incorrect image reference, missing registry authorization, or a registry network restriction. Startup failures happen after App Service retrieves the image and attempts to launch its configured command.

For an Azure Container Registry image, verify:

- The registry sign-in server, repository, and tag match an existing image.
- The managed identity is assigned to the web app.
- The identity has `AcrPull` when the registry uses **RBAC Registry Permissions**, or `Container Registry Repository Reader` when the registry uses **RBAC Registry + ABAC Repository Permissions**.
- The container definition uses the intended authentication type and identity client ID.
- The registry accepts Azure Resource Manager audience tokens for managed-identity authentication.
- Registry firewall rules permit the web app's outbound addresses, or the registry private endpoint, DNS, and App Service virtual network integration provide a private pull path.
- The App Service **Pull image over VNet** option is enabled when the image must be pulled through virtual network integration.

Role assignments can take time to propagate. If you just granted the applicable pull role, allow for propagation and retry before replacing correct identity settings with stored registry credentials.

You can retrieve logs for one site container with the following command. Container-specific output prevents unrelated main-app messages from obscuring an image or startup error.

```azurecli
az webapp sitecontainers log \
  --name <app-name> \
  --resource-group <resource-group> \
  --container-name model-server
```

If the image pulls but the sidecar doesn't remain available, check:

- The image entry point and any configured startup command.
- Whether the main process stays in the foreground instead of exiting after it starts a child process.
- Required environment variables and file paths.
- The process architecture and base image compatibility.
- The configured target port and the port on which the process actually listens.
- Model file availability and permissions during initialization.

A process exit code or application stack trace usually points to an image or configuration problem. Repeated starts without an application error can also indicate memory pressure during model loading.

## Diagnose resource pressure

The main container and every sidecar share App Service plan resources on an app instance. High model memory use can cause restarts or slow responses in either process. Scaling the API horizontally also creates another model-server sidecar on every new instance, so initialization increases total plan demand.

Review App Service CPU, memory, response time, HTTP queue, and restart-related signals around the failure time. Compare the metrics with sidecar logs that show model loading or request bursts. A single metric rarely proves the cause, but aligned timestamps can distinguish capacity pressure from a bad port or invalid request.

You can use representative load to measure:

- Memory before and after the sidecar loads the model.
- Peak memory while the main API and model server handle concurrent requests.
- CPU and response time at the target concurrency.
- Startup duration during deployment and scale-out.
- Failure behavior when requests exceed the model server's concurrency limit.

If measured demand exceeds the plan's safe capacity, you can reduce concurrency, choose a smaller model, scale the App Service plan, or host model inference separately. Don't use scaling to hide a process crash, missing setting, or incorrect image tag.

> [!NOTE]
> App Service plan capacity, features, and pricing change regularly. For current plan details, see [App Service hosting plans](/azure/app-service/overview-hosting-plans) and [App Service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits).

## Diagnose local connectivity

A connection refusal means that no process accepted the connection on the requested local port at that moment. A timeout can indicate slow startup, resource pressure, blocked application work, or a request that exceeds the model's processing budget. An HTTP error response means the network connection succeeded and the investigation should move to request format, authorization, or model-server behavior.

You can check connectivity in the following order:

1. Confirm that application code uses `localhost`, not the sidecar container name.
1. Compare the client port with the sidecar target port.
1. Confirm that no other container uses the same port.
1. Inspect sidecar logs for the address and port on which the process listens.
1. Send a lightweight health request from main-app code.
1. Send a representative inference request with an explicit timeout.

The following Python fragment distinguishes the main local failure categories. In a production app, map these exceptions to your API's established error and telemetry patterns.

```python
import httpx

async def check_model_health() -> str:
    try:
        async with httpx.AsyncClient(timeout=2.0) as client:
            response = await client.get("http://localhost:11434/health")
            response.raise_for_status()
            return "ready"
    except httpx.ConnectError:
        return "connect-error"
    except httpx.TimeoutException:
        return "timeout"
    except httpx.HTTPStatusError as error:
        return f"http-{error.response.status_code}"
```

`ConnectError` means HTTPX couldn't establish a connection. The cause can be a refused connection, name-resolution problem, or another network failure. Don't return detailed internal errors from a public health endpoint. Log the diagnostic category with a correlation identifier and return a limited readiness result to external callers.

## Diagnose shared-file failures

File problems usually come from different application paths, permissions, explicit mount configuration, or an incorrect durability assumption. Both applications should resolve the shared file to the same path under `/home`. This module doesn't add `volumeMounts` entries because the default shared volume already meets the file-exchange requirement.

You can use the following checks:

- Confirm that `WEBSITES_ENABLE_APP_SERVICE_STORAGE` isn't set to `false` when the applications depend on the shared `/home` volume.
- Confirm that both applications resolve the shared file to the same path, such as `/home/models/manifest.json`.
- If explicit mounts are configured, remove `volumeMounts` from both site container definitions and restore the default shared `/home` path before investigating other causes.
- Verify the user and file permissions inside each image.
- Write a small diagnostic file from the designated writer and read it from the consumer.
- Restart the app to confirm that required files can be recreated.
- Check whether scale-out incorrectly assumes that local files appear on every instance.

You should move durable artifacts to Azure Storage. The shared `/home` volume can support file exchange, but it shouldn't serve as the application's durable system of record.

## Use platform diagnostics

Container logs provide process-level evidence, while Azure Monitor and the App Service **Diagnose and solve problems** experience provide platform context. Use both sources when the failure spans deployment, restarts, resource limits, or intermittent availability. Log Analytics can help correlate events across a longer time window when you configure the required diagnostics.

A complete incident record should capture:

- The app, slot, instance, and container name.
- The deployed image tag or digest.
- The first and last failure timestamps.
- Relevant container log messages and exit information.
- CPU and memory behavior around the event.
- The client error category and correlation identifier.
- The configuration change or release that preceded the failure.

After you correct the suspected cause, repeat the original failing request under representative load. Verification proves that the fix addresses the boundary that failed rather than only removing one visible symptom.

::: zone-end

## Additional resources

The following resources provide current diagnostic commands and App Service monitoring guidance. You can use them to expand the symptom-first workflow for your application's telemetry standards.

- [Azure CLI commands for App Service site containers](/cli/azure/webapp/sitecontainers)
- [Access diagnostic logs for custom containers](/azure/app-service/configure-custom-container#access-diagnostic-logs)
- [Monitor App Service](/azure/app-service/web-sites-monitor)
