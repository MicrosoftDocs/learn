Template specs provide a way to create and manage reusable Azure Resource Manager templates (ARM templates). After you write and test your ARM templates, you can use template specs to share them throughout your organization. By building a library of template specs, you can ensure that Azure resources are configured the way you intended when they're deployed.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your Azure environment is maturing. Lots of people from lots of teams come to you to provision and configure new Azure infrastructure for them to use. 

Everyone trusts you to provision the infrastructure correctly and in a way that follows your company's policies. It's great that they trust you so much, but this means you're spending all your time deploying templates. And your company's use of Azure is growing, so your workload is going to keep increasing.

You built a comprehensive set of templates that you use to deploy your company's Azure infrastructure. Each template configures its resources to follow your company's guidelines. At the moment, your templates are all stored on your own computer, and you email them to colleagues who need them. You feel like there must be a way to share these templates with your organization so you can get back to other things.

## What will we be doing?

In this module, you learn about template specs and the benefits they provide. In the exercises, you create, publish, and deploy a template spec, including as a part of another deployment. Finally, you learn how to manage template specs, including how to safely update them by using versions.

## What is the main goal?

By the end of this module, you're able to create, publish, deploy, and manage template specs.

## Prerequisites

You should be familiar with:

- Creating and deploying basic ARM templates by using either Bicep or JSON.
- Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you need the following items installed locally:

- [Visual Studio Code](https://code.visualstudio.com)
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps)
- Either:
  - The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep)
  - The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension
