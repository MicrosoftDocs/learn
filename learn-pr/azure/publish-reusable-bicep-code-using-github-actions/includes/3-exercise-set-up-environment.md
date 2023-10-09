[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

Before you start to publish your toy company's reusable Bicep code, you need to configure your environment. In this section, you make sure that your Azure and GitHub environments are set up to complete the rest of this module.

To meet these objectives, you'll:

> [!div class="checklist"]
>
> - Set up a GitHub repository for this module.
> - Clone the repository to your computer.
> - Create a resource group in Azure.
> - Create a secret in GitHub.

## Get the GitHub repository

Here, you create a new GitHub repository based on a template repository. The template repository contains the files that you need to get started for this module.

The modules in this learning path are part of a progression. For learning purposes, each module has an associated GitHub template repository.

> [!TIP]
> Even if you completed the previous module in the learning path, please follow these instructions to create a new repository and ensure that you give it a new name.

### Start from the template repository

Run a template that sets up your GitHub repository.

> [!div class="nextstepaction"]
>
> [Run the template](https://github.com/MicrosoftDocs/mslearn-publish-reusable-bicep-code-using-github-actions)

On the GitHub site, follow these steps to create a repository from the template:

1. Select **Use this template** > **Create a new repository**.

   :::image type="content" source="../media/3-template.png" alt-text="Screenshot of the GitHub interface that shows the template repo, with the button for using the template highlighted.":::

1. For **Owner** select your GitHub account.
1. Enter a **Repository name** for your new project, such as _toy-reusable_.

1. Select the **Public** option.

   When you create your own repositories, you might want to make them private. In this module, you'll use features of GitHub that only work with public repositories and with GitHub Enterprise accounts.

1. Select **Create repository from template**.

   :::image type="content" source="../media/3-repo-settings.png" alt-text="Screenshot of the GitHub interface that shows the repo creation page.":::

[!INCLUDE [](../../includes/cleanup-steps.md)]

## Clone the repository

Now that you have a copy of the template repository in your own account, you'll clone this repository locally so you can start working in it.

1. Select **Code** and select the copy icon.

   :::image type="content" source="../media/3-github-repository-clipboard.png" alt-text="Screenshot of the GitHub interface that shows the new repository, with the repository U R L copy button highlighted.":::

1. Open Visual Studio Code.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. In the terminal, go to the directory where you want to clone the GitHub repository on your local computer. For example, to clone the repository to the _toy-reusable_ folder, run the following command:

   ```bash
   cd toy-reusable
   ```

1. Type `git clone` and then paste the URL that you copied earlier, which looks something like this:

   ```bash
   git clone https://github.com/mygithubuser/toy-reusable.git
   ```

1. Reopen Visual Studio Code in the repository folder by running the following command in the Visual Studio Code terminal:

   ```bash
   code -r toy-reusable
   ```

## Sign in to Azure

::: zone pivot="cli"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli) tools.

[!INCLUDE [](../../includes/azure-exercise-terminal-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps).

[!INCLUDE [](../../includes/azure-exercise-terminal-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a workload identity

Next, create a workload identity in Azure AD for your deployment workflow.

::: zone pivot="cli"

To create the workload identities, the Azure CLI commands use `jq` to parse data from JSON output. If you don't have `jq` installed, you can use Bash in [Azure Cloud Shell](https://shell.azure.com/) to create the workload identity, resource group and role assignment, and prepare the GitHub secrets.

1. Run the following code to define variables for your GitHub username and your repository name. Ensure that you replace `mygithubuser` with your GitHub username, which you noted earlier in this exercise. Also ensure that you specify the correct GitHub repository name.

   ```bash
   githubOrganizationName='mygithubuser'
   githubRepositoryName='toy-reusable'
   ```

1. Create a workload identity for your deployments workflow.

   ```bash
   applicationRegistrationDetails=$(az ad app create --display-name 'toy-reusable')
   applicationRegistrationObjectId=$(echo $applicationRegistrationDetails | jq -r '.id')
   applicationRegistrationAppId=$(echo $applicationRegistrationDetails | jq -r '.appId')

   az ad app federated-credential create \
      --id $applicationRegistrationObjectId \
      --parameters "{\"name\":\"toy-reusable-branch\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:ref:refs/heads/main\",\"audiences\":[\"api://AzureADTokenExchange\"]}"
   ```

::: zone-end

::: zone pivot="powershell"

1. Run the following code to define variables for your GitHub username and your repository name. Ensure that you replace `mygithubuser` with your GitHub username, which you noted earlier in this exercise. Also ensure that you specify the correct GitHub repository name.

   ```azurepowershell
   $githubOrganizationName = 'mygithubuser'
   $githubRepositoryName = 'toy-reusable'
   ```

1. Create a workload identity for your deployments workflow.

   ```azurepowershell
   $applicationRegistration = New-AzADApplication -DisplayName 'toy-reusable'
   New-AzADAppFederatedCredential `
      -Name 'toy-reusable-branch' `
      -ApplicationObjectId $applicationRegistration.Id `
      -Issuer 'https://token.actions.githubusercontent.com' `
      -Audience 'api://AzureADTokenExchange' `
      -Subject "repo:$($githubOrganizationName)/$($githubRepositoryName):ref:refs/heads/main"
   ```

::: zone-end

## Create a resource group in Azure and grant the workload identity access

Next, create a resource group for your website. This process also grants the workload identity the Contributor role on the resource group, which allows your workflow to deploy to the resource group.

::: zone pivot="cli"

Run the following Azure CLI commands in the Visual Studio Code terminal:

```bash
resourceGroupResourceId=$(az group create --name ToyReusable --location westus3 --query id --output tsv)

az ad sp create --id $applicationRegistrationObjectId
az role assignment create \
  --assignee $applicationRegistrationAppId \
  --role Contributor \
  --scope $resourceGroupResourceId
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell commands in the Visual Studio Code terminal:

```azurepowershell
$resourceGroup = New-AzResourceGroup -Name ToyReusable -Location westus3

New-AzADServicePrincipal -AppId $applicationRegistration.AppId
New-AzRoleAssignment `
  -ApplicationId $applicationRegistration.AppId `
  -RoleDefinitionName Contributor `
  -Scope $resourceGroup.ResourceId
```

::: zone-end

## Prepare GitHub secrets

Run the following code to show you the values you need to create as GitHub secrets:

::: zone pivot="cli"

```bash
echo "AZURE_CLIENT_ID: $applicationRegistrationAppId"
echo "AZURE_TENANT_ID: $(az account show --query tenantId --output tsv)"
echo "AZURE_SUBSCRIPTION_ID: $(az account show --query id --output tsv)"
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
$azureContext = Get-AzContext
Write-Host "AZURE_CLIENT_ID: $($applicationRegistration.AppId)"
Write-Host "AZURE_TENANT_ID: $($azureContext.Tenant.Id)"
Write-Host "AZURE_SUBSCRIPTION_ID: $($azureContext.Subscription.Id)"
```

::: zone-end

Make a note of your application ID value for the _AZURE_CLIENT_ID_. You can use that value when you clean up resources when you're finished with this module.

## Create GitHub secrets

You've created a workload identity, and a resource group that it can deploy to. Next, create secrets in GitHub Actions.

1. In your browser, navigate to your GitHub repository.

1. Select **Settings** > **Secrets and variables** > **Actions**.

1. Select **New repository secret**.

   :::image type="content" source="../../includes/media/github-create-repository-secret.png" alt-text="Screenshot of the GitHub interface showing the 'Secrets' page, with the 'Create repository secret' button highlighted." border="true":::

1. Name the secret _AZURE_CLIENT_ID_.

1. In the **Value** field, paste the GUID from the first line of the terminal output. Don't include `AZURE_CLIENT_ID`, the colon, or any spaces in the value.

1. Select **Add secret**.

   :::image type="content" source="../../includes/media/github-create-repository-secret-details.png" alt-text="Screenshot of the GitHub interface showing the 'New Secret' page, with the name and value completed and the 'Add secret' button highlighted." border="true":::

1. Repeat the process to create the secrets for _AZURE_TENANT_ID_ and _AZURE_SUBSCRIPTION_ID_, copying the values from the corresponding fields in the terminal output.

1. Verify that your list of secrets now shows all three secrets.

   :::image type="content" source="../../includes/media/github-create-repository-secrets.png" alt-text="Screenshot of the GitHub interface showing the list of secrets." border="true":::
