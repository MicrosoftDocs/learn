Sometimes, your Bicep code isn't deployed directly. Instead, you might intend for it to be *reused* in multiple deployments. Azure template specs enable you to create reusable deployments for complete solutions, and Bicep modules and registries enable you to create components that you can add to other Bicep deployments.

Publishing reusable Bicep code comes with different concerns than normal Bicep deployments. In this Microsoft Learn module, you'll learn how you can automate the validation and publishing of your template specs and Bicep modules.

## Example scenario

Suppose you're the Azure administrator at a toy company. Your company's use of Azure is expanding, and they've introduced a new cloud governance approach to ensure that your deployments follow Microsoft's recommended practices for security and reliability.

To make it easy for your colleagues, you've created a set of security-hardened Bicep files. Some of the files deploy complete solutions that your colleagues need. Other files define sets of resources that your colleagues can use within their own Bicep deployments.

You've previously used GitHub Actions to automate the deployment of your Azure resources. Now, you want to find a way to automate the validation and publishing of your reusable Bicep code, too.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Diagram that shows two GitHub Actions workflows. One publishes a complete Bicep file to a template spec, and the other published a module to a Bicep registry.":::

## What will we be doing?

In this module, you'll learn about the differences between deploying Azure resources and reusable Bicep code from a deployment workflow. You'll learn how your workflow securely identifies itself so that it can publish your code, and you'll learn how code validation and versioning can be performed within an automated deployment process.

You'll also create GitHub Actions workflows to publish two Bicep files: one as a template spec, and another as a module to a private Bicep registry.

## What is the main goal?

After you complete this module, you'll be able to publish reusable Azure template specs and Bicep modules from your deployment workflows.

## Prerequisites

You should be familiar with using:

- Bicep modules and module registries.
- Azure template specs.
- Testing Bicep code, including linting.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Basic Git commands, including cloning, committing files, and pushing changes to GitHub.
- GitHub Actions, including jobs, steps, and secrets.

> [!TIP]
> If you need a refresher on Bicep modules, registries, or template specs, take a look at these Microsoft Learn modules:
> - [Create composable Bicep files by using modules](xref:learn.azure.create-composable-bicep-files-using-modules)
> - [Share Bicep modules by using private registries](xref:learn.azure.share-bicep-modules-using-private-registries)
> - [Publish libraries of reusable infrastructure code by using template specs](xref:learn.azure.arm-template-specs)

To work through the exercises in the module, you'll need:

- An Azure account, with the ability to create resource groups, Azure Active Directory applications, and service principals.
- A GitHub account.

You'll also need the following installed locally:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true)
- The latest [Azure CLI](/cli/azure/install-azure-cli) tools *or* the latest [Azure PowerShell](/powershell/azure/install-az-ps) version
- [Git](https://git-scm.com/download?azure-portal=true)
