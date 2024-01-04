Before you can deploy your toy company's website by using a pipeline, you need to create a service connection for your pipeline to use. In this exercise, you'll:

> [!div class="checklist"]
>
> - Create a resource group for your website.
> - Create an Azure Pipelines service connection and configure it to access the resource group.

This exercise requires that you have permissions to create applications and service principals in your Microsoft Entra directory. If you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/) and create a new Azure subscription and tenant.

[!INCLUDE [](../../includes/cleanup-steps.md)]

## Sign in to Azure

::: zone pivot="cli"

To work with service principals in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli) tools.

[!INCLUDE [](../../includes/azure-exercise-terminal-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps), and sign in to the same account that you used to activate the sandbox.

[!INCLUDE [](../../includes/azure-exercise-terminal-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a resource group in Azure

::: zone pivot="cli"

To create a new resource group, run this Azure CLI command in the Visual Studio Code terminal:

```azurecli
az group create --name ToyWebsite --location westus3
```

::: zone-end

::: zone pivot="powershell"

To create a resource group, run this Azure PowerShell command in the Visual Studio Code terminal:

```azurepowershell
New-AzResourceGroup -Name ToyWebsite -Location westus3
```

::: zone-end

## Create a service connection in Azure Pipelines

Next, create a service connection in Azure Pipelines. This process automatically creates a service principal in Azure. It also grants the service principal the Contributor role on your resource group, which allows your pipeline to deploy to the resource group.

1. In your browser, select **Project settings**.

   :::image type="content" source="../../includes/media/azure-devops-project-settings.png" alt-text="Screenshot of Azure DevOps that shows the menu, with the 'Project settings' item highlighted.":::

1. Select **Service connections** > **Create service connection**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the 'Create service connection' button highlighted.":::

1. Select **Azure Resource Manager** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-type.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the Azure Resource Manager service connection type highlighted.":::

1. Select **Service principal (automatic)** > **Next**.

   :::image type="content" source="../../includes/media/azure-devops-create-service-connection-principal-type.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the Service principal (automatic) option highlighted.":::

1. In the **Subscription** drop-down, select your Azure subscription.

   A popup window might appear, asking you to sign in to Azure. If it does, enter your credentials and sign in.

1. In the **Resource group** drop-down, select **ToyWebsite**.

1. In **Service connection name**, enter **ToyWebsite**. Ensure that the **Grant access permission to all pipelines** checkbox is selected.

   :::image type="content" source="../media/5-create-service-connection-principal-details.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the details completed and the Next button highlighted.":::

   > [!TIP]
   > For simplicity, you're giving every pipeline access to your service connection. When you create real service connections that work with production resources, consider restricting access to only the pipelines that need them.

1. Select **Save**.

1. In **Service connections**, verify that your new service connection is shown in the list of service connections.

   :::image type="content" source="../media/5-service-connection-created.png" alt-text="Screenshot of Azure DevOps that shows the list of service connections, with the ToyWebsite service connection included.":::
