Deployments that use Azure Resource Manager templates (ARM templates) and Bicep files result in a series of changes to your Azure environment. In this module, you learn how to preview changes before you execute a deployment.

## Example scenario

Suppose you help to manage the Azure environment at a toy company. One of your colleagues has asked you to help update some templates that you previously created to deploy a virtual network. Before you deploy your updated template, you want to confirm exactly what changes Azure will make. So you decide to evaluate how to preview changes in your deployments.

## What will we be doing?

In this module, you gain an understanding of the what-if operation for Azure Resource Manager. You also learn about the modes that you can use for your deployments to Azure.

[!INCLUDE [Bicep introduction for JSON modules](../../includes/azure-template-json-bicep-intro.md)]

## What is the main goal?

By the end of this module, you're able to preview changes to your Azure environment before you deploy them by using the what-if operation.

## Prerequisites

You should be familiar with:

- Creating and deploying basic ARM templates, using either Bicep or JSON.
- Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you need:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally.
- Either:
  - The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep) installed locally.
  - The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally.
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true) tools installed locally.
  - The latest [Azure PowerShell](/powershell/azure/install-az-ps?&azure-portal=true) version installed locally.
