Child and extension resources allow your Azure deployments to access the advanced functionality and power of the Azure platform. You can create these resource types in Bicep by using a clear and understandable template syntax. 

You can also use Bicep to refer to resources that were created outside the Bicep file itself. For example, you can refer to resources that your colleagues have created manually by using the Azure portal, or from within another Bicep template or module, even if they're in a different resource group or subscription. By using these features of Bicep, you can unlock the ability to create powerful templates that deploy all aspects of your Azure infrastructure.

## Example scenario

Suppose you're responsible for deploying and configuring Azure infrastructure at a toy company. Your company's R&D department has contacted you because they're working on a new toy drone that sprays glitter over unsuspecting targets. R&D team members are starting to test the drone, and they'll be collecting telemetry about the distance the drone can fly, the amount of glitter it can spray, and the battery level. 

They've asked you to set up a new Azure Cosmos DB database for storing this valuable and highly sensitive product test data. They need you to log all database-access attempts so that they can feel confident that no competitors are accessing the data.

They've already created a storage account to store all their product design documents, and they've asked you to help audit all attempts to access them.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram showing how logs are sent from the new Azure Cosmos DB account and the storage account to the Log Analytics workspace." border="false":::

## What will we be doing?

In this module, you'll learn about Azure resource types, and how child and extension resources are used throughout Azure. You'll create a Bicep template that deploys a set of Azure resources. You'll use several features of Bicep, including:

- Child resource definitions, through nested resources, the `parent` property, and by constructing multipart resource names.
- Extension resource definitions, by using the `scope` property.
- Existing resource references, by using the `existing` keyword.

## What is the main goal?

By the end of this module, you'll be able to create Bicep templates that include child and extension resources. You'll also be able to create Bicep templates that refer to preexisting Azure resources that have been created outside the template file.

## Prerequisites

You should be familiar with:

- Creating and deploying basic Bicep templates.
- Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you'll need:

- [Visual Studio Code](https://code.visualstudio.com), installed locally.
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), installed.
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools, installed locally.
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps), installed locally.
