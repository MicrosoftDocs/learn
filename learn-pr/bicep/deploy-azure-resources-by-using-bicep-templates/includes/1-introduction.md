Bicep enables you define your Azure resources in a simple language, and use templates to deploy the resources to Azure. You can reuse your templates across multiple environments or applications.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your company is launching a new toy. You've been asked to deploy a new marketing website in preparation for the launch of the new product. The marketing team has also told you that there will be many new toys released this year, and they will need a website for each one.

You will host the website in Azure using App Service, and you also will need a storage account to host large files like the manuals and specifications for each toy. You decide to build the resources using Infrastructure as Code (IaC) techniques so that you can reuse the template for future product launches.

## What will we be doing?

In this module, you'll create a template using Bicep to deploy a set of Azure resources for this and future product launches, and use many elements of the Bicep language in the process:

- Resource definitions, to deploy your Azure resources from your Bicep code.
- Parameters, to make your template reusable.
- Variables and expressions, to make it easier to write and deploy your template.
- Modules, to help to structure your template into multiple files.
- Outputs, to send data from your template and modules back to whoever or whatever is deploying your infrastructure.

## What is the main goal?

By the end of this module, you'll be able to create Bicep templates that define your Azure resources. You'll be able to use parameters, variables, and expressions to make your templates reusable. You'll also be able to use modules and outputs to organize your templates into separate files.

## Prerequisites

- You should have an understanding of what Infrastructure is Code (IaC) is, and its benefits.
- You should have some familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you'll need:

- An Azure account. You can get a free account [here](https://azure.microsoft.com/free).
- [Visual Studio Code](https://code.visualstudio.com) installed locally.
- Either:
  - The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli) tools installed locally.
  - The latest [Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps) installed locally.
