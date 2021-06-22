Before you start creating the deployment pipeline for your toy company's website, you need to create a service principal and grant it access to your Azure environment. In this exercise, you'll create a service principal that you'll use for your deployment pipeline.

During the process, you'll:

> [!div class="checklist"]
> * Create an application, service principal, and key, in a single operation.
> * Securely handle the key.
> * Verify the service principal works by logging into Azure using its credentials.

This exercise requires that you have permission to create applications and service principals in your Azure AD directory. If you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant. Alternatively, you can skip the deployment steps in this exercise.

## Sign in to Azure

::: zone pivot="cli"

To work with service principals in Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you've installed the [Azure CLI](/cli/azure/install-azure-cli) tools.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. If the dropdown control at the right displays **bash**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../includes/media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with 'bash' displayed in the dropdown control." border="true":::

    If **bash** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **bash**.

    :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, displaying the 'Select your preferred terminal shell' dropdown list." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with Bash as the shell.

[!INCLUDE [Upgrade Azure CLI](../../includes/azure-template-bicep-exercise-upgrade-cli.md)]

### Sign in to Azure by using Azure CLI

1. In the Visual Studio Code terminal, sign in to Azure by running the following command: 

    ```azurecli
    az login
    ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure you've [installed Azure PowerShell](/powershell/azure/install-az-ps), and sign in to the same account that activated the sandbox.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. If the dropdown control at the right displays **pwsh** or **PowerShell**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../includes/media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with 'pwsh' displayed in the dropdown control." border="true":::

   If **pwsh** or **PowerShell** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **pwsh** or **PowerShell**.   

    :::image type="content" source="../../includes/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, displaying the 'Select your preferred terminal shell' dropdown list." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with *pwsh* or *PowerShell* as the shell.

[!INCLUDE [Upgrade Azure PowerShell](../../includes/azure-template-bicep-exercise-upgrade-powershell.md)]

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
     --name ToyWebsitePipeline \
     --skip-assignment
   ```

1. Look at the JSON output from the previous command. It includes the following properties:
 
   - `name`: the service principal's name.
   - `password`: the service principal's key.
   - `tenant`: your Azure AD tenant ID.

   Copy the values somewhere safe. You'll use this soon. Make sure not to leave the key anywhere insecure.

::: zone-end

::: zone pivot="powershell"

1. Run these Azure PowerShell commands in the Visual Studio Code terminal to create a service principal:

   ```azurepowershell
   $servicePrincipal = New-AzADServicePrincipal `
     -DisplayName ToyWebsitePipeline `
     -SkipAssignment

   $plaintextSecret = [System.Net.NetworkCredential]::new('', $servicePrincipal.Secret).Password
   ```

1. Run the following command to show the service principal's name, the key, and your Azure AD tenant ID:

   ```azurepowershell
   Write-Output "Service principal name: $($servicePrincipal.ServicePrincipalNames[0])"
   Write-Output "Service principal key: $($plaintextSecret)"
   Write-Output "Your Azure AD tenant ID: $((Get-AzContext).Tenant.Id)"
   ```

   Copy the values somewhere safe. You'll use this soon. Make sure not to leave the key anywhere insecure.

::: zone-end

## Test the service principal

Now the service principal has been created, you will log in using its credentials to verify it's been created successfully.

::: zone pivot="cli"

1. Run this Azure CLI command in the Visual Studio Code terminal to log in using the service principal's credentials. Make sure you replace the placeholders with the values you copied in the previous step.

   ```azurecli
   az login --service-principal \
     --username SERVICE-PRINCIPAL-NAME \
     --password SERVICE-PRINCIPAL-PASSWORD \
     --tenant YOUR-AZURE-AD-TENANT-ID \
     --allow-no-subscriptions
   ```

   Notice that you include the `--allow-no-subscriptions` argument. Normally when you run the `az login` command, the Azure CLI looks for the Azure subscriptions you can access. The service principal hasn't been granted access to anything yet, so you use the `--allow-no-subscriptions` argument to avoid the Azure CLI checking the subscription list and showing an error.

1. Check that the output from the previous command is a JSON object, which includes a `user` property with the service principal's name. This indicates the service principal signed in successfully.

1. Log out of the service principal's account by using the following command:

   ```azurecli
   az logout
   ```

::: zone-end

::: zone pivot="powershell"

1. Run this Azure PowerShell command in the Visual Studio Code terminal to securely prompt you for the service principal's credentials. Use the service principal's name and key from the the previous step for the username and password, respectively.

   ```azurepowershell
   $credential = Get-Credential
   ```

1. Run this Azure PowerShell command in the Visual Studio Code terminal to log in using the service principal's credentials. Make sure you replace the placeholders with the values you copied in the previous step.

   ```azurepowershell
   Connect-AzAccount -ServicePrincipal `
     -Credential $credential `
     -Tenant YOUR-AZURE-AD-TENANT-ID
   ```

1. Check that the output from the previous command includes an `Account` property with the service principal's name, and a blank `SubscriptionName`.

1. Log out of the service principal's account by using the following command:

   ```azurepowershell
   Logout-AzAccount
   ```

::: zone-end

Now that you have a working service principal, you can move onto the next stage: authorizing it to access your Azure environment.
