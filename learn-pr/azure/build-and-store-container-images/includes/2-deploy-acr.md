In this unit, you'll create an Azure container registry using the Azure CLI.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create an Azure container registry

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true) with your Azure subscription.

1. Open the Azure Cloud Shell from the Azure portal selecting the Cloud Shell icon.

    :::image type="icon" source="../media/2-portal-cloudshell-access.png":::

1. Create a new resource group with the name **learn-deploy-acr-rg** so that it will be easier to clean up these resources when you're finished with the module. If you choose a different resource group name, remember it for the rest of the exercises in this module. You also need to choose a region in which you want to create the resource group, for example *centralus*.

    Before running the following command, replace the `<choose-a-location>` with the region of your choice.

    ```azurecli
    az group create --name learn-deploy-acr-rg --location <choose-a-location>
    ```

Next, we'll create an Azure container registry with the `az acr create` command. The container registry name must be unique within Azure and contain between 5 and 50 alphanumeric characters.

In this example, a premium registry SKU is deployed. The premium SKU is required for geo-replication.

To begin, we'll define an environment variable in the Cloud Shell called **ACR_NAME**  to hold the name we want to give our new container registry.

1. Run the following command to define a variable called ACR_NAME.

    > [!IMPORTANT]
    > Before running the command, replace `<registry-name>` with the unique name you want to give your new container registry. The registry name must be unique within Azure, and contain 5-50 **alphanumeric** characters. For more information on naming, see [Naming conventions for Azure resources](https://docs.microsoft.com/azure/architecture/best-practices/naming-conventions?azure-portal=true).

    ```azurecli
    ACR_NAME=<registry-name>
    ```

1. Enter the following command into the Cloud Shell editor to create our new container registry.

    ```azurecli
    az acr create --resource-group learn-deploy-acr-rg --name $ACR_NAME --sku Premium
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    The following snippet is an example response from the `az acr create` command. In this example, the registry name was *myACR*. The loginServer value below is the registry name in lowercase, by default.  

    Make sure to note the value returned for the `location` value as we'll need in a later exercise.

    ```output
    {
      "adminUserEnabled": false,
      "creationDate": "2018-08-15T19:19:07.042178+00:00",
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.ContainerRegistry/registries/myACR0007",
      "location": "eastus",
      "loginServer": "myacr.azurecr.io",
      "name": "myACR",
      "provisioningState": "Succeeded",
      "resourceGroup": "myResourceGroup",
      "sku": {
        "name": "Premium",
        "tier": "Premium"
      },
      "status": null,
      "storageAccount": null,
      "tags": {},
      "type": "Microsoft.ContainerRegistry/registries"
    }
    ```

> [!IMPORTANT]
> Commands in the rest of this module will use the **ACR_NAME** variable value.

In this unit, you created an Azure Container Registry using the Azure CLI. We'll use that new container registry in the next unit when we build container images.
