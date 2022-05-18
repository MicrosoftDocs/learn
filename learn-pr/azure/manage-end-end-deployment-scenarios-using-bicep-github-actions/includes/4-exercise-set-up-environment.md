Before you start to work on your toy company's website workflow, you need to configure your environment. In this unit, you make sure that your Azure and GitHub environments are set up to complete the rest of this module.

To meet these objectives, you'll:

> [!div class="checklist"]
> * Set up a GitHub repository for this module.
> * Clone the project's repository to your computer.
> * Create two service principals in Azure Active Directory.
> * Create two resource groups in Azure.
> * Create two secrets and environments in GitHub.

## Get the GitHub repository

Here you make sure that your GitHub repository is set up to complete the rest of this module. You set it up by creating a new repository based on a template repository. The template repository contains the files you need to get started for this module. 

The modules in this learning path are part of a progression. For learning purposes, each module has an associated GitHub template repository.

> [!TIP]
> Even if you completed the previous module in the learning path, please follow these instructions to create a new repository and ensure that you give it a new name.

### Start from the template repository

Run a template that sets up your GitHub repository.

> [!div class="nextstepaction"]
> [Run the template](https://github.com/MicrosoftDocs/mslearn-manage-end-end-deployment-scenarios-using-bicep-github-actions?azure-portal=true)

On the GitHub site, follow these steps to create a repository from the template:

1. Select **Use this template**. 

   :::image type="content" source="../media/4-template.png" alt-text="Screenshot of the GitHub interface showing the template repo, with the 'Use this template' button highlighted.":::

1. Enter a name for your new project, such as *toy-website-end-to-end*.

1. Select the **Public** option.

   When you create your own repositories, you might want to make them private. In this module, you'll work with some features of GitHub that only work with public repositories and with GitHub Enterprise accounts.

1. Select **Create repository from template**. 

   :::image type="content" source="../media/4-repo-settings.png" alt-text="Screenshot of the GitHub interface showing the repo creation page.":::

[!include[](../../includes/cleanup-steps.md)]

## Clone the repository

You now have a copy of the template repository in your own account. You will now clone this repository locally so you can start work in it. 

1. Select **Code** and select the copy icon.

   :::image type="content" source="../media/4-github-repository-clipboard.png" alt-text="Screenshot of the GitHub interface showing the new repository, with the repository U R L copy button highlighted.":::

1. Open Visual Studio Code. 

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. Navigate in the terminal to the directory where you want to clone the GitHub repository on your local computer. For example, to clone the repository to the _toy-website-environments_ folder, run the following command:

   ```bash
   cd toy-website-end-to-end
   ```

1. Type `git clone` and then paste the URL you copied earlier, which looks something like this:

   ```bash
   git clone https://github.com/mygithubuser/toy-website-end-to-end.git
   ```

1. Reopen Visual Studio Code in the repository folder by running the following command in the Visual Studio Code terminal:

   ```bash
   code -r toy-website-end-to-end
   ```

## Sign in to Azure

::: zone pivot="cli"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true) tools.

