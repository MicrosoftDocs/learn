Before you can deploy your toy company's website by using a workflow, you need to enable your workflow to authenticate to Azure. In this exercise, you'll:

> [!div class="checklist"]
>
> - Create a resource group for your website.
> - Create a Microsoft Entra Workload ID and grant it access to the resource group.
> - Create GitHub secrets to prepare your workflow to use the workload identity.

This exercise requires that you have permissions to create applications in your Microsoft Entra directory. If you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/) and create a new Azure subscription and tenant.

[!INCLUDE [](../../includes/cleanup-steps.md)]

## Sign in to Azure

::: zone pivot="cli"

To work with workload identities in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli) tools.

[!INCLUDE [](../../includes/azure-exercise-terminal-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps), and sign in to the same account that you used to activate the sandbox.

[!INCLUDE [](../../includes/azure-exercise-terminal-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a workload identity

> [!TIP]
> In this module, you'll create a workload identity for your workflow to use. The module [Authenticate your Azure deployment workflow by using workload identities](xref:learn.azure.authenticate-azure-deployment-workflow-workload-identities) provides a more detailed explanation of workload identities including how they work, as well as how you create them, assign them roles, and manage them.

::: zone pivot="cli"

To create the workload identity, the Azure CLI commands use `jq` to parse data from JSON output. If you don't have `jq` installed, you can use Bash in [Azure Cloud Shell](https://shell.azure.com/) to create the workload identity, resource group and role assignment, and prepare the GitHub secrets.

1. Run the following code to define variables for your GitHub username and your repository name. Ensure that you replace `mygithubuser` with your GitHub username, which you noted in the previous exercise unit.

   ```bash
   githubOrganizationName='mygithubuser'
   githubRepositoryName='toy-website-workflow'
   ```

1. Run the following code, which creates a workload identity and associates it with your GitHub repository:

   ```bash
   applicationRegistrationDetails=$(az ad app create --display-name 'toy-website-workflow')
   applicationRegistrationObjectId=$(echo $applicationRegistrationDetails | jq -r '.id')
   applicationRegistrationAppId=$(echo $applicationRegistrationDetails | jq -r '.appId')

   az ad app federated-credential create \
      --id $applicationRegistrationObjectId \
      --parameters "{\"name\":\"toy-website-workflow\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:ref:refs/heads/main\",\"audiences\":[\"api://AzureADTokenExchange\"]}"
   ```

::: zone-end

::: zone pivot="powershell"

1. Run the following code to define variables for your GitHub username and your repository name. Ensure that you replace `mygithubuser` with your GitHub username, which you noted in the previous exercise unit.

   ```azurepowershell
   $githubOrganizationName = 'mygithubuser'
   $githubRepositoryName = 'toy-website-workflow'
   ```

1. Run the following code, which creates a workload identity and associates it with your GitHub repository:

   ```azurepowershell
   $applicationRegistration = New-AzADApplication -DisplayName 'toy-website-workflow'

   New-AzADAppFederatedCredential `
      -Name 'toy-website-workflow' `
      -ApplicationObjectId $applicationRegistration.Id `
      -Issuer 'https://token.actions.githubusercontent.com' `
      -Audience 'api://AzureADTokenExchange' `
      -Subject "repo:$($githubOrganizationName)/$($githubRepositoryName):ref:refs/heads/main"
   ```

::: zone-end

## Create a resource group in Azure and grant the workload identity access

::: zone pivot="cli"

To create a new resource group and grant your workload identity access to it, run this Azure CLI command in the Visual Studio Code terminal:

```bash
resourceGroupResourceId=$(az group create --name ToyWebsite --location westus3 --query id --output tsv)

az ad sp create --id $applicationRegistrationObjectId
az role assignment create \
   --assignee $applicationRegistrationAppId \
   --role Contributor \
   --scope $resourceGroupResourceId
```

::: zone-end

::: zone pivot="powershell"

To create a resource group and grant your workload identity access to it, run this Azure PowerShell command in the Visual Studio Code terminal:

```azurepowershell
$resourceGroup = New-AzResourceGroup -Name ToyWebsite -Location westus3

New-AzADServicePrincipal -AppId $applicationRegistration.AppId
New-AzRoleAssignment `
   -ApplicationId $($applicationRegistration.AppId) `
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

## Create GitHub secrets

You've created a resource group and a workload identity. Next, create some secrets in GitHub Actions so that your workflow can sign in by using the workload identity.

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
