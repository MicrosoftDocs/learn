Template specs provide a way to create and manage reusable Azure Resource Manager template (ARM templates). Once you write and test your ARM templates, you can use template specs to share them throughout your organization. By building up a library of template specs, you can ensure that when people deploy their Azure resources, they are configured the way you want them to be.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your Azure environment is maturing, and you've got lots of people from lots of teams who come to you to provision and configure new Azure infrastructure for them to use. Everyone trusts you to provision the infrastructure correctly and so that it follows your company's policies. It's great that they trust you so much, but this means you're spending all your time deploying templates. And your company's use of Azure is growing, so your workload is going to keep increasing.

You've built up quite a comprehensive set of templates that you use to deploy your company's Azure infrastructure, and each template configures its resources so they follow your company's guidelines. At the moment, your templates are all stored on your own computer and you email them to colleagues who need them. You feel like there must be a way to share these templates with your organization so you can get back to other things.

## What will we be doing?

In this module, you'll learn about template specs. You'll find out what template specs are and the benefits they provide. You'll also create and publish a template spec, and you'll learn how to deploy it - including as a part of another deployment. Finally, you'll learn about how you can manage template specs, including how to safely update template specs by using versions.

## What is the main goal?

By the end of this module, you'll be able to create, publish, deploy, and manage template specs.

## Prerequisites

You should be familiar with:

- Creating and deploying basic ARM templates, using either Bicep or JSON.
- Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you'll need:

- [Visual Studio Code](https://code.visualstudio.com), installed locally.
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli.md) tools, installed locally.
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps.md), installed locally.
- Either:
  - The [Bicep extension for Visual Studio code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), installed.
  - The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally.
