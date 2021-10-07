Deployment pipelines enable you to deploy your Azure resources in a repeatable way to multiple environments. When you update your Bicep code, you can use your pipeline to deploy your changes to multiple environments so that you can validate and test your changes, and then use the same process to deploy to your production environment. In this module, you'll learn how to extend a deployment pipeline so it deploys changes to multiple environments in a consistent way. By doing this, you'll build confidence that your environments are configured in the same way, and that your Bicep code changes can be tested in non-production environments before they reach production.

## Example scenario

Suppose you're the Azure administrator at a toy company. You've been working with your website team to create a Bicep template that deploys and configures the Azure resources, and you've recently also been creating a pipeline to deploy the Bicep file automatically.

Your website team is happy with the Azure resources that were created for the first version of your company's website. Now they want to integrate the website with a third-party product review service. The review service enables your customers to submit and view product reviews for your toys. The website team needs to be able to try out the service when they're testing but without submitting real product reviews. They've been given access to a sandbox version of the product review service.

The team has asked you to help them to update their deployment pipeline. They need to deploy their site to a non-production environment that's separate from the production environment that customers use, and they need to use different configuration in each environment.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Diagram showing the solution architecture including the website app and integration with the third-party vendor." border="false":::

## What will you be doing?

In this module, you'll learn how you can extend a pipeline to deploy Bicep code to multiple Azure environments in a consistent way. You'll create separate service connections and service principals for each environment to support higher security and isolation. You'll use pipeline template files to define your deployment steps in a single place, and you'll use Bicep and pipeline template parameters to handle differences between your environments. You'll also secure your parameters so they don't accidentally leak secrets in your pipeline's logs.

## What is the main goal?

After completing this module, you'll be able to update your pipeline to target multiple environments. You'll know how to use pipeline templates to avoid repetition in your definitions, and you'll know how to use parameters for each environment.

## Prerequisites

You should be familiar with using:

- Bicep, including creating and deploying basic files, parameter files, preflight validation, and the what-if operation.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Basic Git commands, including cloning, committing files, and pushing changes to Azure Repos.
- YAML pipelines through Azure Pipelines, including multistage pipelines and service connections.

To work through the exercises in the module, you'll need an Azure account, with the ability to create resource groups, Azure Active Directory applications, and service principals.

You'll also need the following installed locally:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true).
- The [Azure Pipelines extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azure-devops.azure-pipelines).
- The latest [Azure CLI](/cli/azure/install-azure-cli) tools *or* the latest [Azure PowerShell](/powershell/azure/install-az-ps).
- [Git](https://git-scm.com/download?azure-portal=true).