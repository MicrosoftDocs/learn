TODO lead-in

In this exercise, you'll:

> [!div class="checklist"]
> * Create a resource group for your website.
> * Create a service principal and grant it access to the resource group.
> * Create a service connection and configure it with the service principal's credentials.

This exercise requires that you have permission to create applications and service principals in your Azure Active Directory (Azure AD) directory. If you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant.

## Sign in to Azure

::: zone pivot="cli"

To work with service principals in Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli) tools.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. If the dropdown control at the right displays **bash**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../includes/media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with bash displayed in the dropdown control." border="true":::

    If **bash** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **bash**.

    :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, displaying the dropdown list for selecting a preferred terminal shell." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with Bash as the shell.

[!INCLUDE [Upgrade Azure CLI](../../includes/azure-template-bicep-exercise-upgrade-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, sign in to Azure by running the following command: 

    ```azurecli
    az login
    ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps), and sign in to the same account that activated the sandbox.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. If the dropdown control at the right displays **pwsh** or **PowerShell**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../includes/media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with 'pwsh' displayed in the dropdown control." border="true":::

   If **pwsh** or **PowerShell** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **pwsh** or **PowerShell**.   

    :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, displaying the dropdown list for selecting your preferred terminal shell." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with **pwsh** or **PowerShell** as the shell.

[!INCLUDE [Upgrade Azure PowerShell](../../includes/azure-template-bicep-exercise-upgrade-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, sign in to Azure by running the following command:

    ```azurepowershell
    Connect-AzAccount
    ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a resource group in Azure

::: zone pivot="cli"

Run this Azure CLI command in the Visual Studio Code terminal to create a new resource group:

```azurecli
az group create --name ToyWebsite --location westus
```

::: zone-end

::: zone pivot="powershell"

Run this Azure PowerShell commands in the Visual Studio Code terminal to create a resource group:

```azurepowershell
New-AzResourceGroup -Name ToyWebsite -Location westus
```

::: zone-end

## Create a service principal and grant it access to the resource group

::: zone pivot="cli"

1. Run this Azure CLI command in the Visual Studio Code terminal to create a service principal:

   ```azurecli
   az ad sp create-for-rbac \
     --name ToyWebsitePipeline \
     --role Contributor \
     --scopes TODO-RGID
   ```

1. Look at the JSON output from the previous command. It includes the following properties:
 
   - `appId`: The service principal's application ID.
   - `password`: The service principal's key.
   - `tenant`: Your Azure AD tenant ID.

   TODO need sub ID and sub name

   Copy these values somewhere safe. You'll use them soon. 

::: zone-end

::: zone pivot="powershell"

1. Run these Azure PowerShell commands in the Visual Studio Code terminal to create a service principal:

   ```azurepowershell
   $servicePrincipal = New-AzADServicePrincipal `
     -DisplayName ToyWebsitePipeline `
     -Role Contributor `
     -Scope TODO-RGID

   $plaintextSecret = [System.Net.NetworkCredential]::new('', $servicePrincipal.Secret).Password
   ```

1. Run the following command to show the service principal's application ID, the key, and your Azure AD tenant ID:

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

Now that you've created the resource group and service principal, you create a service connection in Azure Pipelines.

1. In your browser, select **Project settings**.

   TODO ss

1. Select **Service connections**.

   TODO ss

1. Select **Create service connection**.

   TODO SS

1. Select **Azure Resource Manager** and select **Next**.

   TODO SS

1. Select **Service principal (manual)** and select **Next**.

   TODO SS

   > [!NOTE]
   > It's a good idea to manually create service principals like you're doing here, rather than using the automatic service principal creation in Azure Pipelines. This is because, when Azure Pipelines creates a service principal for you, it grants it permissions to your whole subscription. It's more secure to grant permissions at a narrower scope like a resource group, and that requires you use the manual creation process.

1. Enter the subscription ID and subscription name that you saved earlier.

   TODO SS

1. In **Service principal ID**, enter the service principal's application ID that you saved earlier.

   TODO SS

1. In **Service principal key**, enter the service principal's key that you saved earlier.

1. In **Tenant ID**, enter the Azure tenant ID that you saved earlier.

1. Select the **Verify** button.

   TODO SS

   Azure Pipelines verifies it can access your Azure subscription.

1. In **Service connection name**, enter _ToyWebsite_.

   Leave **Grant access permission to all pipelines** checked.

1. Select **Verify and save**.
