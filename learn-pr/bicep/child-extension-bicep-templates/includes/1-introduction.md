Child and extension resources allow your Azure deployments to access advanced functionality and power of the Azure platform. You can create these resource types in Bicep by using a clear and understandable template syntax. You can also use Bicep to refer to resources created outside of the Bicep file itself, such as resources that your colleagues have created manually using the Azure portal, or from within a different Bicep template or module - even if they're in a different resource group or subscription. By using these features of Bicep, you'll unlock the ability to create powerful templates that deploy all aspects of your Azure infrastructure.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your company's R&D department has contacted you because they're working on a new toy drone that will spray glitter over unsuspecting targets. The R&D team are starting to test the drone, and they will be collecting telemetry about the distance the drone can fly, the amount of glitter it can spray, and the battery level. They have asked you to provision a new Cosmos DB database for them to store this valuable and highly sensitive product test data. They need you to log all access attempts to the database so that they can feel confident that no competitors are accessing the data.

They also told you that last week they created a storage account to store all of their product design documents. They've asked for your help to audit all access attempts to the product design documents as well.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram that shows a new Cosmos DB account, database and container, an existing storage account, an existing Log Analytics workspace, and new diagnostic settings to send logs from the Cosmos DB account and storage account to the Log Analytics workspace." border="false":::

## What will we be doing?

In this module, you'll learn about Azure's resource types, and how child and extension resources are used throughout Azure. You'll then create a Bicep template that deploys a set of Azure resources. You'll use several features of Bicep, including:

- Child resource definitions, through nested resources, the `parent` property, and by constructing multi-part resource names.
- Extension resource definitions, by using the `scope` property.
- Existing resource references, by using the `existing` keyword.

## What is the main goal?

By the end of this module, you'll be able to create Bicep templates that include child and extension resources. You'll also be able to create Bicep templates that refer to pre-existing Azure resources that have been created outside of the template file.

## Prerequisites

- You should have familiarity with creating and deploying Bicep templates.
- You should have some familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

To follow along with the exercises in the module, you'll need:

- [Visual Studio Code](https://code.visualstudio.com) installed locally.
- The [Bicep extension for Visual Studio code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep) installed.
- Either:
  - The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli) tools installed locally.
  - The latest version of [Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps) installed locally.
