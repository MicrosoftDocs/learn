[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

Before you start to work on your toy company's website workflow, you need to configure your environment. In this unit, you make sure that your Azure and GitHub environments are set up to complete the rest of this module.

To meet these objectives, you'll:

> [!div class="checklist"]
>
> - Set up a GitHub repository for this module.
> - Clone the project's repository to your computer.
> - Create two workload identities in Microsoft Entra ID.
> - Create two resource groups in Azure.
> - Create secrets and environments in GitHub.

## Get the GitHub repository

Here you make sure that your GitHub repository is set up to complete the rest of this module. You set it up by creating a new repository based on a template repository. The template repository contains the files you need to get started for this module.

The modules in this learning path are part of a progression. For learning purposes, each module has an associated GitHub template repository.

> [!TIP]
> Even if you completed the previous module in the learning path, please follow these instructions to create a new repository and ensure that you give it a new name.

### Start from the template repository

Run a template that sets up your GitHub repository.

> [!div class="nextstepaction"]
> [Run the template](https://github.com/MicrosoftDocs/mslearn-manage-end-end-deployment-scenarios-using-bicep-github-actions)

On the GitHub site, follow these steps to create a repository from the template:

1. Select **Use this template** > **Create a new repository**.

   :::image type="content" source="../media/4-template.png" alt-text="Screenshot of the GitHub interface showing the template repo, with the 'Use this template' button highlighted.":::

1. Select your GitHub username from the **Owner** drop-down list.

1. Enter a repository name for your new project, such as _toy-website-end-to-end_.

1. Select the **Public** option.

   When you create your own repositories, you might want to make them private. In this module, you'll work with some features of GitHub that only work with public repositories and with GitHub Enterprise accounts.

1. Select **Create repository from template**.

   :::image type="content" source="../media/4-repo-settings.png" alt-text="Screenshot of the GitHub interface showing the repo creation page.":::

[!INCLUDE [](../../includes/cleanup-steps.md)]

## Clone the repository

You now have a copy of the template repository in your own account. You'll now clone this repository locally so you can start work in it.

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

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli) tools.

[!INCLUDE [](../../includes/azure-exercise-terminal-cli.md)]

### Sign in to Azure by using Azure CLI

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

## Create two workload identities

Next, create two workload identities in Microsoft Entra ID: one for your test environment and another for your production environment.

::: zone pivot="cli"

1. Run the following code to define variables for your GitHub username and your repository name. Ensure that you replace `mygithubuser` with your GitHub username, which you noted earlier in this exercise. Also ensure that you specify the correct GitHub repository name.

   ```bash
   githubOrganizationName='mygithubuser'
   githubRepositoryName='toy-website-end-to-end'
   ```

1. Create a workload identity for deployments to your test environment. The workload identity needs two federated credentials: one is used when the workflow runs the _validate_ job, because this job isn't associated with a GitHub environment. The second is used when the workflow runs the _deploy_ job, which runs against the _Test_ GitHub environment.

   ```bash
   testApplicationRegistrationDetails=$(az ad app create --display-name 'toy-website-end-to-end-test')
   testApplicationRegistrationObjectId=$(echo $testApplicationRegistrationDetails | jq -r '.id')
   testApplicationRegistrationAppId=$(echo $testApplicationRegistrationDetails | jq -r '.appId')

   az ad app federated-credential create \
      --id $testApplicationRegistrationObjectId \
      --parameters "{\"name\":\"toy-website-end-to-end-test\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:environment:Test\",\"audiences\":[\"api://AzureADTokenExchange\"]}"

   az ad app federated-credential create \
      --id $testApplicationRegistrationObjectId \
      --parameters "{\"name\":\"toy-website-end-to-end-test-branch\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:ref:refs/heads/main\",\"audiences\":[\"api://AzureADTokenExchange\"]}"
   ```

1. Run the following code, which creates a similar workload identity and federated credentials for the production environment:

   ```bash
   productionApplicationRegistrationDetails=$(az ad app create --display-name 'toy-website-end-to-end-production')
   productionApplicationRegistrationObjectId=$(echo $productionApplicationRegistrationDetails | jq -r '.id')
   productionApplicationRegistrationAppId=$(echo $productionApplicationRegistrationDetails | jq -r '.appId')

   az ad app federated-credential create \
      --id $productionApplicationRegistrationObjectId \
      --parameters "{\"name\":\"toy-website-end-to-end-production\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:environment:Production\",\"audiences\":[\"api://AzureADTokenExchange\"]}"

   az ad app federated-credential create \
      --id $productionApplicationRegistrationObjectId \
      --parameters "{\"name\":\"toy-website-end-to-end-production-branch\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:ref:refs/heads/main\",\"audiences\":[\"api://AzureADTokenExchange\"]}"
   ```

::: zone-end

::: zone pivot="powershell"

1. Run the following code to define variables for your GitHub username and your repository name. Ensure that you replace `mygithubuser` with your GitHub username, which you noted earlier in this exercise. Also ensure that you specify the correct GitHub repository name.

   ```azurepowershell
   $githubOrganizationName = 'mygithubuser'
   $githubRepositoryName = 'toy-website-end-to-end'
   ```

1. Run the following code, which creates a workload identity for the test environment and associates it with your GitHub repository:

   ```azurepowershell
   $testApplicationRegistration = New-AzADApplication -DisplayName 'toy-website-end-to-end-test'
   New-AzADAppFederatedCredential `
      -Name 'toy-website-end-to-end-test' `
      -ApplicationObjectId $testApplicationRegistration.Id `
      -Issuer 'https://token.actions.githubusercontent.com' `
      -Audience 'api://AzureADTokenExchange' `
      -Subject "repo:$($githubOrganizationName)/$($githubRepositoryName):environment:Test"
   New-AzADAppFederatedCredential `
      -Name 'toy-website-end-to-end-test-branch' `
      -ApplicationObjectId $testApplicationRegistration.Id `
      -Issuer 'https://token.actions.githubusercontent.com' `
      -Audience 'api://AzureADTokenExchange' `
      -Subject "repo:$($githubOrganizationName)/$($githubRepositoryName):ref:refs/heads/main"
   ```

1. Run the following code, which follows a similar process for the production environment:

   ```azurepowershell
   $productionApplicationRegistration = New-AzADApplication -DisplayName 'toy-website-end-to-end-production'
   New-AzADAppFederatedCredential `
      -Name 'toy-website-end-to-end-production' `
      -ApplicationObjectId $productionApplicationRegistration.Id `
      -Issuer 'https://token.actions.githubusercontent.com' `
      -Audience 'api://AzureADTokenExchange' `
      -Subject "repo:$($githubOrganizationName)/$($githubRepositoryName):environment:Production"
   New-AzADAppFederatedCredential `
      -Name 'toy-website-end-to-end-production-branch' `
      -ApplicationObjectId $productionApplicationRegistration.Id `
      -Issuer 'https://token.actions.githubusercontent.com' `
      -Audience 'api://AzureADTokenExchange' `
      -Subject "repo:$($githubOrganizationName)/$($githubRepositoryName):ref:refs/heads/main"
   ```

::: zone-end

## Create two resource groups in Azure and grant the workload identity access

Next, create a resource group for each environment. This process also grants the respective workload identity the Contributor role on the resource group, which allows your workflow to deploy to the resource group.

::: zone pivot="cli"

1. To create the test environment's resource group and grant the workload identity access to it, run the following Azure CLI commands in the Visual Studio Code terminal:

   ```bash
   testResourceGroupResourceId=$(az group create --name ToyWebsiteTest --location westus3 --query id --output tsv)

   az ad sp create --id $testApplicationRegistrationObjectId
   az role assignment create \
      --assignee $testApplicationRegistrationAppId \
      --role Contributor \
      --scope $testResourceGroupResourceId
   ```

1. Run a similar process to create the production environment's resource group:

   ```bash
   productionResourceGroupResourceId=$(az group create --name ToyWebsiteProduction --location westus3 --query id --output tsv)

   az ad sp create --id $productionApplicationRegistrationObjectId
   az role assignment create \
      --assignee $productionApplicationRegistrationAppId \
      --role Contributor \
      --scope $productionResourceGroupResourceId
   ```

::: zone-end

::: zone pivot="powershell"

1. To create the test environment's resource group and grant the workload identity access to it, run the following Azure PowerShell commands in the Visual Studio Code terminal:

   ```azurepowershell
   $testResourceGroup = New-AzResourceGroup -Name ToyWebsiteTest -Location westus3

   New-AzADServicePrincipal -AppId $($testApplicationRegistration.AppId)
   New-AzRoleAssignment `
      -ApplicationId $($testApplicationRegistration.AppId) `
      -RoleDefinitionName Contributor `
      -Scope $($testResourceGroup.ResourceId)
   ```

1. Run a similar process to create the production environment's resource group:

   ```azurepowershell
   $productionResourceGroup = New-AzResourceGroup -Name ToyWebsiteProduction -Location westus3

   New-AzADServicePrincipal -AppId $($productionApplicationRegistration.AppId)
   New-AzRoleAssignment `
      -ApplicationId $($productionApplicationRegistration.AppId) `
      -RoleDefinitionName Contributor `
      -Scope $($productionResourceGroup.ResourceId)
   ```

::: zone-end

## Prepare GitHub secrets

Run the following code to output the values you need to create as GitHub secrets:

::: zone pivot="cli"

```bash
echo "AZURE_CLIENT_ID_TEST: $testApplicationRegistrationAppId"
echo "AZURE_CLIENT_ID_PRODUCTION: $productionApplicationRegistrationAppId"
echo "AZURE_TENANT_ID: $(az account show --query tenantId --output tsv)"
echo "AZURE_SUBSCRIPTION_ID: $(az account show --query id --output tsv)"
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
$azureContext = Get-AzContext
Write-Host "AZURE_CLIENT_ID_TEST: $($testApplicationRegistration.AppId)"
Write-Host "AZURE_CLIENT_ID_PRODUCTION: $($productionApplicationRegistration.AppId)"
Write-Host "AZURE_TENANT_ID: $($azureContext.Tenant.Id)"
Write-Host "AZURE_SUBSCRIPTION_ID: $($azureContext.Subscription.Id)"
```

::: zone-end

## Create GitHub secrets

You've created two workload identities, and resource groups that they can deploy to. Next, create secrets in GitHub Actions.

1. In your browser, navigate to your GitHub repository.

1. Select **Settings** > **Secrets** > **Actions**.

1. Select **New repository secret**.

   :::image type="content" source="../../includes/media/github-create-repository-secret.png" alt-text="Screenshot of the GitHub interface showing the 'Secrets' page, with the 'Create repository secret' button highlighted." border="true":::

1. Name the secret _AZURE_CLIENT_ID_TEST_.

1. In the **Value** field, paste the GUID from the first line of the terminal output. Don't include `AZURE_CLIENT_ID_TEST`, the colon, or any spaces in the value.

1. Select **Add secret**.

   :::image type="content" source="../../includes/media/github-create-repository-secret-details-test-environment.png" alt-text="Screenshot of the GitHub interface showing the 'New Secret' page, with the name and value completed and the 'Add secret' button highlighted." border="true":::

1. Repeat the process to create the secrets for _AZURE_CLIENT_ID_PRODUCTION_, _AZURE_TENANT_ID_, and _AZURE_SUBSCRIPTION_ID_, copying the values from the corresponding fields in the terminal output.

1. Verify that your list of secrets now shows all four secrets.

   :::image type="content" source="../../includes/media/github-create-repository-secrets-environments.png" alt-text="Screenshot of the GitHub interface showing the list of secrets, including both the test and production secrets." border="true":::

## Create environments in GitHub

1. In your browser, go to **Settings** > **Environments**.

1. Select **New environment**.

   :::image type="content" source="../media/4-environments-new.png" alt-text="Screenshot of the GitHub interface that shows the Environments page and the button for creating an environment.":::

1. Enter _Test_ as the environment name.

   :::image type="content" source="../media/4-environments-new-details-test.png" alt-text="Screenshot of the GitHub page for a new environment named Test, with the Configure environment button.":::

1. Select **Configure environment**.

1. Select **Environments** to return to the environments list.

   :::image type="content" source="../media/4-environments-new-configure-test.png" alt-text="Screenshot of the GitHub page for a new environment named Test, with the Environment link.":::

1. Repeat the process to create another environment named _Production_.

> [!NOTE]
> In previous modules in this learning path, you added a protection rule to your production environment. In this module, for simplicity, you're skipping the protection rule. However, you can add the protection rule yourself if you'd like.
