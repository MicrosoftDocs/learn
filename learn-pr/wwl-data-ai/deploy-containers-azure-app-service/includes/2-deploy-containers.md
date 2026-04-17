Azure App Service runs custom Linux containers as web applications. You provide a container image from a registry, and App Service handles provisioning, load balancing, and scaling. This unit covers how to select image sources, configure registry authentication, and deploy containers using the Azure portal and CLI.

## Container image sources

When you create a Web App for Containers, you select an image source that tells App Service where to pull your container image. The Azure portal presents two options:

- **Azure Container Registry (ACR)** is the recommended source for production workloads. ACR integrates with Microsoft Entra ID for authentication and supports managed identity, geo-replication, image scanning, and private network access. When you select ACR, you choose the specific registry, authentication method, image name, and tag.
- **Other container registries** includes any registry accessible via HTTPS that supports the Docker Registry HTTP API V2 specification. This option covers Docker Hub, GitHub Container Registry, and self-hosted registries. For private images, you provide the server URL, username, and password. Public images require only the image name.

## Deploy using the Azure portal

The Azure portal provides a guided experience for creating a Web App for Containers. This approach works well when you want to configure all settings visually and verify your choices before deployment.

### Create the web app

1. In the Azure portal, select **Create a resource** and search for **Web App**
1. Select **Create** and choose **Web App**
1. On the **Basics** tab, configure subscription, resource group, app name, and region
1. For **Publish**, select **Container**
1. For **Operating System**, select **Linux**
1. Select an App Service plan or create a new one
1. Select the **Container** tab to configure the image source

### Configure the container image

On the **Container** tab, you specify where App Service pulls your container image.

**For Azure Container Registry:**

1. In **Image Source**, select **Azure Container Registry**
1. Select your **Registry** from the dropdown (registries in the same subscription appear automatically)
1. Choose an **Authentication** method:
   - **Managed Identity**: Select an existing user-assigned managed identity, or use the system-assigned identity. The identity must have the AcrPull role on the registry.
   - **Admin credentials**: Use the registry's admin username and password. You must enable the admin user on the ACR.
1. Select the **Image** and **Tag** to deploy

**For other registries:**

1. In **Image Source**, select **Other container registries**
1. For private images, provide the **Server URL** (for example, `https://index.docker.io/v1/` for Docker Hub)
1. Enter **Username** and **Password** for private registries
1. Enter the **Full Image Name and Tag** (for example, `nginx:latest` or `myuser/myapp:v1`)

## ACR authentication options

Azure Container Registry supports two authentication methods when deploying to App Service: managed identity, or admin credentials. Your choice depends on security requirements and whether you manage your own infrastructure permissions.

### Managed identity authentication

Managed identity is the recommended approach for production. App Service authenticates to ACR using an Azure identity rather than stored credentials. This approach eliminates credential rotation concerns and provides better security auditing.

There are two kinds of managed identity:

- **System-assigned managed identity** is tied to the web app lifecycle. Azure creates the identity when you enable it on the web app and deletes it when you delete the app. This option is simpler when the web app is the only resource that needs the identity.
- **User-assigned managed identity** exists independently of the web app. You create the identity as a separate Azure resource and assign it to one or more web apps. This option works well when multiple apps need the same registry access or when you want to configure permissions before creating the web app.

### Admin credentials authentication

Admin credentials use a username and password stored in the ACR. This approach is simpler for development scenarios because it doesn't require role assignments. However, it stores credentials in your App Service configuration and requires manual rotation if compromised.

To use admin credentials, enable the admin user on your container registry:

```azurecli
az acr update --name myregistry --admin-enabled true
```

## Deploy to App Service using CLI

You can deploy a container to App Service from the command line when you want a repeatable workflow that you can paste into a script or CI pipeline. This section assumes your container image already exists in Azure Container Registry and that App Service already has permission to pull it. In practice, that permission is often provided through managed identity and an AcrPull role assignment applied by a platform team.

### Create the web app

The `az webapp create` command creates the web app and sets the container image in one step. This example assumes the resource group and App Service plan already exist. Use your ACR login server and image name, including a tag, so the deployment is deterministic.

```azurecli
az webapp create \
    --resource-group myResourceGroup \
    --plan myAppServicePlan \
    --name myDocumentProcessor \
    --container-image-name myregistry.azurecr.io/docprocessor:v1
```

## Deploy from other container registries

For registries other than ACR, provide the server URL and credentials when creating the web app. This approach works for Docker Hub, GitHub Container Registry, and self-hosted registries.

**Public images from Docker Hub:**

```azurecli
az webapp create \
    --resource-group myResourceGroup \
    --plan myAppServicePlan \
    --name myWebApp \
    --container-image-name nginx \
    --docker-registry-server-url https://index.docker.io/v1/
```

**Private images:**

```azurecli
az webapp create \
    --resource-group myResourceGroup \
    --plan myAppServicePlan \
    --name myWebApp \
    --container-image-name myusername/myapp:latest \
    --docker-registry-server-url https://index.docker.io/v1/ \
    --docker-registry-server-user myusername \
    --docker-registry-server-password <password>
```

For GitHub Container Registry, use `https://ghcr.io` as the server URL.

## Deploy using VS Code

VS Code with the Docker and Azure App Service extensions provides an interactive deployment experience. This approach works well during development when you want visual feedback and quick iteration.

1. Build your image locally using the Docker extension
1. Push the image to your container registry
1. In the Docker extension's REGISTRIES view, right-click the image tag and select **Deploy Image to Azure App Service**
1. Follow the prompts to select subscription, app name, resource group, and App Service plan

The extension can help you create the web app and deploy the selected image. For production deployments, validate registry authentication and role assignments separately so the app can reliably pull the image.

## Update the container image

When you deploy a new version of your application to ACR, update the container image reference. App Service restarts the web app, which stops and starts the container on each instance so the app runs the new image.

```azurecli
az webapp config container set \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --container-image-name myregistry.azurecr.io/docprocessor:v2
```

## Enable continuous deployment

For automated deployments, configure App Service to pull new images automatically when you push to the registry. This approach works well with CI/CD pipelines.

Enable continuous deployment:

```azurecli
az webapp deployment container config \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --enable-cd true
```

This command returns a webhook URL. Configure your container registry to call this webhook when new images are pushed. For ACR, create a webhook in the registry settings that triggers on push events.

## Image pull behavior

Understanding when App Service pulls images helps you plan for deployment scenarios and troubleshoot issues.

- **Initial deployment:** App Service pulls all image layers when you first deploy the container or change the image reference.

- **App restart:** On restart, App Service checks for changes and pulls only modified layers. If the image is unchanged, the cached layers are used.

- **Scale out:** When App Service adds new instances, each instance pulls the image. New instances might need to pull the full image if layers aren't cached on the underlying infrastructure.

- **Pricing tier changes:** Moving to a different pricing tier might allocate new infrastructure, which pulls the image fresh and can affect startup time.

## Verify the deployment

After deploying a container, verify that the application starts successfully:

```azurecli
az webapp show \
    --resource-group myResourceGroup \
    --name myDocumentProcessor \
    --query defaultHostName \
    --output tsv
```

Open the URL in a browser or use curl to verify the application responds. If the container fails to start, the diagnostic tools covered in Unit 5 help identify the issue.

## Additional resources

- [Deploy and run a containerized web app with Azure App Service](/azure/app-service/quickstart-custom-container)
- [Use a custom container in Azure App Service](/azure/app-service/tutorial-custom-container)
- [Configure a custom container for Azure App Service](/azure/app-service/configure-custom-container)
- [Azure Container Registry documentation](/azure/container-registry/)
