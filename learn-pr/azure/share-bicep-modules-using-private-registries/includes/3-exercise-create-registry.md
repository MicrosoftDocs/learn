[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

TODO

In this exercise, you create a private module registry for your toy company to use. During the process, you'll:

> [!div class="checklist"]
> * Deploy a new private registry.
> * Connect to your registry.

<!-- TODO bootstrapping info talks about deploying template -->

::: zone pivot="cli"

To deploy resources to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you've installed the [Azure CLI](/cli/azure/install-azure-cli), and remember to sign in with the same account that you used to activate the sandbox.

[!INCLUDE [Terminal instructions (CLI)](../../includes/azure-template-exercise-terminal-cli.md)]

[!INCLUDE [Install Bicep (CLI)](../../includes/azure-template-bicep-exercise-install-bicep-cli.md)]

[!INCLUDE [Sign into sandbox (CLI)](../../includes/azure-template-exercise-sandbox-sign-in-cli.md)]

::: zone-end

::: zone pivot="powershell"

To deploy resources to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure you've [installed Azure PowerShell](/powershell/azure/install-az-ps), and sign in to the same account that activated the sandbox.

[!INCLUDE [Terminal instructions (PowerShell)](../../includes/azure-template-exercise-terminal-powershell.md)]

[!INCLUDE [Install Bicep (PowerShell)](../../includes/azure-template-bicep-exercise-install-bicep-powershell.md)]

[!INCLUDE [Sign into sandbox (PowerShell)](../../includes/azure-template-exercise-sandbox-sign-in-powershell.md)]

::: zone-end

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

## Access the registry

TODO list modules, notice there are none

TODO talk about how it's using your CLI/PowerShell session identity
