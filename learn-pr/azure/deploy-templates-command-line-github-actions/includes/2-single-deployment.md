Whether you're deploying your templates in your test environment or in production, the ability to deploy from Azure Cloud Shell or the command line is crucial. This unit covers the following ways to deploy your templates:

* Azure PowerShell
* Azure CLI
* GitHub Actions

You'll sometimes need to deploy from different locations. For example:

* From a local file
* From an external or remote location by using a Uniform Resource Identifier (URI)

Both methods include the option of using a parameter file.

When you deploy a template, you need to specify a resource group that contains the resources. Before you run the deployment command, create the resource group by using either the Azure CLI or Azure PowerShell.

You also need to give a name to the deployment so you can easily identify it in the deployment history. If you don't provide a name for the deployment, the name of the template file is used by default. For example, if you deploy a template named *azuredeploy.json* and don't specify a deployment name, the deployment is named **azuredeploy**.

For convenience, you can also create a variable that stores the path to the template file. This variable makes it easier for you to run the deployment commands because you don't have to specify the path every time you deploy.

As you might have learned in the [Deploy to multiple Azure environments by using ARM template features](https://docs.microsoft.com/learn/modules/modify-azure-resource-manager-template-reuse/?) module, you can use an ARM template parameter file to hold values that will be passed in to the ARM template when the template is deployed. Or you can pass the parameters as part of the command itself as inline parameters. Inline parameters can be well suited for automated deployments as part of a scripted environment where the parameters will be programmatically generated.

## Azure PowerShell

When you're using Azure PowerShell to deploy your resources to Azure with ARM templates, you need to be aware of a few scopes. Depending on the scope of the deployment, you use different commands to target your deployment:

* To deploy to a resource group, use [New-AzResourceGroupDeployment](https://docs.microsoft.com/powershell/module/az.resources/new-azresourcegroupdeployment?view=azps-4.4.0&azure-portal=true).
* To deploy to a subscription, use [New-AzSubscriptionDeployment](https://docs.microsoft.com/azure/azure-resource-manager/templates/deploy-to-subscription?azure-portal=true).
* To deploy to a management group, use [New-AzManagementGroupDeployment](https://docs.microsoft.com/powershell/module/az.resources/New-AzManagementGroupDeployment?view=azps-4.4.0&azure-portal=true).
* To deploy to a tenant, use [New-AzTenantDeployment](https://docs.microsoft.com/powershell/module/az.resources/new-aztenantdeployment?view=azps-4.4.0&azure-portal=true).

In the majority of cases, you target your deployment to a resource group (which will be the focus of this module). When you need to apply policies or role assignments across a larger scope, you can target your deployment to a subscription, management group, or tenant.

## Azure CLI

The same deployment scopes exist for an Azure CLI deployment:

* To deploy to a resource group, use [az deployment group create](https://docs.microsoft.com/cli/azure/deployment/group?view=azure-cli-latest&azure-portal=true#az-deployment-group-create).
* To deploy to a subscription, use [az deployment sub create](https://docs.microsoft.com/cli/azure/deployment/sub?view=azure-cli-latest&azure-portal=true#az-deployment-sub-create).
* To deploy to a management group, use [az deployment mg create](https://docs.microsoft.com/cli/azure/deployment/mg?view=azure-cli-latest&azure-portal=true#az-deployment-mg-create).
* To deploy to a tenant, use [az deployment tenant create](https://docs.microsoft.com/cli/azure/deployment/tenant?view=azure-cli-latest&azure-portal=true#az-deployment-tenant-create).