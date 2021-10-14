Before you start to work on your toy company's website workflow, you need to configure your environment. In this section, you make sure that your Azure and GitHub environments are set up to complete the rest of this module.

To meet these objectives, you'll:

> [!div class="checklist"]
> * Set up a GitHub repository for this module.
> * Clone the repository to your computer.
> * Create a resource group in Azure.
> * Create a secret in GitHub.

<!-- TODO Note to John: copy pasted quite some steps from https://raw.githubusercontent.com/MicrosoftDocs/learn-pr/5778ea14a752a65b5867bbad505e8f0bdee6bfac/learn-pr/azure/build-first-bicep-deployment-pipeline-using-github-actions/includes/3-exercise-create-run-basic-workflow.md?token=AAH6TAKYJCXSRYZ42ATOVC3BN3BQU (cloning the repo) and https://raw.githubusercontent.com/MicrosoftDocs/learn-pr/5778ea14a752a65b5867bbad505e8f0bdee6bfac/learn-pr/azure/build-first-bicep-deployment-pipeline-using-github-actions/includes/5-exercise-create-github-secret.md?token=AAH6TAIOL7KTZIZDCF76WMTBN3BKK (creating SP and GH secret) -->

## Get the GitHub repository

Here you make sure that your GitHub repository is set up to complete the rest of this module. You set it up by creating a new repository based on a template repository. The template repository contains the files you need to get started for this module. 

The modules in this learning path are part of a progression. For learning purposes, each module has an associated GitHub template repository.

> [!TIP]
> Even if you completed the previous module in the learning path, please follow these instructions to create a new repository and ensure that you give it a new name.

### Start from the template repository

1. In your browser navigate to the [template repo](https://github.com/MicrosoftDocs/mslearn-test-bicep-code-using-github-actions?azure-portal=true).

1. Select **Use this template**. 

   <!-- TODO SS -->

1. Enter a name for your new project, such as *toy-website-workflow*.

1. Select the **Public** checkbox.

1. Select **Create repository from template**. 

   <!-- TODO SS -->

[!include[](../../includes/cleanup-steps.md)]

## Clone the repository

You now have a copy of the template repository in your own account. You will now clone this repository locally so you can start work in it. 

1. Select **Code** > **Local** > **Copy** icon.

   :::image type="content" source="../media/4-repos-files.png" alt-text="Screenshot of Azure DevOps that shows the Repos menu, with Files highlighted.":::

1. Open Visual Studio Code. 

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. Navigate in the terminal to the directory where you want to clone the GitHub repository on your local computer. For example, to clone the repository to the _toy-website-workflow_ folder, run the following command:

   ```bash
   cd toy-website-workflow
   ```

1. Type `git clone` and then paste the URL you copied earlier, which looks something like this:

   ```bash
   git clone https://github.com/mygithubuser/toy-website-workflow
   ```

1. This is the first time you've used this repository, so you are prompted to sign in.

   On Windows, type <kbd>1</kbd> to authenticate using a web browser, and select <kbd>Enter</kbd>.

   On macOS, select **Authorize**.

1. A browser window appears. You may need to sign in to GitHub again. Select **Authorize**.

1. Reopen Visual Studio Code in the repository folder by running the following command:

   ```bash
   code -r toy-website-workflow
   ```

## Sign in to Azure

::: zone pivot="cli"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true) tools.

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

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true).

1. To open a Visual Studio Code terminal window, select **Terminal** > **New Terminal**. The window usually opens at the bottom of your screen.

1. If the dropdown control at the right displays **pwsh** or **PowerShell**, the correct shell is open and you can skip to the next section.

   :::image type="content" source="../../includes/media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with text signifying PowerShell displayed in the dropdown control.":::

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

To create a new resource group, run this Azure CLI command in the Visual Studio Code terminal:

```azurecli
az group create --name ToyWebsiteTest --location westus
```

::: zone-end

::: zone pivot="powershell"

To create a resource group, run this Azure PowerShell command in the Visual Studio Code terminal:

```azurepowershell
New-AzResourceGroup -Name ToyWebsiteTest -Location westus
```

::: zone-end

## Create a service principal and grant it access to the resource group

::: zone pivot="cli"

1. To create a service principal and assign it the Contributor role for your resource group, run the following Azure CLI command in the Visual Studio Code terminal. Replace the placeholder with the resource group ID you copied in the last step.

   ```azurecli
   az ad sp create-for-rbac \
     --name ToyWebsiteWorkflow \
     --role Contributor \
     --scopes RESOURCE_GROUP_ID \
     --sdk-auth
   ```

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

::: zone-end

::: zone pivot="powershell"

1. To create a service principal and assign it the Contributor role for your resource group, run the following Azure PowerShell code in the Visual Studio Code terminal. Replace the placeholder with the resource group ID you copied in the last step.

   ```azurepowershell
   $resourceGroupId = 'RESOURCE_GROUP_ID'

   $azureContext = Get-AzContext
   $servicePrincipal = New-AzADServicePrincipal `
   -DisplayName ToyWebsiteWorkflow `
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

::: zone-end

## Create a GitHub secret

You've created a resource group and a service principal. Next, create a secret in GitHub Actions.

1. In your browser, navigate to your GitHub repository.

1. Select **Settings** > **Secrets**.

1. Select **New repository secret**.

   :::image type="content" source="../../includes/media/github-create-repository-secret.png" alt-text="Screenshot of the GitHub interface showing the 'Secrets' page, with the 'Create repository secret' button highlighted." border="true":::

1. Name the secret *AZURE_CREDENTIALS*.

1. In the **Value** field, paste the JSON object that you copied in the previous section.

1. Select **Add secret**. 

   :::image type="content" source="../../includes/media/github-create-repository-secret-details.png" alt-text="Screenshot of the GitHub interface showing the 'New Secret' page, with the name and value completed and the 'Add secret' button highlighted." border="true":::
