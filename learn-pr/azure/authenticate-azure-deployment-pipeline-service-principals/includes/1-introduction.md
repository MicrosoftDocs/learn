Deployment pipelines need to communicate with Azure so that they can create and configure your Azure resources. In this module, you'll learn how service principals work, how to create and manage them, and how to authorize them to work with Azure on your behalf.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've created a Bicep template to deploy your company's website. Until now, you've been deploying it from your own computer by using command-line tools. You've decided to move the deployment into a pipeline. One of your colleagues has told you that you need to set up a service principal for the deployment pipeline, and you need to understand what this is, and then set it up so you can deploy your company's website.

## What will we be doing?

In this module, you'll create a service principal with a key, ready for your pipeline to use. You'll create a resource group in Azure to contain your company's website, and you'll authorize the service principal to deploy and configure your website's resources.

## What is the main goal?

By the end of this module, you'll have an understanding of service principals and how they relate to other Azure and Azure AD security concepts. You'll be able to create a service principal and manage its keys. You'll also be able to determine the best authorization policy to use for your pipeline's service principal, and configure the appropriate role assignments in Azure.

## Prerequisites

You should be familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resources.

To follow along with the exercises in the module, you'll need either:

- The latest [Azure CLI](/cli/azure/install-azure-cli.md) tools, installed locally.
- The latest [Azure PowerShell](/powershell/azure/install-az-ps.md), installed locally.
