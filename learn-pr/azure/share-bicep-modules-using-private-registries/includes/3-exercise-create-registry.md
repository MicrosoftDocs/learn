[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

Before you can publish the Bicep modules for the CDN and website, you need to create a registry for your organization. Then publish the shared modules to the registry. Other teams can then create deployments that include the shared modules.

In this exercise, you will:

> [!div class="checklist"]
>
> - Deploy a new private registry for your toy company to use.
> - Connect to your registry to verify that it was created successfully.

::: zone pivot="cli"

To deploy resources to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you've installed the [Azure CLI](/cli/azure/install-azure-cli), and sign in with the same account that you used to activate the sandbox.

[!INCLUDE [Terminal instructions (CLI)](../../includes/azure-template-exercise-terminal-cli.md)]

[!INCLUDE [Install Bicep (CLI)](../../includes/azure-template-bicep-exercise-install-bicep-cli.md)]

[!INCLUDE [Sign into sandbox (CLI)](../../includes/azure-template-exercise-sandbox-sign-in-cli.md)]

::: zone-end

::: zone pivot="powershell"

To deploy resources to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you've [installed Azure PowerShell](/powershell/azure/install-az-ps), and sign in to the same account that activated the sandbox.

[!INCLUDE [Terminal instructions (PowerShell)](../../includes/azure-template-exercise-terminal-powershell.md)]

[!INCLUDE [Install Bicep (PowerShell)](../../includes/azure-template-bicep-exercise-install-bicep-powershell.md)]

[!INCLUDE [Sign into sandbox (PowerShell)](../../includes/azure-template-exercise-sandbox-sign-in-powershell.md)]

::: zone-end

## Create a container registry

Here, you create a new registry to store and share your Bicep modules. This example uses Azure Container Registry.

::: zone pivot="cli"

1. Select a unique name for your container registry. The name must be globally unique across Azure. Choose one that's 5 to 50 characters in length and that contains letters and numbers. You use the name in subsequent steps.

1. Create a container registry by running this command in the Visual Studio Code terminal. Replace the `YOUR_CONTAINER_REGISTRY_NAME` placeholder with the name that you selected in the preceding step.

   ```azurecli
   az acr create \
     --name YOUR_CONTAINER_REGISTRY_NAME \
     --sku Basic \
     --location westus
   ```

> [!TIP]
> You can also create a container registry by using Bicep. In this example, we use the Azure CLI for simplicity.

::: zone-end

::: zone pivot="powershell"

1. Select a unique name for your container registry. The name must be globally unique across Azure. Choose one that's 5 to 50 characters in length and that contains letters and numbers. You use the name in subsequent steps.

1. Create a container registry by running this command in the Visual Studio Code terminal. Replace the `YOUR_CONTAINER_REGISTRY_NAME` placeholder with the name that you selected in the preceding step.

   ```azurepowershell
   New-AzContainerRegistry `
     -Name YOUR_CONTAINER_REGISTRY_NAME `
     -Sku Basic `
     -Location westus
   ```

> [!TIP]
> You can also create a container registry by using Bicep. In this example, we use the Azure PowerShell cmdlet for simplicity.

::: zone-end

## List the modules in your registry

Now that you've created your registry, you can connect to it to verify that it's working.

::: zone pivot="cli"

1. List the modules in the registry by running this command. Replace the `YOUR_CONTAINER_REGISTRY_NAME` placeholder with the name that you selected earlier.

   ```azurecli
   az acr repository list \
     --name YOUR_CONTAINER_REGISTRY_NAME
   ```

   Notice that you don't specify any credentials to connect to the container registry. The Azure CLI uses the same credentials that you used to sign in to the Azure CLI. You have access to the container registry because you created it.

1. The Azure CLI command returns a list that contains no results:

   ```output
   []
   ```

   You see no results because you haven't published any modules yet. You'll learn more about publishing modules in the next unit.

::: zone-end

::: zone pivot="powershell"

1. List the modules in the registry by running this command. Replace the `YOUR_CONTAINER_REGISTRY_NAME` placeholder with the name that you selected earlier.

   ```azurepowershell
   Get-AzContainerRegistryRepository `
     -RegistryName YOUR_CONTAINER_REGISTRY_NAME
   ```

   Notice that you don't specify any credentials to connect to the container registry. Azure PowerShell uses the same credentials that you used to sign in to the Azure PowerShell cmdlets. You have access to the container registry because you created it.

1. The Azure PowerShell cmdlet shows no output.

   There are no results because you haven't published any modules yet. You learn more about publishing modules in the next unit.

::: zone-end
