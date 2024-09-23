Some Azure resources are deployed outside resource groups, and are instead deployed at various _scopes_: a subscription, a management group, or even your whole tenant. By using Bicep, you can create and configure Azure resources at each of these scopes, and you'll gain the benefits of using infrastructure as code across your full portfolio of Azure resources.

## Example scenario

Suppose you're responsible for deploying and configuring Azure infrastructure at a toy company. Your R&D team is designing a new toy as part of a top-secret project called Project Teddybear. The team has asked you to create a dedicated Azure subscription to help prevent the project information from accidentally being exposed to the rest of the company.

The R&D team plans to use virtual machines within the subscription, but to save money, the team has asked for your help to ensure that only certain virtual machine SKUs can be created within that subscription. The team also needs your assistance to create a virtual network in the subscription, because that network will eventually need to connect to the main corporate network, which you help to manage.

Here's a diagram that shows how these components fit within their Azure subscription:

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Diagram that shows an Azure subscription, a policy, and a resource group containing a virtual network." border="false":::

You know the R&D team has recently been given a lot of new funding, so it's likely to have more secret projects in the future. You decide to create reusable templates for each of its special projects.

## What will we be doing?

In this module, you'll learn about the various scopes to which Azure resources can be deployed and some of the common resources that are deployed outside resource groups. You'll create a Bicep file to deploy to a subscription and a resource group. You'll also create a Bicep file to deploy to a management group. In the process, you'll learn about several features of Bicep, including how to:

- Set the scope of a Bicep file by using the `targetScope` keyword.
- Use modules and the `scope` keyword to deploy your resources to various scopes within a single deployment.
- Target specific scopes by using the `resourceGroup()`, `subscription()`, `managementGroup()`, and `tenant()` functions.

## What is the main goal?

By the end of this module, you'll be able to create Bicep templates that you can deploy at the subscription, management group, and tenant scopes. You'll also be able to create and use Bicep files to deploy across multiple scopes in a single deployment.

## Prerequisites

You should be familiar with:

- Creating and deploying basic Bicep templates.
- Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.
- Child and extension resources.

> [!NOTE]
> In this module, you'll build on your knowledge of extension resources. If you need a refresher, see [Deploy child and extension resources by using Bicep](xref:learn.azure.child-extension-bicep-templates).

To follow along with the exercises in the module, you'll need:

- An Azure account, with the ability to create subscription-level resources. For one exercise, which is optional, you'll need to be able to create management groups and policies.
  > [!TIP]
  > If you can't meet these requirements with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant.
- [Visual Studio Code](https://code.visualstudio.com), installed locally.  
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), installed locally.  
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools, installed locally.  
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps), installed locally.
