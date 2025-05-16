[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create an Azure container registry

1. Launch [Azure Cloud Shell](https://shell.azure.com/bash) and sign in to your Azure account using the `az login` command.

    ```azurecli-interactive
    az login
    ```

1. At the top of the Cloud Shell window, select **Settings**, then select **Go to Classic version.**

1. Create a resource group named *learn-acr-rg* to hold the resources for this module using the `az group create` command.

    ```azurecli-interactive
    az group create --name learn-acr-rg --location eastus
    ```

1. Define an environment variable, *ACR_NAME*, to hold your container registry name using the following command. The name must be unique within Azure and contain 5-50 alphanumeric characters. For more information, see [Develop your naming and tagging strategy for Azure resources](/azure/architecture/best-practices/naming-conventions?azure-portal=true).

    ```azurecli-interactive
    ACR_NAME=your-unique-acr-name
    ```

1. Create an Azure container registry using the `az acr create` command.

    > [!NOTE]
    > In this example, we deploy a premium registry SKU. The premium SKU is required for geo-replication.

    ```azurecli-interactive
    az acr create --resource-group learn-acr-rg --name $ACR_NAME --sku Premium
    ```
