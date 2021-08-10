Before you can deploy your toy company's website from a pipeline, you need to create a service connection for your pipeline to use. In this exercise, you'll:

> [!div class="checklist"]
> * Create a resource group for your website.
> * Create an Azure AD service principal and grant it access to the resource group.
> * Create an GitHub secret and configure it with the service principal's credentials.

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

2. If the dropdown control at the right displays **pwsh** or **PowerShell**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../includes/media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with 'pwsh' displayed in the dropdown control." border="true":::

   If **pwsh** or **PowerShell** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **pwsh** or **PowerShell**.   

    :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, displaying the dropdown list for selecting your preferred terminal shell." border="true":::

3. Select the plus sign (**+**) in the terminal to create a new terminal with **pwsh** or **PowerShell** as the shell.

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

1. Run this Azure CLI command in the Visual Studio Code terminal to create a new resource group:

   ```azurecli
   az group create --name ToyWebsite --location westus
   ```

1. Look at the JSON output from the previous command. It includes an `id` property, which is the resource group's ID.

   Copy the resource group ID somewhere safe. You'll use it soon.

::: zone-end

::: zone pivot="powershell"

1. Run this Azure PowerShell commands in the Visual Studio Code terminal to create a resource group:

   ```azurepowershell
   New-AzResourceGroup -Name ToyWebsite -Location westus
   ```

1. Look at the output from the previous command. It includes a `ResourceId`, which is the resource group's fully qualified ID.

   Copy the resource group ID somewhere safe. You'll use it soon.

::: zone-end

## Create a service principal and grant it access to the resource group

::: zone pivot="cli"

1. Run this Azure CLI command in the Visual Studio Code terminal to create a service principal and assign it the Contributor role for your resource group. Replace the placeholder with the resource group ID you copied in the previous step.

   ```azurecli
   az ad sp create-for-rbac \
     --name ToyWebsitePipeline \
     --role Contributor \
     --scopes RESOURCE_GROUP_ID \
     --sdk-auth
   ```

1. Look at the JSON output from the previous command. It will look like this:

   ```json
   {
     "clientId": "c6bf233f-d1b8-480a-9cf7-27e2186345d2",
     "clientSecret": "<secret value>",
     "subscriptionId": "f0750bbe-ea75-4ae5-b24d-a92ca601da2c",
     "tenantId": "dbd3173d-a96b-4c2f-b8e9-babeefa21304",
     "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
     "resourceManagerEndpointUrl": "https://management.azure.com/",
     "activeDirectoryGraphResourceId": "https://graph.windows.net/",
     "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
     "galleryEndpointUrl": "https://gallery.azure.com/",
     "managementEndpointUrl": "https://management.core.windows.net/"
   }
   Copy the entire output somewhere safe (including the curly braces). You'll use it soon. 

::: zone-end

::: zone pivot="powershell"

1. Run these Azure PowerShell commands in the Visual Studio Code terminal to create a service principal and assign it the Contributor role for your resource group. Replace the placeholder with the resource group ID you copied in the previous step. 

   ```azurepowershell
   $resourceGroupId = 'RESOURCE_GROUP_ID'

   $azureContext = Get-AzContext
   $servicePrincipal = New-AzADServicePrincipal `
   -DisplayName ToyWebsitePipeline `
   -Role Contributor `
   -Scope $resourceGroupId

   $output = @{
      clientId = $($servicePrincipal.ApplicationId)
      clientSecret = $([System.Net.NetworkCredential]::new('', $servicePrincipal.Secret).Password)
      subscriptionId = $($azureContext.Subscription.Id)
      tenantId = $($azureContext.Tenant.Id)
   }
   $output | ConvertTo-Json
   ```

1. The output of these commands will give you a JSon object. Copy the entire output somewhere safe (including the curly braces). You'll use it soon.  

::: zone-end

## Create a GitHub secret

Now that you've created the resource group and service principal, you create a secret in your GitHub repository.

1. In your browser, navigate to your GitHub repository.

1. Select **Settings** > **Secrets**.

   :::image type="content" source="../media/5-settings-secrets.png" alt-text="Screenshot of the GitHub interface showing the 'Settings' page, with the Secrets menu highlighted." border="true":::

1. Select **New repository secret**.

   :::image type="content" source="../media/5-create-repository-secret.png" alt-text="Screenshot of the GitHub interface showing the 'Secrets' page, with the 'Create repository secret' button highlighted." border="true":::

1. Name the secret *AZURE_CREDENTIALS*.
1. In the **Value** field, paste the JSON object that you copied in earlier in the exercise.
1. Select **Add secret**. 

   :::image type="content" source="../media/5-create-repository-secret-details-1.png" alt-text="Screenshot of the GitHub interface showing the 'Actions Secrets/New Secret' page, with the Name and Value filled out and the 'Add secret' button highlighted." border="true":::
