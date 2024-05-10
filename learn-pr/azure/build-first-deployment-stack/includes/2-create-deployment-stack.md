An Azure deployment stack is a type of Azure resource that enables you to manage the lifecycle of a collection of Azure resources as a single atomic unit, even if they span multiple resource groups or subscriptions. It allows for consistent and repeatable deployments, simplifies management, and enables efficient scaling and updating of resources.

In this unit, you'll learn how to create a deployment stack, verify its deployment, and list all deployment stacks in your environment.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

# Title and graphic

Insert title and graphic here.

## Define resources

Deployment stacks support the use of Bicep files, ARM JSON templates, or template specs for defining resources in a stack. When deploying a deployment stack using the Azure CLI or Azure PowerShell, you're able to point to the specific template file (bicep file or ARM JSON template) or template spec. It isn't necessary to change how you define your resources.

We will use the bicep file below for our first deployment stack. The file defines an app service plan and a web app. These resources become managed resources when we create the deployment stack.

```bicep
// Parameters
@description('The name of the app service plan.')
param appServicePlanName string = 'plan-deposits'

@description('The location for all resources.')
param location string = 'eastus'

@description('The name of the web application')
param webApplicationName string = 'webapp-deposits-${uniqueString(resourceGroup().id)}'

// Resource - App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

// Resource - Web App
resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: webApplicationName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}
```

## Creating a deployment stack

Creating and deploying a deployment stack and its resources is nearly identical to a standard Azure deployment. Whether you are using AZ CLI, Azure PowerShell, or an infrastructure as code pipeline, the process feels the same. For example:

The AZ CLI command to deploy a bicep file to a resource group is `az deployment group create -n myResourceGroup -f main.bicep` while the command to create a deployment stack at the resource group scope is `as stack group create -n myDeploymentStack -g myResourceGroup -f main.bicep`.

Notice that the only change in the command is from `deployment` to `stack`. The same is true for deployments to subscriptions and management groups. In later modules, we will explore how to manage resources in a deployment stack and how to configure deny settings.

Lets take a look at creating a deployment stack at the resource group scope.

::: zone pivot="cli"

To create a deployment stack using AZ CLI, use the `az stack group create` command. The commands below first create a resource group called `rg-depositsApplication` then creates the deployment stack at the scope of the resource group.

```azurecli
az group create --name rg-depositsApplication --location eastus

az stack group create --name stack-deposits --resource-group rg-depositsApplication --template-file ./main.bicep
```

::: zone-end

::: zone pivot="powershell"

To create a deployment stack using AZ CLI, use the `New-AzResourceGroupDeploymentStack` command. The commands below first create a resource group called `rg-depositsApplication` then creates the deployment stack at the scope of the resource group.

```azurepowershell
New-AzResourceGroup -Name rg-depositsApplication -Location eastus

New-AzResourceGroupDeploymentStack -Name demoStack -ResourceGroupName rg-depositsApplication -TemplateFile ./main.bicep
```

::: zone-end

## Verifying the deployment

Insert text here.

## View the list of existing deployment stacks

Insert text here.
