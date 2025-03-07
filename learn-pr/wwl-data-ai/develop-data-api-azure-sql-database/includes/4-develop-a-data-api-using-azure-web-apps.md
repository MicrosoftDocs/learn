Developing a data API using Azure Web App for Containers offers a robust and scalable solution for modern applications. By using the power of containers and Azure's managed services, developers can build, deploy, and manage APIs with ease, ensuring performance and reliability. This approach not only simplifies the development process but also enhances the portability and scalability of applications, making it an ideal choice for today's modern software landscape.

## Explore the benefits of using Web App for Containers

- **Portability**: Containers encapsulate the application and its dependencies, ensuring it runs consistently across different environments. This eliminates the *"it works on my machine"* problem, making deployment to various platforms seamless.

- **Scalability**: Azure Web App for Containers allows automatic scaling based on demand. This means your data API can handle increased load without manual intervention, ensuring high availability and performance.

- **Simplified management**: Azure manages the underlying infrastructure, including OS patching, load balancing, and capacity provisioning. This allows developers to focus on writing code rather than managing servers.

## Build a data API using Azure Web App for Containers

To build a data API using Azure Web App for Containers, you need to create a container app with the DAB image, assign necessary permissions, set up a Dockerfile, and update the app with the new image and credentials. Finally, retrieve the domain name and test the API.

Before you begin, ensure you have an Azure subscription, a resource group, and access to Azure Cloud Shell.

### Create a container app

You can create an Azure Container Apps with the following steps. 

1. Use `az containerapp env create` to create a new Azure container apps environment.

    ```azurecli
    az containerapp env create \ 
      --resource-group $RESOURCE_GROUP_NAME \
      --name $CONTAINER_ENV_NAME \
      --logs-destination none \
      --location $LOCATION
    ```

1. Use the `az containerapp create` command to create a new container app using the **mcr.microsoft.com/azure-databases/data-api-builder** DAB container image.

    ```azurecli
    az containerapp create \ 
      --resource-group $RESOURCE_GROUP_NAME \
      --environment $CONTAINER_ENV_NAME \
      --name $API_CONTAINER_NAME \
      --image "mcr.microsoft.com/azure-databases/data-api-builder" \
      --ingress "external" \
      --target-port "5000" \
      --system-assigned
    ```
You can then get the principal identifier of the managed identity using `az identity show`.

### Assign permissions

Assign the system-assigned managed identity permissions to read data from Azure SQL and read and write to Azure Container Registry.

```azurecli
az role assignment create \
  --assignee $CURRENT_USER_PRINCIPAL_ID \
  --role $ROLE_ID \
  --scope $RESOURCE_GROUP_ID
```

### Create an Azure Container Registry instance

To create a new Azure Container Registry instance, run the following command.

```dotnetcli
az acr create \
  --resource-group $RESOURCE_GROUP_NAME \
  --name <CONTAINER_REGISTRY_NAME> \
  --sku "Standard" \
  --location <LOCATION> \
  --admin-enabled false
```

### Build and deploy a container image

1. For the build stage, use the **mcr.microsoft.com/dotnet/sdk** container image.
1. Install [**DAB CLI**](/azure/data-api-builder/how-to-install-cli?azure-portal=true).

    ```azurecli
    RUN dotnet tool install Microsoft.DataApiBuilder
    ```

1. Create a configuration file for your Azure SQL Database connection to the source database by running `RUN dotnet tool run dab -- init`.
1. Create entities to map to the tables in the source database.
    ```azurecli
    RUN dotnet tool run dab -- add Address --source "SalesLT.Address" --permissions "anonymous:read"
    ```
1. Copy the configuration file to the final **mcr.microsoft.com/azure-databases/data-api-builder** container image.
1. Build the image as an Azure container registry task by running the `az acr build` to build your image.
1. Configure the container app to use the container registry.
    ```bash
    az containerapp registry set \
      --name <container-app-name> \
      --resource-group <resource-group-name> \
      --server <container-registry-login-server> \
      --username <container-registry-username> \
      --password <container-registry-password>
    ```
1. Create a secret with the Azure SQL connection string.
    ```bash
    az containerapp secret set \
      --name <container-app-name> \
      --resource-group <resource-group-name> \
      --secrets "SQLConnectionString=<your-sql-connection-string>"
    ```

1. Update the container app with the new custom container image and connection string.
    ```bash
    az containerapp update \
      --name <container-app-name> \
      --resource-group <resource-group-name> \
      --image <container-registry-login-server>/<image-name>:<tag> \
      --secrets "SQLConnectionString=<your-sql-connection-string>"
    ```

1. Retrieve the fully qualified domain name of the container app.
    ```bash
    az containerapp show \
      --name <container-app-name> \
      --resource-group <resource-group-name> \
      --query "properties.configuration.ingress.fqdn" \
      --output "tsv"
    ```

These steps update the Azure container app with the new custom container image and credentials, and retrieve the fully qualified domain name of the container app.

Finally, navigate to the URL and test the API to ensure everything is working correctly.

> [!NOTE]
> For detailed steps on how to deploy Data API builder to Azure Container Apps with Azure CLI, see [Tutorial: Deploy Data API builder to Azure Container Apps with Azure CLI](/azure/data-api-builder/tutorial-deploy-container-app-cli).
