Before you can deploy your toy company's website by using a workflow, you need to enable your workflow to authenticate to Azure. In this exercise, you'll:

> [!div class="checklist"]
> * Create a resource group for your website.
> * Create an Azure AD workload identity and grant it access to the resource group.
> * Create GitHub secrets to prepare your workflow to use the workload identity.

This exercise requires that you have permissions to create applications and service principals in your Azure AD directory. If you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant.

[!include[](../../includes/cleanup-steps.md)]

## Sign in to Azure

::: zone pivot="cli"

To work with workload identities in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true) tools.

[!include[](../../includes/azure-exercise-terminal-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true), and sign in to the same account that you used to activate the sandbox.

[!include[](../../includes/azure-exercise-terminal-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a workload identity

> [!NOTE]
> You'll learn more about all of these steps in a future module.

::: zone pivot="cli"

1. TODO assemble subject variables

   ```azurecli
   githubOrganizationName='TODO'
   githubRepositoryName='TODO'
   ```

1. Run the code below, which creates a workload identity:

   ```azurecli
   applicationRegistrationDetails=$(az ad app create --display-name $applicationRegistrationName)
   applicationRegistrationObjectId=$(echo $applicationRegistrationDetails | jq -r '.id')
   applicationRegistrationAppId=$(echo $applicationRegistrationDetails | jq -r '.appId')

   az ad app federated-credential create \
      --id $applicationRegistrationObjectId \
      --parameters "{\"name\":\"$federationName\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:$githubOrganizationName/$githubRepositoryName:ref:refs/heads/main\",\"audiences\":[\"api://AzureADTokenExchange\"]}"
   ```

::: zone-end

::: zone pivot="powershell"

1. TODO assemble subject variables

   ```azurepowershell
   $githubOrganizationName = 'TODO'
   $githubRepositoryName = 'TODO'
   ```

1. Run the code below, which creates a workload identity:

   ```azurepowershell
   $applicationRegistration = New-AzADApplication -DisplayName $applicationRegistrationName

   New-AzADAppFederatedIdentityCredential `
      -Name $federationName `
      -ApplicationObjectId $applicationRegistration.Id `
      -Issuer 'https://token.actions.githubusercontent.com' `
      -Audience 'api://AzureADTokenExchange' `
      -Subject "repo:$githubOrganizationName/$githubRepositoryName:ref:refs/heads/main"
   ```

::: zone-end

## Create a resource group in Azure and grant the workload identity access

::: zone pivot="cli"

To create a new resource group and grant your workload identity access to it, run this Azure CLI command in the Visual Studio Code terminal:

```azurecli
resourceGroupResourceId=$(az group create --name $resourceGroupName --location $resourceGroupLocation --query id --output tsv)

az ad sp create --id $applicationRegistrationObjectId --query id --output tsv
az role assignment create \
   --assignee $applicationRegistrationAppId \
   --role Contributor \
   --scope $resourceGroupResourceId
```

::: zone-end

::: zone pivot="powershell"

To create a resource group and grant your workload identity access to it, run this Azure PowerShell command in the Visual Studio Code terminal:

```azurepowershell
$resourceGroup = New-AzResourceGroup -Name ToyWebsite -Location westus

New-AzADServicePrincipal -AppId $applicationRegistrationAppId
New-AzRoleAssignment `
   -ApplicationId $applicationRegistrationAppId `
   -RoleDefinitionName Contributor `
   -Scope $resourceGroup.ResourceId
```

::: zone-end

## Create GitHub secrets

```azurecli
azureSubscriptionId=$(az account show --query id --output tsv)
azureADTenantId=$(az account show --query tenantId --output tsv)
applicationRegistrationAppId=$(echo $applicationRegistrationDetails | jq -r '.appId')
```
