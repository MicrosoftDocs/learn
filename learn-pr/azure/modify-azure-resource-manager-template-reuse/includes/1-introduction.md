JSON Azure Resource Manager (ARM) templates provide a few features that can help you deploy software to different environments.

Suppose you're managing a software team that's developing an inventory system for your partner companies. Each environment you deploy software to, has different policies implemented through different Azure storage account SKUs. You have an ARM template that deploys a storage account that can be run on each environment. However, you'd like to make it easier to change inputs for each deployment environment. You decide to use variables and functions in the ARM template and parameter files for inputs.

In this module, you make your ARM template reusable for different environments by adding variables and expressions via Resource Manager functions. You also add better tracking and organization of your deployed resources by using tags. Then, you complete the goal of improving the flexibility of your deployments by using parameter files.

[!INCLUDE [Bicep introduction for JSON modules](../../includes/azure-template-json-bicep-intro.md)]

## Learning objectives

In this module, you'll:

- Create an expression for a unique value by using JSON ARM template functions.
- Reuse your expression by storing it in an ARM template variable.
- Organize and track your deployed Azure resources by using resource tags.
- Manage multiple deployment parameters by using ARM template parameter files.

## Prerequisites

- Familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.
- An Azure account. You can get a free account [here](https://azure.microsoft.com/free?azure-portal=true).
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true), installed locally.
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension, installed locally.
- One of these tools:
  - The latest version of the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true&view=azure-cli-latest&preserve-view=true) tools, installed locally.
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true&view=azps-4.3.0&preserve-view=true), installed locally.