[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

TODO

In this exercise, you create a Bicep file that includes a module from the public registry. During the process, you'll:

> [!div class="checklist"]
> * Deploy a new private registry.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create an Azure container registry

Here, you create a new registry to store and share your Bicep modules. You'll use Azure Container Registry.

::: zone pivot="cli"

1. Decide on a unique name for your container registry. The name can't be used by any other Azure customers. Choose a name that is between 5 and 50 characters in length and contains letters and numbers. You'll use this in subsequent steps.

1. Create a container registry by running this command in the Visual Studio Code **Terminal**. Make sure to replace the name placeholder with the name you selected in the preceding step.

   ```azurecli
   az acr create \
     --name YOUR_CONTAINER_REGISTRY_NAME \
     --sku Basic \
     --location westus
   ```

::: zone-end

::: zone pivot="powershell"

1. Decide on a unique name for your container registry. The name can't be used by any other Azure customers. Choose a name that is between 5 and 50 characters in length and contains letters and numbers. You'll use this in subsequent steps.

1. Create a container registry by running this command in the Visual Studio Code **Terminal**. Make sure to replace the name placeholder with the name you selected in the preceding step.

   ```azurepowershell
   New-AzContainerRegistry `
     -Name YOUR_CONTAINER_REGISTRY_NAME `
     -Sku Basic `
     -Location westus
   ```

::: zone-end