[!include[](../../includes/azure-exercise-terminal-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true).

[!include[](../../includes/azure-exercise-terminal-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create two resource groups in Azure

::: zone pivot="cli"

1. To create the test environment's resource group, run the following Azure CLI commands in the Visual Studio Code terminal:

   ```azurecli
   az group create --name ToyWebsiteTest --location westus
   ```

1. Look at the JSON output from the command. It includes an `id` property, which is the resource group's ID.

   Copy the resource group ID somewhere safe. You'll use it soon.

1. Repeat the process to create the production environment's resource group:

   ```azurecli
   az group create --name ToyWebsiteProduction --location westus
   ```

   Copy the resource group ID for the production resource group, too.

::: zone-end

::: zone pivot="powershell"

1. To create the test environment's resource group, run the following Azure PowerShell commands in the Visual Studio Code terminal:

   ```azurepowershell
   New-AzResourceGroup -Name ToyWebsiteTest -Location westus
   ```

1. Look at the output from the command. It includes a `ResourceId`, which is the resource group's fully qualified ID.

   Copy the resource group ID somewhere safe. You'll use it soon.

1. Repeat the process to create the production environment's resource group:

   ```azurepowershell
   New-AzResourceGroup -Name ToyWebsiteProduction -Location westus
   ```

   Copy the resource group ID for the production resource group, too.

::: zone-end

## Create two service principals and grant them access to the resource group

Next, create two service principals in Azure AD: one for your test environment and another for your production environment. This process also grants the service principal the Contributor role on your resource group, which allows your workflow to deploy to the resource group.

::: zone pivot="cli"

1. To create a service principal and assign it the Contributor role for your resource group, run the following Azure CLI command in the Visual Studio Code terminal. Replace the `RESOURCE_GROUP_ID` placeholder with the resource group ID you copied in the last step.

   ```azurecli
   az ad sp create-for-rbac \
     --name ToyWebsiteTest \
     --role Contributor \
     --scopes RESOURCE_GROUP_ID \
     --sdk-auth
   ```

   [!INCLUDE [](../../includes/azure-template-bicep-exercise-cli-unique-display-name.md)]

1. Select the JSON output from the previous command. It looks like this:

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
   ```

   Copy the entire output somewhere safe, including the curly braces. You'll use it soon. 

1. Repeat the steps above to create another service principal for your production environment. Make sure to replace `RESOURCE_GROUP_ID` with your production resource group's resource ID.

   ```azurecli
   az ad sp create-for-rbac \
     --name ToyWebsiteProduction \
     --role Contributor \
     --scopes RESOURCE_GROUP_ID \
     --sdk-auth
   ```

::: zone-end

::: zone pivot="powershell"

1. To create a service principal and assign it the Contributor role for your resource group, run the following Azure PowerShell code in the Visual Studio Code terminal. Replace the `RESOURCE_GROUP_ID` placeholder with the resource group ID you copied in the last step.

   ```azurepowershell
   $resourceGroupId = 'RESOURCE_GROUP_ID'

   $azureContext = Get-AzContext
   $servicePrincipal = New-AzADServicePrincipal `
       -DisplayName ToyWebsiteTest `
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

1. Select the JSON output from the previous command. It looks like this:

   ```json
   {
     "clientId": "c6bf233f-d1b8-480a-9cf7-27e2186345d2",
     "clientSecret": "<secret value>",
     "subscriptionId": "f0750bbe-ea75-4ae5-b24d-a92ca601da2c",
     "tenantId": "dbd3173d-a96b-4c2f-b8e9-babeefa21304"
   }
   ```

   Copy the entire output somewhere safe, including the curly braces. You'll use it soon.

1. Repeat the steps above to create another service principal for your production environment. Make sure to replace `RESOURCE_GROUP_ID` with your production resource group's resource ID.

   ```azurepowershell
   $resourceGroupId = 'RESOURCE_GROUP_ID'

   $azureContext = Get-AzContext
   $servicePrincipal = New-AzADServicePrincipal `
       -DisplayName ToyWebsiteProduction `
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

::: zone-end

## Create two GitHub secrets

You've created two resource group and the service principals that can deploy to them. Next, create secrets in GitHub Actions.

1. In your browser, navigate to your GitHub repository.

1. Select **Settings** > **Secrets**.

1. Select **New repository secret**.

   :::image type="content" source="../../includes/media/github-create-repository-secret.png" alt-text="Screenshot of the GitHub interface showing the 'Secrets' page, with the 'Create repository secret' button highlighted." border="true":::

1. Name the secret *AZURE_CREDENTIALS_TEST*.

1. In the **Value** field, paste the JSON object for the test environment that you copied in the previous section.

1. Select **Add secret**. 

   :::image type="content" source="../media/4-github-create-repository-secret-details.png" alt-text="Screenshot of the GitHub interface showing the 'New Secret' page, with the name and value completed and the 'Add secret' button highlighted." border="true":::

1. Repeat the process for a new secret named *AZURE_CREDENTIALS_PRODUCTION*, and paste the value for the production environment's service principal from the previous section.

1. Verify that your list of secrets now shows both secrets.

   :::image type="content" source="../media/4-github-create-repository-secrets.png" alt-text="Screenshot of the GitHub interface showing the list of secrets, including both the test and production secrets." border="true":::

## Create environments in GitHub

1. In your browser, go to **Settings** > **Environments**.

1. Select **New environment**.

   :::image type="content" source="../media/4-environments-new.png" alt-text="Screenshot of the GitHub interface that shows the Environments page and the button for creating an environment.":::

1. Enter **Test** as the environment name.

   :::image type="content" source="../media/4-environments-new-details-test.png" alt-text="Screenshot of the GitHub page for a new environment named Test, with the Configure environment button.":::

1. Select **Configure environment**.

1. Select **Environments** to return to the environments list.

   :::image type="content" source="../media/4-environments-new-configure-test.png" alt-text="Screenshot of the GitHub page for a new environment named Test, with the Environment link.":::

1. Repeat the process to create another environment named **Production**.

> [!NOTE]
> In previous modules in this learning path, you added a protection rule to your production environment. In this module, for simplicity, you're skipping the protection rule. However, you can add the protection rule yourself if you'd like.
