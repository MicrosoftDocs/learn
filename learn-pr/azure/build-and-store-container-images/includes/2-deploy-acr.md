[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create an Azure container registry

1. Launch [Azure Cloud Shell](https://shell.azure.com/bash) and sign in to your Azure account using the `az login` command.

    ```azurecli-interactive
    az login
    ```

2. Create a resource group named *learn-acr-rg* to hold the resources for this module using the `az group create` command.

    ```azurecli-interactive
    az group create --name learn-acr-rg --location eastus
    ```

3. Define an environment variable, *ACR_NAME*, to hold your container registry name using the following command. The name must be unique within Azure and contain 5-50 alphanumeric characters. For more information, see [Naming conventions for Azure resources](/azure/architecture/best-practices/naming-conventions?azure-portal=true).

    ```azurecli-interactive
    ACR_NAME=your-unique-acr-name
    ```

4. Create an Azure container registry using the `az acr create` command.

    > [!NOTE]
    > In this example, we deploy a premium registry SKU. The premium SKU is required for geo-replication.

    ```azurecli-interactive
    az acr create --resource-group learn-acr-rg --name $ACR_NAME --sku Premium
    ```
