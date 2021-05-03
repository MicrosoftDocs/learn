Parameters enable you to create flexible and reusable Bicep templates. Define a parameter for any aspect of your deployment that might change, such as environment-specific settings, pricing and capacity configuration for your Azure resources, and API keys to access external systems. Parameters can be secured using parameter decorators and Key Vault references, so that they can handle sensitive data. In this module, you'll learn how parameters can be defined and configured, and how you can specify parameter values during your deployments.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. The Human Resources (HR) department is migrating an on-premises web application to Azure. The application will handle information about all of the employees of the toy company, so security is important.

You have been asked to prepare infrastructure for three environments: dev, test, and production. You should build this using infrastructure as code techniques so that you can reuse the same templates to deploy across environments. You also want to create parameter files that contain input values for each environment, while securely retrieving database credentials from Azure Key Vault.

## What will we be doing?

In this module, you'll build a reusable Bicep template, with parameters. The Bicep will define an App Service plan, an app, and a database in multiple environments.

## What is the main goal?

By the end of this module, you'll be able to:

- Customize parameters, and limit the values that can be used by each parameter.
- Understand the ways that parameters can be passed to a Bicep template.
- Work with secure parameters.

## Prerequisites

- You should be familiar with the basic Bicep template structure and syntax.
- You should have some familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resource definitions.
- You should have an understanding of what infrastructure is code is, and its benefits.

To follow along with the exercises in the module, you'll need:

- [Visual Studio Code](https://code.visualstudio.com) installed locally.
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools installed locally.
  - The latest [Azure PowerShell](/powershell/azure/install-az-ps) installed locally.