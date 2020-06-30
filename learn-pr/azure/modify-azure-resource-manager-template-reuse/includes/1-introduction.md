Azure Resource Manager templates provide a few features that help with deploying to different environments.

Suppose you are managing a software team that is developing an inventory system for your partner companies. Each environment that the software will be deployed to will have different policies implemented through different Azure Storage Account SKU. You have a Resource Manager template that deploys a Storage Account and can be run on each environment, but you would like it to be easier to to change inputs for each deployment environment. You decide to use variables and functions in template and parameter files for inputs.

In this module, you make your Resource Manager template reusable for different environments by adding variables and expressions using Resource Manager functions. You also add better tracking and organization of your deployed resources using tags and complete the journey to more flexible deployments with parameter files.

## Learning objectives

In this module, you will:

- Create an expression for a unique value using Azure Resource Manager template functions
- Reuse your expression by storing it in an Azure Resource Manager template variable
- Organize and track your deployed Azure resources using resource tags
- Manage multiple deployment parameters using Azure Resource Manager template parameter files

## Prerequisites

- Familiar with Azure including the Azure portal, subscriptions, resource groups, and resource definitions
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally
- The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true) tools installed locally
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally
