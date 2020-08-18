Deploying Azure Resource Manager (ARM) Templates is the easy part of the equation.  Writing them is the template is the critical part. and you can go over the basics in one of our other Microsoft Learn modules namely [Deploy consistent infrastructure in Azure by using Azure Resource Manager (ARM) templates](https://docs.microsoft.com/learn/modules/create-azure-resource-manager-template-vs-code/?WT.mc_id=MSLearn-ARM-pierrer) and [Deploy to multiple Azure environments by using ARM templates](https://docs.microsoft.com/learn/modules/modify-azure-resource-manager-template-reuse/?WT.mc_id=MSLearn-ARM-pierrer).

Whether you are deploying your templates in your test environment or in productions. The ability to deploying from a web interface or  a command line / terminal is crucial.  This unit will cover the ways to deploy your templates.

1. PowerShell command and/or scripts
1. Azure CLI command and/or scripts
1. Directly in the Azure portal
1. Using Partner tools such as Terraform *(Not covered in this module)*

There will be times where you need to deploy from different locations

1. From a local file
1. From an external or remote location using a Uniform Resource Identifier (URI)

And always with the option of using a parameter file.

So far you've already used some of these deployment commands in other units of this module or in previous modules. But let's drill down a bit deeper in the process.

For every deployment, you need a **deployment name**, if you don't provide a name for the deployment, the name of the template file is used by default. For example, if you deploy a template named azuredeploy.json and don't specify a deployment name, the deployment is named azuredeploy.  However, using unique meaningful deployment names for each deployment provides you with additional simplicity when reviewing deployments and troubleshooting events and  maintain unique entries in the deployment history.  Since every time you run a deployment, an entry is added to the resource group's deployment history with the deployment name. If you run another deployment and give it the same name, the earlier entry is replaced with the current deployment.  Also, when you specify a unique name for each deployment, you can run them concurrently without conflict.

## PowerShell

To use Azure PowerShell with ARM templates to deploy your resources to Azure, there are a few scopes you need to be aware of. Depending on the scope of the deployment, you use different commands. You can target your deployment to a resource group, a subscription, a management group, or a tenant. In most cases, you'll target deployment to a resource group (which will be the focus of this unit).

To apply policies and/or  role assignments across a larger scope, you can target your deployment to subscription, management group, or tenant deployments. When deploying to a subscription, you can create a resource group and deploy resources to it.

1. To deploy to a resource group, use [New-AzResourceGroupDeployment](https://docs.microsoft.com/powershell/module/az.resources/new-azresourcegroupdeployment?view=azps-4.4.0&WT.mc_id=MSLearn-ARM-pierrer)
1. To deploy to a subscription, use [New-AzSubscriptionDeployment](https://docs.microsoft.com/azure/azure-resource-manager/templates/deploy-to-subscription?WT.mc_id=MSLearn-ARM-pierrer)
1. To deploy to a management group, use [New-AzManagementGroupDeployment](https://docs.microsoft.com/powershell/module/az.resources/New-AzManagementGroupDeployment?view=azps-4.4.0&WT.mc_id=MSLearn-ARM-pierrer)
1. To deploy to a tenant, use [New-AzTenantDeployment](https://docs.microsoft.com/powershell/module/az.resources/new-aztenantdeployment?view=azps-4.4.0&WT.mc_id=MSLearn-ARM-pierrer)

to deploy a resource in a resource group

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
