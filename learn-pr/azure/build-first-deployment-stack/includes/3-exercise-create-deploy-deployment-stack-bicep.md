You are at sprint 1 for the new deposits application. You want to test the process of creating a deployment stack with managed resources in a development subscription. In this exercise, you'll create a deployment stack scoped to a resource group that references a bicep file. The file will define an Azure app service plan and an Azure app service.

During the process, you'll:

> [!div class="checklist"]
>
> - Create a bicep file that defines your initial architecture
> - Create a deployment stack scoped to a resource group using your bicep file.
> - Review the configuration of your deployment stack and managed resources

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create the Bicep file

Our first step is to create a bicep file that defines our resources to use with the deployment stack

1. Open Visual Studio Code.

1. Create a new file called _main.bicep_.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a _templates_ folder in which to save the file.

1. Add the following Bicep code into the file. You'll deploy the template soon. It's a good idea to type the code yourself instead of copying and pasting, so you can see how the tooling helps you to write your Bicep files.

   :::code language="bicep" source="code/1-template.bicep" range="1-28":::

> [!NOTE]
> You may notice the `${uniqueString(resourceGroup().id)}' syntax on the 'webApplicationName' parameter. The uniqueString function creates a string based on the id of the resource group and adds it as a suffix to 'webapp-deposits'. Many Azure services require unique names. This function helps generate a unique name.

1. Save the changes to the file.

## Create the deployment stack and deploy your resources to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first deployment stack exercise - CLI](../../includes/azure-deployment-stacks-exercise-nosandbox-deploy-cli.md)]

### Create a resource group

We need to create a resource group for our deployment stack and managed resources. Run the following command from the terminal in Visual Studio Code to create a resource group.

```azurecli
az group create \
    --name rg-depositsApplication \
    --location eastus
```

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first deployment stack exercise - PowerShell](../../includes/azure-deployment-stacks-exercise-nosandbox-deploy-powershell.md)]

### Create a resource group

We need to create a resource group for our deployment stack and managed resources. Run the following command from the terminal in Visual Studio Code to create a resource group.

```azurepowershell
New-AzResourceGroup \
    --name rg-depositsApplication \
    --location eastus
```

::: zone-end

### Create the deployment stack

Next, we need to create our deployment stack scoped to our recently created resource group. When we create the stack, the Azure resources in the bicep file are created and now managed by the stack.

Run the following command from the terminal in Visual Studio Code to create a deployment stack.

::: zone pivot="cli"

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep
    --deny-settings-mode none
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
New-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep
    -DenySettingsMode none
```

::: zone-end

## Verify the creation of the deployment stack and the managed resources

::: zone pivot="cli"

When you create a deployment stack and its managed resources, you can view its configuration using the command-line or the Azure portal. In this exercise, we will use AZ CLI.

Run the following command from the terminal in Visual Studio code to view the configuration of the created deployment stack

```azurecli
az stack group show \
    --resource-group rg-depositsApplication
    --name stack-deposits
```

The results include the properties of the deployment stack as well as the status of the managed resources. The output should appear familiar to the following:

:::code language="json" source="code/2-json.json" range="1-56":::

Take notice of the resources section of the output. For each resource, it shows its status as "managed", its resource group, its resource id, and its deny settings.

::: zone-end

::: zone pivot="powershell"

When you create a deployment stack and its managed resources, you can view its configuration using the command-line or the Azure portal. In this exercise, we will use Azure PowerShell.

Run the following command from the terminal in Visual Studio code to view the configuration of the created deployment stack

```azurepowershell
Get-AzResourceGroupDeploymentStack \
    -ResourceGroupName rg-depositsApplication
    -Name stack-deposits
```

The results include the properties of the deployment stack as well as the status of the managed resources. The output should appear familiar to the following:

:::code language="json" source="code/2-json.json" range="1-10":::

Take notice of the resources section of the output. This defines the resources that are managed by the deployment stack. You see the full resource ID of each resource.

::: zone-end