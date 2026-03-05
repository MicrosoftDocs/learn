[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create an Azure container registry

1. Launch [Azure Cloud Shell](https://shell.azure.com/bash) and sign in to your Azure account. If you're using Azure CLI from your computer, use the `az login` command and sign in to your Azure account.

    ```azurecli
    az login
    ```

1. At the top of the Cloud Shell window, select **Settings**, then select **Go to Classic version**. The classic version is needed later in this module to use Docker commands.

1. Verify that the `Microsoft.ContainerRegistry` and `Microsoft.ContainerInstance` resource providers are registered in your subscription using the `az provider show` command.

   ```azurecli
   az provider show --namespace Microsoft.ContainerRegistry --output table
   ```

   ```output
   Namespace                    RegistrationPolicy    RegistrationState
   ---------------------------  --------------------  -------------------
   Microsoft.ContainerRegistry  RegistrationRequired  NotRegistered
   ```

   Run the following command to register the resource provider if the `RegistrationState` is `NotRegistered`.

   ```azurecli
   az provider register --namespace Microsoft.ContainerRegistry
   ```

1. Create a resource group named _learn-acr-rg_ to hold the resources for this module using the `az group create` command.

    ```azurecli
    az group create --name learn-acr-rg --location eastus
    ```

1. Define an environment variable, _ACR_NAME_, to hold your container registry name using the following command. Replace `<your-unique-acr-name>` with your container registry name.

   The container registry name must be unique within Azure and contain 5-50 alphanumeric characters. For more information, see [Define your naming convention](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming).

    ```azurecli
    ACR_NAME=<your-unique-acr-name>
    ```

1. Create an Azure container registry using the `az acr create` command.

    ```azurecli
    az acr create --resource-group learn-acr-rg --name $ACR_NAME --sku Premium
    ```

   In this example, we deploy a premium registry SKU required for geo-replication.
