::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=ede9df5a-5823-4f0c-8095-f384db375e11]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Sidecar-enabled apps define the main and auxiliary containers as App Service site container resources. Each definition specifies an image and role, with optional port metadata, startup behavior, and registry authentication. A consistent configuration model makes deployments repeatable and prevents classic custom-container settings from conflicting with sidecar settings.

> [!NOTE]
> The command and JSON examples are patterns to adapt to your naming, image, identity, and security requirements. The examples use the current `az webapp sitecontainers` command group and the `Microsoft.Web/sites/sitecontainers` resource schema.

## Create a sidecar-enabled app

You can enable sidecar support when you create a Linux web app. The `--sitecontainers-app` option configures the app to use site container resources instead of the classic `DOCKER|<image>` value. You then create the main and sidecar definitions separately.

The following command creates an app in an existing Linux App Service plan. You can replace the placeholders with the names from your environment.

```azurecli
az webapp create \
  --name <app-name> \
  --resource-group <resource-group> \
  --plan <app-service-plan> \
  --sitecontainers-app
```

If you have an eligible Linux custom-container app, you can convert its configuration. You should inventory its image, port, registry, startup, and environment settings before conversion because classic `DOCKER_REGISTRY_SERVER_*` and `WEBSITES_PORT` settings don't configure site containers.

The following command enables the site container model for an existing app:

```azurecli
az webapp sitecontainers convert \
  --mode sitecontainers \
  --name <app-name> \
  --resource-group <resource-group>
```

Conversion changes the app configuration model. You should validate the resulting main container definition in a nonproduction environment before routing production traffic.

## Define container roles and ports

Every container needs a unique name and a complete image reference. A container that accepts network connections should also declare its listener as target-port metadata, and each listening process must use a unique port. Exactly one definition needs `isMain: true`. The main process must listen on port `80` or `8080` because App Service supports only those ports for external HTTP traffic.

The following command creates the main API definition. The `--is-main` option marks the container as the external entry point.

```azurecli
az webapp sitecontainers create \
  --name <app-name> \
  --resource-group <resource-group> \
  --container-name main-api \
  --image <registry-name>.azurecr.io/support-api:<tag> \
  --target-port 8080 \
  --is-main
```

The next command creates the model server as a sidecar. Omitting `--is-main` leaves the property false.

```azurecli
az webapp sitecontainers create \
  --name <app-name> \
  --resource-group <resource-group> \
  --container-name model-server \
  --image <registry-name>.azurecr.io/model-server:<tag> \
  --target-port 11434
```

Each networked process must listen on its declared port. Containers share a network namespace, so two processes can't bind the same port. Internal sidecar communication can use any other available unique port.

The target port is metadata and doesn't control App Service routing. The image still needs to start a process that listens on the declared port. Changing only the target-port metadata doesn't reconfigure the process inside the image, and a sidecar that doesn't accept network connections can omit the property.

## Separate shared and container-specific configuration

App settings are available to all containers in the app. Container-specific environment variables belong to one site container definition. You can use these scopes to avoid duplicating shared values while keeping implementation details with the process that owns them.

For the conversational AI application, the main API receives a variable named `MODEL_ENDPOINT`. The value points to `http://localhost:11434`, which remains the same for every app instance. The model server receives a container-specific variable that selects the model or controls its startup behavior.

In a site container resource, each `environmentVariables[].value` identifies an App Setting by name rather than containing a literal value. You can create the source App Settings before you apply the container specification:

```azurecli
az webapp config appsettings set \
  --name <app-name> \
  --resource-group <resource-group> \
  --settings \
    MODEL_ENDPOINT_VALUE=http://localhost:11434 \
    MODEL_NAME_VALUE=support-model
```

The following specification shows both containers in one JSON array. The resource maps the source App Settings to container-specific environment variable names. A specification file is useful when you want one command to create or update the complete set.

