Deployment scripts in Azure Resource Manager templates (ARM templates) enable custom automation for your environment management. You use deployment scripts to execute your own scripts within your ARM template deployments.

## Example scenario

Suppose you're a member of a cross-functional team that supports an application. Your team has adopted ARM templates for creating and managing the environments for your application. Part of the application environment includes staging some assets in a storage account. You've decided to use a deployment script to ensure that the storage account has the required assets.

## What will we be doing?

In this module, you'll learn how to add custom behavior to your Bicep or JSON ARM templates by using a deployment script.

[!INCLUDE [Bicep introduction for JSON modules](../../includes/azure-template-json-bicep-intro.md)]

## What is the main goal?

By the end of this module, you'll be able to perform custom steps in your ARM templates by using a deployment script. You'll also be able to define parameters to make your deployment scripts more reusable.

## Prerequisites

You should be familiar with:

- Creating and deploying basic ARM templates, using either Bicep or JSON.
- Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you'll need:

- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true).
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally.
- Either:
  - The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), installed locally.
  - The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension, installed locally.
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true) tools installed locally.
  - The latest [Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true) version installed locally.
