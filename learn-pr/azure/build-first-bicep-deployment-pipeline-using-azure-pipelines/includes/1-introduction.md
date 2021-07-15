By automating Bicep deployments through Azure Pipelines, you can create a flexible and reusable process for propagating your changes to your Azure environment. Your pipeline will enforce the process you specify to ensure the quality of your deployments and environment. A deployment pipeline also ensures the same process is used by everyone who collaborates on your Bicep files. In this module, you'll learn how to define an Azure DevOps pipeline, and how to deploy your Bicep code by using the pipeline.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've built a Bicep template to deploy your company's website. Every time you need to reconfigure the website you update your Bicep files and redeploy them from your computer. Your website team is asking for changes regularly so the deployment process has become time-consuming, and you want to find a way to automate the process so that you can spend your time on more important things.

You also want to enable your colleagues to make changes to the Bicep templates and deploy them, but you want to ensure they follow the same process as you. You decide to create a deployment pipeline, which will run automatically every time the Bicep code is updated in your shared repository. It will deploy your Bicep files to Azure.

:::image type="content" source="../media/1-workflow.png" alt-text="Diagram that shows a change to a Bicep file, which is pushed to Azure Repos. This then automatically triggers a pipeline, which deploys to Azure." border="false":::

## What will you be doing?

In this module, you'll learn how you can automate the deployment of Bicep templates with Azure Pipelines. You'll understand the benefits of using pipelines to deploy your code, and you'll learn how to build a basic pipeline that deploys a Bicep file. Along the way, you'll learn how to give your pipeline the necessary authorization to deploy to an Azure resource group, and how to configure when the pipeline runs.

## What is the main goal?

After completing this module, you'll be able to create a pipeline in Azure Pipelines that deploys a basic Bicep file to an Azure resource group.

## Prerequisites

You should be familiar with:

- Creating and deploying basic Bicep files.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Service principals.
- Basic Git commands, including cloning, committing files, and pushing changes to Azure Repos.

To follow along with the exercises in the module, you'll need the following installed locally:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
- The [Bicep extension for Visual Studio code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true).
- The [Azure Pipelines extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azure-devops.azure-pipelines&azure-portal=true).
- [Git](https://git-scm.com/download?azure-portal=true)