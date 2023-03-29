[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

Before you set up your toy company's pull request workflows, you need to configure your environment.

In this unit, you make sure that your Azure and GitHub environments are set up so that you can complete the rest of this module successfully.

To meet these objectives, you'll:

> [!div class="checklist"]
>
> - Set up a GitHub repository for this module.
> - Clone the repository to your computer.
> - Create a workload identity in Azure Active Directory.
> - Create a secret in GitHub.

## Get the GitHub repository

In this section you set up your GitHub repository to complete the rest of this module. You do so by creating a new repository based on a template repository. The template repository contains the files you need to get started on this module.

The modules in this learning path are part of a progression. For learning purposes, each module has an associated GitHub template repository.

> [!TIP]
> Even if you've already completed the previous module in the learning path, follow these instructions to create a new repository and give it a new name.

### Start from the template repository

Run a template that sets up your GitHub repository.

> [!div class="nextstepaction"]
> [Run the template](https://github.com/MicrosoftDocs/mslearn-automate-azure-infrastructure-change-reviews-using-bicep-github?azure-portal=true)

On the GitHub site, create a repository from the template by doing the following:

1. Select **Use this template** > **Create a new repository**.

   :::image type="content" source="../media/3-template.png" alt-text="Screenshot of the GitHub interface showing the template repo, with the 'Use this template' button highlighted.":::

1. Note the name of your GitHub username or organization. In the example above, the GitHub user name is _mygithubuser_. You'll need this name soon.

1. Enter a name for your new project, such as _toy-website-auto-review_.

1. Select the **Public** option.

   When you create your own repositories, you might want to make them private. In this module, you'll work with some features of GitHub that work only with public repositories and GitHub Enterprise accounts.

1. Select **Create repository from template**.

   :::image type="content" source="../media/3-repo-settings.png" alt-text="Screenshot of the GitHub interface showing the repository creation page.":::

## Clone the repository

You now have a copy of the template repository in your own account. Clone this repository locally so you can start to work in it.

1. Select **Code**, and then select the copy icon.

   :::image type="content" source="../media/3-github-repository-clipboard.png" alt-text="Screenshot of the GitHub interface showing the new repository, with the repository U R L copy button highlighted.":::

1. Open Visual Studio Code.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. In the terminal, go to the directory where you want to clone the GitHub repository on your local computer. For example, to clone the repository to the _toy-website-auto-review_ folder, run the following command:

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

Now that you've cloned the repository locally to your computer, you will sign in to your Azure environment. You'll use your Azure account to create a workload identity for your GitHub Actions workflows to use.

::: zone pivot="cli"

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code terminal, sign in to Azure by running the following command:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a workload identity

Later in this Microsoft Learn module, your pull request workflow will create resource groups and resources in your subscription. To do this, you need to create a workload identity and grant it the Contributor role on your subscription.

> [!WARNING]
> The workload identity that you create here has a high level of access to your Azure subscription. To avoid any accidental issues, use a non-production subscription. Don't execute these steps in an environment that holds any of your production workloads.
>
> In your own pull request validation workflows, we recommend that you use a dedicated Azure subscription.

::: zone pivot="cli"

To create the workload identities, the Azure CLI commands use `jq` to parse data from JSON output. If you don't have `jq` installed, you can use Bash in [Azure Cloud Shell](https://shell.azure.com/) to create the workload identity, resource group and role assignment, and prepare the GitHub secrets.

1. Run the code below to define variables for your GitHub username and your repository name. Ensure that you replace `mygithubuser` with your GitHub username, which you noted earlier in this exercise. Also ensure that you specify the correct GitHub repository name.

   ```bash
   githubOrganizationName='mygithubuser'
   githubRepositoryName='toy-website-auto-review'
   ```

1. Create a workload identity for your deployments workflow.

   ```bash
   applicationRegistrationDetails=$(az ad app create --display-name 'toy-website-auto-review')
   applicationRegistrationObjectId=$(echo $applicationRegistrationDetails | jq -r '.id')
   applicationRegistrationAppId=$(echo $applicationRegistrationDetails | jq -r '.appId')

   az ad app federated-credential create \
      --id $applicationRegistrationObjectId \
      --parameters "{\"name\":\"toy-website-auto-review\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:pull_request\",\"audiences\":[\"api://AzureADTokenExchange\"]}"
   ```

::: zone-end

::: zone pivot="powershell"

1. Run the code below to define variables for your GitHub username and your repository name. Ensure that you replace `mygithubuser` with your GitHub username, which you noted earlier in this exercise. Also ensure that you specify the correct GitHub repository name.

   ```azurepowershell
   $githubOrganizationName = 'mygithubuser'
   $githubRepositoryName = 'toy-website-auto-review'
   ```

1. Create a workload identity for your deployments workflow.

   ```azurepowershell
   $applicationRegistration = New-AzADApplication -DisplayName 'toy-website-auto-review'
   New-AzADAppFederatedCredential `
      -Name 'toy-website-auto-review' `
      -ApplicationObjectId $applicationRegistration.Id `
      -Issuer 'https://token.actions.githubusercontent.com' `
      -Audience 'api://AzureADTokenExchange' `
      -Subject "repo:$($githubOrganizationName)/$($githubRepositoryName):pull_request"
   ```

::: zone-end

## Grant the workload identity access to your subscription

Next, create a resource group for your website. This process also grants the workload identity the Contributor role on the resource group, which allows your workflow to deploy to the resource group.

::: zone pivot="cli"

1. Run the following Azure CLI commands in the Visual Studio Code terminal:

   ```bash
   az ad sp create --id $applicationRegistrationObjectId
   az role assignment create \
      --assignee $applicationRegistrationAppId \
      --role Contributor
   ```

::: zone-end

::: zone pivot="powershell"

1. Run the following Azure PowerShell commands in the Visual Studio Code terminal:

   ```azurepowershell
   New-AzADServicePrincipal -AppId $applicationRegistration.AppId
   New-AzRoleAssignment `
      -ApplicationId $applicationRegistration.AppId `
      -RoleDefinitionName Contributor
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

## Create GitHub secrets

You've created a workload identity, and granted it permission to deploy to the subscription. Next, create secrets in GitHub Actions.

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
