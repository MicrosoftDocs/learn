Deployments using Azure Resource Manager templates (ARM templates) and Bicep files result in a series of changes to your Azure environment. In this module, you learn how to review the changes that will happen before you execute a deployment.

## Example scenario

You're on a software team that's authoring these templates for the company Tailwind Traders. You plan to deploy the described infrastructure in the templates. As you author these templates, it's important that you're aware of any issues before deployment. You've had problems in the past with deploying something other than what you think you're deploying, so you decide to evaluate how to preview changes in your deployments.

## What will we be doing?

In this module, you gain an understanding of the what-if operation for Azure Resource Manager. You also learn about the modes you can use for your deployments to Azure.

> [!NOTE]
> Bicep is a new language for defining your Azure resources. It has a simpler authoring experience than JSON, as well as other features that help improve the quality of your infrastructure as code. We recommend that anyone new to infrastructure as code on Azure use Bicep instead of JSON. To learn about Bicep, see [Introduction to infrastructure as code using Bicep](/learn/modules/introduction-to-infrastructure-as-code-using-bicep/).

## What is the main goal?

By the end of this module, you'll be able to preview the changes that will happen before you deploy by using the what-if operation.

## Prerequisites

You should have familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you'll need:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally.
- Either:
  - The [Bicep extension for Visual Studio code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), installed locally.
  - The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally.
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true&preserve-view=true) tools installed locally
  - The latest [Azure PowerShell](/powershell/azure/install-az-ps?view=azps-4.3.0&azure-portal=true&preserve-view=true) version installed locally
