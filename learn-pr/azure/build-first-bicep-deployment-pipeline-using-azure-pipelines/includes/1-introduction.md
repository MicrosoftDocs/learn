By automating Bicep deployments through Azure pipelines you can create a flexible and reusable process for propagating your Infrastructure as Code changes to your Azure environment. Your pipeline will enforce the process that is needed when a Bicep template needs to be deployed to Azure. It will also make sure this same process is used by all people collaborating on your Bicep templates. In this module, you'll learn how to define and configure an Azure DevOps pipeline, and how you can give it access to a specific resource group in Azure to deploy your Bicep templates. 


## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've built a Bicep template to deploy your company's website. Every time you need to reconfigure the website you update your Bicep files and redeploy them from your computer. Your website team is asking for changes regularly so the deployment process has become time-consuming, and you want to find a way to automate the process so that you can spend your time on more important things.

You also want to enable your colleagues to make changes to the Bicep templates and deploy them, but you want to ensure they follow the same process as you.

## What will you be doing?

In this module, you'll learn how you can automate the deployment of Bicep templates with Azure DevOps. You'll understand the purpose of Azure DevOps as part of the automation process. You'll find answers to these questions: 

- How can pipelines help in automating deployments to Azure.
- How can pipelines be build by using different types of task steps. 
- How can we securely give an Azure DevOps pipeline task access to a resource group in Azure.
- How can we automatically trigger deployment when there are changes to a Bicep file.


## What is the main goal?

After completing this module, you'll be able to create a first pipeline in Azure DevOps that deploys a basic Bicep template to an Azure resource group.

## Prerequisites

You should have:

  - Familiarity with basic Bicep template deployments.
  - Familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resources.

To follow along with the exercises in the module, you'll need:

- [Visual Studio Code](https://code.visualstudio.com) installed locally.
- The [Azure Pipelines extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azure-devops.azure-pipelines) installed
