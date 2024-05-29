You are on sprint 1 for the new deposits application. You want to test the process of creating a deployment stack with managed resources in a development subscription. In this exercise, you create a deployment stack scoped to a resource group that references a Bicep file. The file defines an Azure app service plan and an Azure app service.

During the process, you'll:

> [!div class="checklist"]
>
> - Create a Bicep file that defines your initial architecture
> - Create a deployment stack scoped to a resource group using your Bicep file.
> - Review the configuration of your deployment stack and managed resources

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create the Bicep file

Our first step is to create a Bicep file that defines our resources to use with the deployment stack.

1. Open Visual Studio Code.

1. Create a new file called _main.bicep_.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you saved the file. For example, you might want to create a _templates_ folder in which to save the file.

1. Add the following Bicep code into the file. You deploy the template soon. It's a good idea to type the code yourself instead of copying and pasting, so you can see how the tooling helps you to write your Bicep files.

    :::code language="bicep" source="code/1-template.bicep" range="1-4, 18-42":::

    Notice that you're using expressions that include string interpolation and the `uniqueString()` function to define default parameter values. Someone deploying this template can override the default parameter values by specifying the values at deployment time, but they can't override the variable values.

    Also notice that you're using a variable for the Azure App Service plan name, but you're using parameters for the other names. Storage accounts and App Service apps need globally unique names, but App Service plan names need to be unique only within their resource group. This difference means it's not a concern to use the same App Service plan name across different deployments, as long as the deployments are all going into different resource groups.

1. Save the changes to the file.

## Create the deployment stack and deploy your resources to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first deployment stack exercise - CLI](../../includes/azure-deployment-stacks-exercise-nosandbox-deploy-cli.md)]

### Create a resource group

We need to create a resource group for our deployment stack and managed resources. To create a resource group, run the following command from the terminal in Visual Studio Code.

```azurecli
az group create \
    --name rg-depositsApplication \
    --location eastus
```

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first deployment stack exercise - PowerShell](../../includes/azure-deployment-stacks-exercise-nosandbox-deploy-powershell.md)]

### Create a resource group

We need to create a resource group for our deployment stack and managed resources. To create a resource group, run the following command from the terminal in Visual Studio Code.

```azurepowershell
New-AzResourceGroup `
    -Name rg-depositsApplication `
    -Location eastus
```

::: zone-end

### Create the deployment stack

Next, we need to create our deployment stack scoped to our recently created resource group. To create the deployment stack, run the following command from the terminal in Visual Studio Code.

::: zone pivot="cli"

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --action-on-unmanage detachAll \
    --deny-settings-mode none
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
New-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep `
    -ActionOnUnmanage DetachAll `
    -DenySettingsMode None
```

::: zone-end

## Verify the creation of the deployment stack and the managed resources

::: zone pivot="cli"

When you create a deployment stack and its managed resources, you can view its configuration using the command-line or the Azure portal. In this exercise, we use Azure CLI. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

```azurecli
az stack group show \
    --resource-group rg-depositsApplication \
    --name stack-deposits
```

The results include the properties of the deployment stack and the status of the managed resources. The json output should appear familiar to the following image:

:::code language="json" source="code/2-json.json" range="1-27, 40-43, 56-81":::

Take notice of the resources section of the output. For each resource, it shows its status as "managed," its resource group, its resource id, and its deny settings.

::: zone-end

::: zone pivot="powershell"

When you create a deployment stack and its managed resources, you can view its configuration using the command-line or the Azure portal. In this exercise, we use Azure PowerShell. To view the configuration of the deployment stack, run the following command from the terminal in Visual Studio Code.

```azurepowershell
Get-AzResourceGroupDeploymentStack `
    -ResourceGroupName rg-depositsApplication `
    -Name stack-deposits
```

The results include the properties of the deployment stack and the status of the managed resources. The PowerShell output should appear familiar to the following image:

:::code language="powershell" source="code/3-powershell.ps1" range="1-12":::

Take notice of the resources section of the output. It defines the resources managed by the deployment stack. You see the full resource ID of each resource.

::: zone-end
