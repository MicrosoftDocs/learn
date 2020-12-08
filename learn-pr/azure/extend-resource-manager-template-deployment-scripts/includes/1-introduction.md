Deployment scripts in Azure Resource Manager (ARM) templates enable custom automation for your environment management.

Suppose you're a member of a cross-functional team that supports an application. Your team has adopted ARM templates for creating and managing the environments for your application. Part of the application environment includes staging some assets in a storage account. You've decided to use a deployment script to ensure that the storage account has the required assets.

In this module, you'll learn how to add custom behavior to your ARM templates by using a deployment script.

## Learning objectives

After you finish this module, you'll be able to:

- Perform custom steps in your ARM templates by using a deployment script.
- Define parameters to make your deployment scripts more reusable.

## Prerequisites

- Familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true)
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally
- Either:
  - The latest [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true) tools installed locally
  - The latest [Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-4.3.0&azure-portal=true) version installed locally
