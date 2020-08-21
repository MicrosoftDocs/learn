Deploying Azure Resource Manager (ARM) Templates is the easy part of the equation.  Writing them is the template is the harder part, you can go over the basics in one of the other Microsoft Learn modules namely:
* [Deploy consistent infrastructure in Azure by using Azure Resource Manager (ARM) templates](https://docs.microsoft.com/learn/modules/create-azure-resource-manager-template-vs-code/?WT.mc_id=MSLearn-ARM-pierrer)
* and [Deploy to multiple Azure environments by using ARM templates](https://docs.microsoft.com/learn/modules/modify-azure-resource-manager-template-reuse/?WT.mc_id=MSLearn-ARM-pierrer).

Whether you are deploying your templates in your test environment or in production, the ability to deploy from the Azure shell web interface or a command line/terminal using native or partner tools is crucial. This unit will cover the ways to deploy your templates.

1. PowerShell command and/or scripts
1. Azure CLI command and/or scripts
1. Directly in the Azure portal
1. Using GitHub Actions

There will be times where you need to deploy from different locations

1. From a local file
1. From an external or remote location using a Uniform Resource Identifier (URI)

And always with the option of using a parameter file.

So far you've already used some of these deployment commands in the other units of this module, or in previous modules. But let's drill down a bit deeper in the process.

When you deploy a template, you need to specify a resource group that will contain the resources. Before running the deployment command, create the resource group with either Azure CLI or Azure PowerShell. You'll also need to give a name to the deployment so you can easily identify it in the deployment history. If you don't provide a name for the deployment, the name of the template file is used by default. For example, if you deploy a template named azuredeploy.json and don't specify a deployment name, the deployment is named azuredeploy.  For convenience, also create a variable that stores the path to the template file. This variable makes it easier for you to run the deployment commands because you don't have to retype the path every time you deploy.

As you may have learned in the [Deploy to multiple Azure environments by using ARM templates](https://docs.microsoft.com/learn/modules/modify-azure-resource-manager-template-reuse/?WT.mc_id=MSLearn-ARM-pierrer) module. You can use ARM template parameter file to holds values that will be passed in to the ARM template when the template is deployed or pass the parameters as part of the command itself as Inline parameters.  Inline parameters can be well suited for automated deployments as part of scripted environment where the parameters will be programmatically generated.

## PowerShell

When using Azure PowerShell to deploy your resources to Azure with ARM templates, there are a few scopes you need to be aware of. Depending on the scope of the deployment, you use different commands to target your deployment.

* To deploy to a resource group, use [New-AzResourceGroupDeployment](https://docs.microsoft.com/powershell/module/az.resources/new-azresourcegroupdeployment?view=azps-4.4.0&WT.mc_id=MSLearn-ARM-pierrer)
* To deploy to a subscription, use [New-AzSubscriptionDeployment](https://docs.microsoft.com/azure/azure-resource-manager/templates/deploy-to-subscription?WT.mc_id=MSLearn-ARM-pierrer)
* To deploy to a management group, use [New-AzManagementGroupDeployment](https://docs.microsoft.com/powershell/module/az.resources/New-AzManagementGroupDeployment?view=azps-4.4.0&WT.mc_id=MSLearn-ARM-pierrer)
* To deploy to a tenant, use [New-AzTenantDeployment](https://docs.microsoft.com/powershell/module/az.resources/new-aztenantdeployment?view=azps-4.4.0&WT.mc_id=MSLearn-ARM-pierrer)

In the majority of cases, you'll target deployment to a resource group (which will be the focus of this unit).  However, when you need to apply policies and/or role assignments across a larger scope, you can target your deployment to subscription, management group, or tenant deployments.

## Azure CLI

The same deployment scopes exist for an Azure CLI deployment

1. To deploy to a resource group, use [az deployment group create](https://docs.microsoft.com/cli/azure/deployment/group?view=azure-cli-latest&WT.mc_id=MSLearn-ARM-pierrer#az-deployment-group-create)
1. To deploy to a subscription, use [az deployment sub create](https://docs.microsoft.com/cli/azure/deployment/sub?view=azure-cli-latest&WT.mc_id=MSLearn-ARM-pierrer#az-deployment-sub-create)
1. To deploy to a management group, use [az deployment mg create](https://docs.microsoft.com/cli/azure/deployment/mg?view=azure-cli-latest&WT.mc_id=MSLearn-ARM-pierrer#az-deployment-mg-create)
1. To deploy to a tenant, use [az deployment tenant create](https://docs.microsoft.com/cli/azure/deployment/tenant?view=azure-cli-latest&WT.mc_id=MSLearn-ARM-pierrer#az-deployment-tenant-create)

## Portal

You see several options for deploying resources using a template in the Azure portal.

1. Build your own template in editor: create a template using the portal template editor. The editor is capable to add a resource template schema
1. Common templates: There are four common templates for creating a Linux virtual machine, Windows virtual machine, a web application, and a database in Azure SQL Database
1. Load a [GitHub quickstart template](https://azure.microsoft.com/resources/templates/?WT.mc_id=MSLearn-ARM-pierrer)

:::image type="content" source="../media/4-portal-options.png" alt-text="Azure portal template deployment options." border="true":::
