Deployment pipelines enable you to deploy your Azure resources in a repeatable way to multiple environments. When update your Bicep code, you can use your pipeline to deploy your changes to multiple environments so that you can validate and test your changes, and then use the same process to deploy to your production environment. In this module, you'll learn how to extend a deployment pipeline so it deploys changes to multiple environments in a consistent way. By doing this, you'll build confidence that your environments are configured in the same way, and that your Bicep code changes can be tested in non-production environments before they reach production.

## Example scenario

Suppose you're the Azure administrator at a toy company. You've been working with your website team to create a Bicep template that deploys and configures the Azure resources, and you've recently also been creating a pipeline to deploy the Bicep file automatically.

Your website team is happy with the Azure resources that were created for the first version of your company's website. Now they want to keep iterating on the website, trying out additional components and changing the settings of their resources. But they don't want all of their changes to affect the production environment customers are using. They've asked you to help them to update the deployment pipeline so that it safely deploys their changes to a non-production environment, and then lets them decide whether to deploy their changes to their production environment.

<!-- TODO architecture diagram showing non-prod and prod -->

## What will you be doing?

In this module, you'll learn how you can extend a pipeline to deploy Bicep code to multiple Azure environments in a consistent way. You'll create separate service connections and service principals for each environment to support higher security and isolation. You'll use pipeline template files to define your deployment steps in a single place, and you'll use Bicep and pipeline template parameters to handle differences between your environments. You'll also secure your parameters so they don't accidentally leak secrets in your pipeline's logs.

## What is the main goal?

After completing this module, you'll be able to update your pipeline to target multiple environments. You'll know how to use pipeline templates to avoid repetition in your definitions, and you'll know how to use parameters for each environment.

## Prerequisites

You should have: 

  - Familiarity with basic Bicep template deployments.
  - Familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resources.
  - Familiarity with basic Git commands, including cloning, committing files, and pushing changes to Azure Repos.
  - Familiarity with basic YAML pipelines, and basic experience deploying Bicep code using Azure Pipelines.

To follow along with the exercises in the module, you'll need:

- [Visual Studio Code](https://code.visualstudio.com) installed locally.
- The [Azure Pipelines extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azure-devops.azure-pipelines) installed
- Azure account and subscription
- Git
