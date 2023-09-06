JSON Azure Resource Manager templates (ARM templates) allow you to specify your project's infrastructure in a declarative and reusable way. You can version and save the templates in the same source control as your development project.

Suppose you're managing a software team that's developing an inventory system for your partner companies. You plan to deploy this product to Azure, and each partner company will have its own solution. Different policies for each deployment will be implemented through different Azure storage accounts. You decide to use the practice of *infrastructure as code* by using ARM templates. This approach lets you track the different versions and ensure that your infrastructure deployments for each environment are consistent and flexible.

In this module, we'll introduce you to ARM template structure. You'll also practice creating and deploying an ARM template to Azure.

[!INCLUDE [Bicep introduction for JSON modules](../../includes/azure-template-json-bicep-intro.md)]

## Learning objectives

In this module, you will:

- Implement an JSON ARM template by using Visual Studio Code.
- Declare resources and add flexibility to your template by adding parameters and outputs.

## Prerequisites

- Familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions
- An Azure account. You can get a free account [here](https://azure.microsoft.com/free?azure-portal=true)
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally.
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true&view=azure-cli-latest) tools installed locally
  - The latest [Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true&view=azps-4.3.0) installed locally
