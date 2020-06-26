Microsoft Azure Resource Manager templates allow you to specify your project's infrastructure in a declarative and reusable way. The templates can be versioned and saved in the same source control as your development project.

Suppose you are managing a software team that is developing an inventory system for your partner companies. This product is going to be deployed to Azure and each partner company will have their own solution. Each environment that the software will be deployed to will have different policies implemented through different Azure Storage Account SKU. You decide to use the practice of *Infrastructure as Code* using Resource Manager templates to ensure that your infrastructure deployments for each environment will be consistent, flexible, and that the versions can be tracked.

In this module, you are introduced to Azure Resource Manager template structure and you practice creating and deploying a template to Azure.

## Learning objectives

In this module, you:

- Implement an Azure Resource Manager template by using Visual Studio Code
- Declare resources and add flexibility to your template by adding resources, parameters, and outputs

## Prerequisites

- Familiar with Azure including the Azure portal, subscriptions, resource groups, and resource definitions
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally
- The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true) tools installed locally
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally
