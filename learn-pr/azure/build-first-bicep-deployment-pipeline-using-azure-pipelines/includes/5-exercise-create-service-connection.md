Before you can deploy your toy company's website by using a pipeline, you need to create a service connection for your pipeline to use. In this exercise, you'll:

> [!div class="checklist"]
> * Create a resource group for your website.
> * Create an Azure AD service principal and grant it access to the resource group.
> * Create an Azure Pipelines service connection and configure it to use the service principal's credentials.

This exercise requires that you have permissions to create applications and service principals in your Azure AD directory. If you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant.

## Sign in to Azure

::: zone pivot="cli"

To work with service principals in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true) tools.

1. To open a Visual Studio Code terminal window, select **Terminal** > **New Terminal**. The window usually opens at the bottom of your screen.

1. If the dropdown control on the right displays **bash**, the correct shell is open and you can skip to the next section.

   :::image type="content" source="../../includes/media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with bash displayed in the dropdown control.":::

   If **bash** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **bash**.

   :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window that displays the dropdown list for selecting a preferred terminal shell.":::

1. In the terminal, select the plus sign (**+**) to create a new terminal with Bash as the shell.

[!INCLUDE [Upgrade Azure CLI](../../includes/azure-template-bicep-exercise-upgrade-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true), and sign in to the same account that you used to activate the sandbox.

1. To open a Visual Studio Code terminal window, select **Terminal** > **New Terminal**. The window usually opens at the bottom of your screen.

1. If the dropdown control at the right displays **pwsh** or **PowerShell**, the correct shell is open and you can skip to the next section.

   :::image type="content" source="../../includes/media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with 'pwsh' displayed in the dropdown control.":::

   If **pwsh** or **PowerShell** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **pwsh** or **PowerShell**.

   :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window that displays the dropdown list for selecting your preferred terminal shell.":::

1. In the terminal, select the plus sign (**+**) to create a new terminal with pwsh or PowerShell as the shell.

[!INCLUDE [Upgrade Azure PowerShell](../../includes/azure-template-bicep-exercise-upgrade-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a resource group in Azure

::: zone pivot="cli"

1. To create a new resource group, run this Azure CLI command in the Visual Studio Code terminal:

   ```azurecli
   az group create --name ToyWebsite --location westus
   ```

1. Look at the JSON output from the command. It includes an `id` property, which is the resource group's ID.

   Copy the resource group ID somewhere safe. You'll use it soon.

::: zone-end

::: zone pivot="powershell"

1. To create a resource group, run this Azure PowerShell command in the Visual Studio Code terminal:

   ```azurepowershell
   New-AzResourceGroup -Name ToyWebsite -Location westus
   ```

1. Look at the output from the command. It includes a `ResourceId`, which is the resource group's fully qualified ID.

   Copy the resource group ID somewhere safe. You'll use it soon.

::: zone-end

## Create a service principal and grant it access to the resource group

::: zone pivot="cli"

1. To create a service principal and assign it the Contributor role for your resource group, run the following Azure CLI command in the Visual Studio Code terminal. Replace the placeholder with the resource group ID you copied in the last step.

   ```azurecli
   az ad sp create-for-rbac \
     --name ToyWebsitePipeline \
     --role Contributor \
     --scopes RESOURCE_GROUP_ID
   ```

1. Look at the JSON output from the command. It includes the following properties:

    * `appId`: The service principal's application ID.
    * `password`: The service principal's key.
    * `tenant`: Your Azure AD tenant ID.

   Copy these values somewhere safe. You'll use them soon.

1. To view information about your Azure subscription, run this Azure CLI command:

   ```azurecli
   az account show
   ```

1. Look at the JSON output from the command. It includes the following properties:

    * `id`: Your Azure subscription ID.
    * `name`: Your Azure subscription name.

   Copy these values somewhere safe. You'll use them soon.

::: zone-end

::: zone pivot="powershell"

1. To create a service principal and assign it the Contributor role for your resource group, run the following Azure PowerShell code in the Visual Studio Code terminal. Replace the placeholder with the resource group ID you copied in the last step.

   ```azurepowershell
   $servicePrincipal = New-AzADServicePrincipal `
     -DisplayName ToyWebsitePipeline `
     -Role Contributor `
     -Scope RESOURCE_GROUP_ID

   $plaintextSecret = [System.Net.NetworkCredential]::new('', $servicePrincipal.Secret).Password
   ```

1. Run this code to show the service principal's application ID, the key, and your Azure AD tenant ID:

   ```azurepowershell
   Write-Output "Service principal application ID: $($servicePrincipal.ApplicationId)"
   Write-Output "Service principal key: $($plaintextSecret)"
   Write-Output "Azure subscription ID: $((Get-AzContext).Subscription.Id)"
   Write-Output "Azure subscription name: $((Get-AzContext).Subscription.Name)"
   Write-Output "Azure AD tenant ID: $((Get-AzContext).Tenant.Id)"
   ```

   Copy the values somewhere safe. You'll use them soon.

::: zone-end

## Create a service connection in Azure Pipelines

You've created a resource group and a service principal. Next, create a service connection in Azure Pipelines.

1. In your browser, select **Project settings** > **Service connections** > **Create service connection**.

   :::image type="content" source="../media/5-create-service-connection.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the 'Create service connection' button highlighted.":::

1. Select **Azure Resource Manager** > **Next**.

   :::image type="content" source="../media/5-create-service-connection-type.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with the Azure Resource Manager service connection type highlighted.":::

1. Select **Service principal (manual)** > **Next**.

   :::image type="content" source="../media/5-create-service-connection-principal-type.png" alt-text="Screenshot of the Azure DevOps 'Create service connection' page, with the 'Service principal (manual)' authentication method highlighted.":::

   > [!NOTE]
   > It's a good idea to manually create service principals like you're doing here, rather than using the automatic service principal creation that's available in Azure Pipelines. When you use the automatic method, Azure Pipelines grants the service principal permissions to your entire subscription. It's more secure to grant permissions with a narrower scope, like a resource group. Granting specific permissions requires you to use the manual creation process.

1. In **Subscription Id** and **Subscription Name**, enter the subscription ID and subscription name that you saved earlier.

   :::image type="content" source="../media/5-create-service-connection-principal-details-1.png" alt-text="Screenshot of Azure DevOps that shows the 'Create service connection' page, with a subscription ID and subscription name entered.":::

1. In **Service principal Id** and **Service principal key**, enter the service principal's application ID and the key that you saved earlier. In **Tenant ID**, enter the Azure tenant ID that you saved earlier. Select **Verify**.

   :::image type="content" source="../media/5-create-service-connection-principal-details-2.png" alt-text="Screenshot of the Azure DevOps 'Create service connection' page, with the details completed and the Verify button highlighted.":::

1. Azure Pipelines verifies that it can access your Azure subscription. Check that*Verification succeeded* is shown.

   > [!NOTE]
   > If the verification doesn't succeed, check that you copied the correct values for the service principal, subscription, and tenant. Wait a few minutes to allow time for Azure's role assignments to replicate globally, and then try again.

1. In **Service connection name**, enter **ToyWebsite**. Ensure that the **Grant access permission to all pipelines** checkbox is selected. Select **Verify and save**.

   :::image type="content" source="../media/5-create-service-connection-principal-details-3.png" alt-text="Screenshot of the Azure DevOps 'Create service connection' page, with the 'Verify and save' button highlighted.":::

   > [!TIP]
   > For simplicity, you're giving every pipeline access to your service connection. When you create real service connections that work with production resources, consider restricting access to only the pipelines that need them.

1. In **Service connections**, verify that your new service connection is shown in the list of service connections.

   :::image type="content" source="../media/5-service-connection-created.png" alt-text="Screenshot of Azure DevOps that shows the list of service connections, with the ToyWebsite service connection included.":::