```json
[
  {
    "name": "main-api",
    "properties": {
      "image": "<registry-name>.azurecr.io/support-api:<tag>",
      "targetPort": "8080",
      "isMain": true,
      "environmentVariables": [
        {
          "name": "MODEL_ENDPOINT",
          "value": "MODEL_ENDPOINT_VALUE"
        }
      ]
    }
  },
  {
    "name": "model-server",
    "properties": {
      "image": "<registry-name>.azurecr.io/model-server:<tag>",
      "targetPort": "11434",
      "isMain": false,
      "environmentVariables": [
        {
          "name": "MODEL_NAME",
          "value": "MODEL_NAME_VALUE"
        }
      ]
    }
  }
]
```

You can apply the specification with the following command. The command ignores other site container input arguments when you provide `--sitecontainers-spec-file`.

```azurecli
az webapp sitecontainers create \
  --name <app-name> \
  --resource-group <resource-group> \
  --sitecontainers-spec-file ./sitecontainers-spec.json
```

You shouldn't place credentials directly in the specification file. You can use App Service settings, managed identities, or secret references that follow your organization's security requirements.

## Authenticate private image pulls

Azure Container Registry can store the main and sidecar images. Managed identity lets App Service authenticate to the registry without a registry password in app configuration. The identity needs permission to pull image content.

You can use either a system-assigned or user-assigned managed identity. A user-assigned identity is useful when several apps share a controlled image-pull identity or when the identity needs to exist independently of the web app. The container definition uses `authType: UserAssigned` and identifies the identity by client ID.

The registry must also accept Azure Resource Manager audience tokens for managed-identity image pulls. You can check the setting with `az acr config authentication-as-arm show`. An `UNAUTHORIZED` error that includes `token validation failed` can indicate that the registry doesn't accept these tokens.

The pull role depends on the registry's **Role assignment permissions mode**. You can grant `AcrPull` when the registry uses **RBAC Registry Permissions**. You can grant `Container Registry Repository Reader`, optionally with a repository condition, when the registry uses **RBAC Registry + ABAC Repository Permissions**. The following fragment shows the relevant site container properties. The identity must already be assigned to the web app and granted the applicable pull role.

```json
{
  "name": "model-server",
  "properties": {
    "image": "<registry-name>.azurecr.io/model-server:<tag>",
    "targetPort": "11434",
    "isMain": false,
    "authType": "UserAssigned",
    "userManagedIdentityClientId": "<identity-client-id>"
  }
}
```

Role assignment can take time to propagate. An image pull can temporarily fail immediately after you grant access, so allow for propagation before treating the container configuration as incorrect.

You should use immutable image tags or digests for controlled releases. A mutable tag such as `latest` can point to different image content across restarts, which makes rollback and diagnosis harder.

## Verify the deployed definitions

Configuration validation should happen before you test application behavior. You can list all site containers, inspect a single definition, and confirm that the expected image, role, port, and authentication properties reached App Service. This step separates deployment mistakes from runtime failures.

The following command lists all container definitions for the app:

```azurecli
az webapp sitecontainers list \
  --name <app-name> \
  --resource-group <resource-group> \
  --output table
```

You can inspect the model-server definition in detail:

```azurecli
az webapp sitecontainers show \
  --name <app-name> \
  --resource-group <resource-group> \
  --container-name model-server
```

You can confirm that one definition is the main container and that every port is unique. You should also compare image tags with the release you intended to deploy and verify the authentication type before investigating application logs.

::: zone-end

## Additional resources

The following resources provide the current command and resource details for site container deployment. You can use the references when you translate the examples into an automated deployment.

- [Configure sidecars in Azure App Service](/azure/app-service/configure-sidecar)
- [Azure CLI commands for App Service site containers](/cli/azure/webapp/sitecontainers)
- [App Service site container resource reference](/azure/templates/microsoft.web/sites/sitecontainers)
