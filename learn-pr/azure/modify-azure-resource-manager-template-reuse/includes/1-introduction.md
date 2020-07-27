Azure Resource Manager (ARM) templates provide a few features that help with deploying to different environments.

Suppose you are managing a software team that is developing an inventory system for your partner companies. Each environment that the software will be deployed to will have different policies implemented through different Azure Storage Account SKU. You have an ARM template that deploys a Storage Account and can be run on each environment, but you would like it to be easier to change inputs for each deployment environment. You decide to use variables and functions in the ARM template and parameter files for inputs.

In this module, you make your ARM template reusable for different environments by adding variables and expressions using Resource Manager functions. You also add better tracking and organization of your deployed resources using tags and complete the journey to more flexible deployments with parameter files.

## Learning objectives

In this module, you will:

- Create an expression for a unique value using ARM template functions
- Reuse your expression by storing it in an ARM template variable
- Organize and track your deployed Azure resources using resource tags
- Manage multiple deployment parameters using ARM template parameter files

## Prerequisites

- Familiar with Azure including the Azure portal, subscriptions, resource groups, and resource definitions
- An Azure account. You can get a free account [here](https://azure.microsoft.com/free?azure-portal=true).
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally
- Either:
  - The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true) tools installed locally
  - The latest [Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.3.0&azure-portal=true) installed locally
