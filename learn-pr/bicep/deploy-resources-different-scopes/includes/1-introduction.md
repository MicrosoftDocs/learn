Some Azure resources are deployed outside of resource groups, and are instead deployed to subscriptions, management groups, and even to your whole tenant. Bicep enables you to create and configure Azure resources at these scopes. By using Bicep to deploy these kinds of resources, you'll gain the benefits of using infrastructure as code across your full portfolio of Azure resources and configuration.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your R&D team is designing a new toy as part of a top-secret project called Project Teddybear. They have asked you to create a dedicated Azure subscription for them to work within so that the rest of the company won't accidentally see any information about their project.

They plan to use virtual machines within the subscription, but to save money they have asked for your help to ensure that only certain SKUs of virtual machines can be created within that subscription. They also need your assistance to create a virtual network in the subscription, because they will eventually need to connect that network to the main corporate network, which you help to manage.

You know the R&D team has recently been given a lot of new funding, so they're likely to have more secret projects in the future. You decide to create reusable templates for each of their special projects.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Diagram that shows an Azure subscription, a policy, and a resource group containing a virtual network." border="false":::

## What will we be doing?

In this module, you'll learn about the different scopes that Azure resources can be deployed at, and some of the common resources that are deployed outside of resource groups. You'll create a Bicep file that deploys to a subscription and a resource group. In the process, you'll learn about several features of Bicep, including:

- How to set the scope of a Bicep file by using the `targetScope` keyword.
- How to use modules to deploy to different scopes within one deployment.
- How to target specific scopes by using the `resourceGroup()`, `subscription()`, `managementGroup()`, and `tenant()` functions.

## What is the main goal?

By the end of this module, you'll be able to create Bicep templates that deploy at the subscription, management group, and tenant scopes. You'll also be able to create and use Bicep files that deploy across multiple scopes in a single deployment.

## Prerequisites

- Familiarity with creating and deploying Bicep templates.
- Understanding of child and extension resources.
- Familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.

> [!NOTE]
> In this module, you'll build on your knowledge of extension resources. If you need a refresher, see **Deploy child and extension resources by using Bicep**.

<!-- TODO add link once that module is published -->

To follow along with the exercises in the module, you'll need:

- An Azure account, with the ability to create subscription-level resources. For one exercise, you'll need to be able to create management groups and policies, but this is an optional exercise.
- [Visual Studio Code](https://code.visualstudio.com) installed locally.
- The [Bicep extension for Visual Studio code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep) installed.
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools installed locally.
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps) installed locally.
    