Before you set up your toy company's pull request workflows, you need to configure your environment. In this unit, you make sure that your Azure and GitHub environments are set up to complete the rest of this module.

To meet these objectives, you'll:

> [!div class="checklist"]
> * Set up a GitHub repository for this module.
> * Clone the repository to your computer.
> * Create a service principal in Azure Active Directory.
> * Create a secret in GitHub.

## Get the GitHub repository

Here you make sure that your GitHub repository is set up to complete the rest of this module. You set it up by creating a new repository based on a template repository. The template repository contains the files you need to get started for this module. 

The modules in this learning path are part of a progression. For learning purposes, each module has an associated GitHub template repository.

> [!TIP]
> Even if you completed the previous module in the learning path, please follow these instructions to create a new repository and ensure that you give it a new name.

### Start from the template repository

Run a template that sets up your GitHub repository.

> [!div class="nextstepaction"]
> [Run the template](https://github.com/MicrosoftDocs/mslearn-automate-azure-infrastructure-change-reviews-using-bicep-github?azure-portal=true)

On the GitHub site, follow these steps to create a repository from the template:

1. Select **Use this template**. 

   :::image type="content" source="../media/3-template.png" alt-text="Screenshot of the GitHub interface showing the template repo, with the 'Use this template' button highlighted.":::

1. Enter a name for your new project, such as *toy-website-auto-review*.

1. Select the **Public** option.

   When you create your own repositories, you might want to make them private. In this module, you'll work with some features of GitHub that only work with public repositories and with GitHub Enterprise accounts.

1. Select **Create repository from template**. 

   :::image type="content" source="../media/3-repo-settings.png" alt-text="Screenshot of the GitHub interface showing the repo creation page.":::

## Clone the repository

You now have a copy of the template repository in your own account. You'll now clone this repository locally so you can start work in it. 

1. Select **Code** and select the copy icon.

   :::image type="content" source="../media/3-github-repository-clipboard.png" alt-text="Screenshot of the GitHub interface showing the new repository, with the repository U R L copy button highlighted.":::

1. Open Visual Studio Code. 

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. Navigate in the terminal to the directory where you want to clone the GitHub repository on your local computer. For example, to clone the repository to the *toy-website-auto-review* folder, run the following command:

   ```bash
   cd toy-website-auto-review
   ```

1. Type `git clone` and then paste the URL you copied earlier, which looks something like this:

   ```bash
   git clone https://github.com/mygithubuser/toy-website-auto-review.git
   ```

1. Reopen Visual Studio Code in the repository folder by running the following command in the Visual Studio Code terminal:

   ```bash
   code -r toy-website-auto-review
   ```

## Sign in to Azure

Now that you've cloned the repository locally to your computer, you will sign in to your Azure environment. You'll use your Azure account to create a service principal for your GitHub Actions workflows to use.

::: zone pivot="cli"

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a service principal

Later in this Microsoft Learn module, your pull request workflow will create resource groups and resources in your subscription. To do this, you need to create a service principal and grant it the Contributor role on your subscription.

> [!WARNING]
> The service principal you create here will have a high level of access to your Azure subscription. To avoid any accidental issues, use a non-production subscription. Don't execute these steps in an environment that holds any of your production workloads.

::: zone pivot="cli"

1. Run the following Azure CLI command to find your Azure subscription ID.

   ```azurecli
   az account show --query id --output tsv
   ```

   Copy your Azure subscription ID to your clipboard.

1. To create a service principal and assign it the Contributor role for your subascription, run the following Azure CLI command in the Visual Studio Code terminal. Replace the `SUBSCRIPTION_ID` placeholder with the subscription ID you copied in the last step.

   ```azurecli
   az ad sp create-for-rbac \
     --name ToyWebsiteAutoReview \
     --role Contributor \
     --scopes '/subscriptions/SUBSCRIPTION_ID' \
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

::: zone-end

::: zone pivot="powershell"

1. To create a service principal and assign it the Contributor role for your subscription, run the following Azure PowerShell command in the Visual Studio Code terminal.

   ```azurepowershell
   $azureContext = Get-AzContext
   $subscriptionId = "/subscriptions/$($azureContext.Subscription.Id)"
   $servicePrincipal = New-AzADServicePrincipal `
     -DisplayName ToyWebsiteAutoReview `
     -Role Contributor `
     -Scope $subscriptionId

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

You've created a  service principal. Next, create a secret in GitHub Actions.

1. In your browser, navigate to your GitHub repository.

1. Select **Settings** > **Secrets** > **Actions**.

1. Select **New repository secret**.

   :::image type="content" source="../../includes/media/github-create-repository-secret.png" alt-text="Screenshot of the GitHub interface showing the 'Secrets' page, with the 'Create repository secret' button highlighted." border="true":::

1. Name the secret *AZURE_CREDENTIALS*.

1. In the **Value** field, paste the JSON object that you copied in the previous section.

1. Select **Add secret**. 

   :::image type="content" source="../../includes/media/github-create-repository-secret-details.png" alt-text="Screenshot of the GitHub interface showing the 'New Secret' page, with the name and value completed and the 'Add secret' button highlighted." border="true":::
