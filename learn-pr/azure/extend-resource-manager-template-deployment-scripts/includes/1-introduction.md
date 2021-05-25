Deployment scripts in Azure Resource Manager (ARM) templates enable custom automation for your environment management.

Suppose you're a member of a cross-functional team that supports an application. Your team has adopted ARM templates for creating and managing the environments for your application. Part of the application environment includes staging some assets in a storage account. You've decided to use a deployment script to ensure that the storage account has the required assets.

In this module, you'll learn how to add custom behavior to your Bicep or JSON ARM templates by using a deployment script.

> [!NOTE]
> Bicep is a new language for defining your Azure resources. It has a simpler authoring experience than JSON, as well as other features that help improve the quality of your infrastructure as code. We recommend that anyone new to infrastructure as code on Azure use Bicep instead of JSON. To learn about Bicep, see [Introduction to infrastructure as code using Bicep](/learn/modules/introduction-to-infrastructure-as-code-using-bicep/).

## Learning objectives

After you finish this module, you'll be able to:

- Perform custom steps in your ARM templates by using a deployment script.
- Define parameters to make your deployment scripts more reusable.

## Prerequisites

You should have familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you'll need:
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true).
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally.
- Either:
  - The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), installed locally.
  - The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension, installed locally.
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true&preserve-view=true) tools installed locally.
  - The latest [Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true) version installed locally.
