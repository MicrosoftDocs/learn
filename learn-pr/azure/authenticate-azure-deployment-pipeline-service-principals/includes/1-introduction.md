Deployment pipelines need to communicate with Azure, so they can create and configure your Azure resources. In this module, you'll learn how service principals work, how to create and manage them, and how to authorize them to work with Azure on your behalf.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've created a Bicep template to deploy your company's website. Until now, you've been deploying it from your own computer by using command-line tools. You've decided to move the deployment into a pipeline. 

One of your colleagues has told you that you'll need to set up a service principal for the deployment pipeline. You need to understand what this is, and then set it up so you can deploy your company's website.

## What will we be doing?

In this module, you'll create a service principal with a key, ready for your pipeline to use. You'll create a resource group in Azure to contain your company's website, and you'll authorize the service principal to deploy and configure your website's resources.

> [!NOTE]
> The information in this Microsoft Learn module is specific to Azure Pipelines. If you use GitHub Actions, the way your deployment workflows authenticate is different. To learn more about GitHub Actions and deployment authorization, see [Authenticate your Azure deployment workflow by using workload identities](xref:learn.azure.authenticate-azure-deployment-workflow-workload-identities).

## What is the main goal?

By the end of this module, you'll have an understanding of service principals and how they relate to other Azure and Microsoft Entra security concepts. You'll be able to create a service principal and manage its keys. You'll also be able to determine the best authorization policy to use for your pipeline's service principal, and configure the appropriate role assignments in Azure.

## Prerequisites

You should be familiar with:

- Creating and deploying basic Bicep templates, including modules.
- Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you'll need:

- An Azure account, with the ability to create resource groups and to create Microsoft Entra applications and service principals.
  > [!TIP]
  > If you can't meet these requirements with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant.
- [Visual Studio Code](https://code.visualstudio.com), installed locally.  
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), installed locally.  
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools, installed locally.  
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps), installed locally.
