Microsoft Azure Resource Manager templates (ARM templates) allow you to specify your project's infrastructure in a declarative and reusable way. The templates can be versioned and saved in the same source control as your development project.

Suppose you are managing a software team that is developing an inventory system for your partner companies. You plan to deploy this product to Azure, and each partner company will have their own solution. Different policies for each deployment will be implemented through different Azure storage accounts. You decide to use the practice of *Infrastructure as Code* by using ARM templates. This approach lets you track the different versions and ensure that your infrastructure deployments for each environment are consistent and flexible.

In this module, you're introduced to the ARM template structure. You also practice the creation and deployment of an ARM template to Azure.

## Learning objectives

In this module, you:

- Use Visual Studio Code to create an Azure Resource Manager template
- Learn how to introduce flexibilty to your ARM template by adding resources, parameters, and outputs

## Prerequisites

- Familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions
- An Azure account. You can get a free account [here](https://azure.microsoft.com/free?azure-portal=true).
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally
- Either:
  - The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true) tools installed locally
  - The latest [Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.3.0&azure-portal=true) installed locally
