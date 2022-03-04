Before you create the deployment pipeline for your toy company's website, you need to create a service principal and grant it access to your Azure environment. In this exercise, you'll create the service principal that you'll use for your deployment pipeline.

During the process, you'll:

> [!div class="checklist"]
> * Create an application, service principal, and key, in a single operation.
> * Securely handle the key.
> * Verify that the service principal works by signing in to Azure by using its credentials.

This exercise requires that you have permission to create applications and service principals in your Azure Active Directory (Azure AD) directory. If you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant. Alternatively, you can skip this exercise.

## Sign in to Azure

::: zone pivot="cli"

To work with service principals in Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli) tools.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. If the dropdown control at the right displays **bash**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../includes/media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with bash displayed in the dropdown control." border="true":::

    If **bash** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **bash**.

    :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, displaying the dropdown list for selecting a preferred terminal shell." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with Bash as the shell.

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

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, sign in to Azure by running the following command:

    ```azurepowershell
    Connect-AzAccount
    ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a service principal and key

::: zone pivot="cli"

1. Run this Azure CLI command in the Visual Studio Code terminal to create a service principal:

   ```azurecli
   az ad sp create-for-rbac \
     --role Contributor \
     --scopes /subscriptions/<SUBSCRIPTION-ID> \
     --name ToyWebsitePipeline
   ```

   [!INCLUDE [](../../includes/azure-template-bicep-exercise-cli-unique-display-name.md)]

1. Look at the JSON output from the previous command. It includes the following properties:
 
   - `appId`: The service principal's application ID.
   - `password`: The service principal's key.
   - `tenant`: Your Azure AD tenant ID.

   Copy these values somewhere safe. You'll use them soon. 

::: zone-end

::: zone pivot="powershell"

1. Run these Azure PowerShell commands in the Visual Studio Code terminal to create a service principal:

   ```azurepowershell
   $servicePrincipal = New-AzADServicePrincipal `
     -DisplayName ToyWebsitePipeline `
     -SkipAssignment

   $plaintextSecret = [System.Net.NetworkCredential]::new('', $servicePrincipal.Secret).Password
   ```

1. Run the following command to show the service principal's application ID, the key, and your Azure AD tenant ID:

   ```azurepowershell
   Write-Output "Service principal application ID: $($servicePrincipal.ApplicationId)"
   Write-Output "Service principal key: $($plaintextSecret)"
   Write-Output "Your Azure AD tenant ID: $((Get-AzContext).Tenant.Id)"
   ```

   Copy the values somewhere safe. You'll use them soon.

::: zone-end

> [!WARNING]
> The outputs from the preceding commands contain the key for your service principal. Be careful about where you run these commands. For example, don't run them in an environment where someone might be able to view them.

## Test the service principal

Now that the service principal has been created, you sign in by using its credentials to verify that it was created successfully.

::: zone pivot="cli"

1. Run this Azure CLI command in the Visual Studio Code terminal to sign in by using the service principal's credentials. Replace the placeholders with the values that you copied in the previous step.

   ```azurecli
   az login --service-principal \
     --username APPLICATION_ID \
     --password SERVICE_PRINCIPAL_KEY \
     --tenant TENANT_ID \
     --allow-no-subscriptions
   ```

   Notice that you include the `--allow-no-subscriptions` argument. Normally when you run the `az login` command, the Azure CLI looks for the Azure subscriptions that you can access. The service principal hasn't been granted access to anything yet, so you use the `--allow-no-subscriptions` argument to prevent the Azure CLI from checking the subscription list and showing an error.

1. Check that the output from the previous command is a JSON object, which includes a `user` property with the service principal's application ID. This information indicates that the service principal signed in successfully.

1. Sign out of the service principal's account by using the following command:

   ```azurecli
   az logout
   ```

::: zone-end

::: zone pivot="powershell"

1. Run this Azure PowerShell command in the Visual Studio Code terminal to securely prompt you for the service principal's credentials. Use the service principal's application ID and key from the previous step for the username and password, respectively.

   ```azurepowershell
   $credential = Get-Credential
   ```

1. Run this Azure PowerShell command in the Visual Studio Code terminal to sign in by using the service principal's credentials. Replace the placeholders with the values that you copied in the previous step.

   ```azurepowershell
   Connect-AzAccount -ServicePrincipal `
     -Credential $credential `
     -Tenant TENANT_ID
   ```

1. Check that the output from the previous command includes an `Account` property with the service principal's application ID, and a blank `SubscriptionName` value. This information indicates that the service principal signed in successfully.

1. Sign out of the service principal's account by using the following command:

   ```azurepowershell
   Logout-AzAccount
   ```

::: zone-end

Now that you have a working service principal, you can move on to the next stage: authorizing it to access your Azure environment.
