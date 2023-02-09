You can use Azure Pipelines to automate Bicep deployments. Azure Pipelines provides a flexible and reusable process to propagate changes to your Azure environment. A pipeline enforces the process that you set to ensure the quality of your deployments and of your Azure environment. A deployment pipeline also ensures that everyone who collaborates on your Bicep files uses the same process. In this module, you'll learn how to define a pipeline in Azure Pipelines and how to deploy your Bicep code by using the pipeline.

> [!NOTE]
> If you're interested in using GitHub Actions instead of Azure Pipelines to deploy infrastructure to Azure, see [Build your first Bicep deployment workflow by using GitHub Actions](/training/modules/build-first-bicep-deployment-pipeline-using-github-actions/). If you need help deciding, see [Compare and contrast GitHub Actions and Azure Pipelines](/dotnet/architecture/devops-for-aspnet-developers/actions-vs-pipelines).

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure to support a website at a toy company. You've built a Bicep template to deploy the website. Every time you need to reconfigure the website, you update your Bicep files and redeploy them from your computer. The website team asks for changes regularly, so the deployment process has become time-consuming. You want to find a way to automate the process so that you can focus on other tasks and initiatives.

You also want your colleagues to be able to make changes to the Bicep templates and deploy the templates themselves. But, you need to make sure your colleagues follow the same process that you use. You decide to create a deployment pipeline that will run automatically every time the Bicep code is updated in your shared repository. The pipeline will deploy your Bicep files to Azure.

:::image type="content" source="../media/1-workflow.png" alt-text="Diagram that shows a change to a Bicep file pushed to Azure Repos, and then a pipeline triggers deployment to Azure." border="false":::

## What will you be doing?

In this module, you'll learn how to automate the deployment of Bicep templates by using Azure Pipelines. You'll understand the benefits of using pipelines to deploy your code, and you'll build a basic pipeline that deploys a Bicep file. You'll also learn how to authorize your pipeline to deploy resources to your Azure environment and how to set when a pipeline runs.

## What is the main goal?

After completing this module, you'll be able to use Azure Pipelines to create a pipeline that deploys a basic Bicep file to an Azure resource group.
