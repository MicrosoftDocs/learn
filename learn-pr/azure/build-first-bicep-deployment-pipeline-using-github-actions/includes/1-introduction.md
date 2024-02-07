You can use GitHub Actions to automate Bicep deployments. GitHub Actions provides a flexible and reusable process to propagate changes to your Azure environment. A workflow enforces the process that you set to ensure the quality of your deployments and of your Azure environment. A deployment workflow also ensures that everyone who collaborates on your Bicep files uses the same process. In this module, you'll learn how to define a workflow in GitHub Actions and how to deploy your Bicep code by using the workflow.

> [!NOTE]
> If you're interested in using Azure Pipelines instead of GitHub Actions to deploy infrastructure to Azure, see [Build your first Bicep deployment pipeline by using Azure Pipelines](/training/modules/build-first-bicep-deployment-pipeline-using-azure-pipelines/).

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure to support a website at a toy company. You've built a Bicep template to deploy the website. Every time you need to reconfigure the website, you update your Bicep files and redeploy them from your computer. The website team asks for changes regularly, so the deployment process has become time-consuming. You want to find a way to automate the process so that you can focus on other tasks and initiatives.

You also want your colleagues to be able to make changes to the Bicep templates and deploy the templates themselves, but you need to make sure your colleagues follow the same process that you use. You decide to create a deployment workflow that will run automatically every time the Bicep code is updated in your shared repository. The workflow will deploy your Bicep files to Azure.

:::image type="content" source="../media/1-workflow.png" alt-text="Diagram that shows a change to a Bicep file pushed to GitHub, and then a workflow triggers deployment to Azure." border="false":::

## What will you be doing?

In this module, you'll learn how to automate the deployment of Bicep templates by using GitHub Actions. You'll understand the benefits of using GitHub Actions workflows to deploy your code, and you'll build a basic workflow that deploys a Bicep file. You'll also learn how to authorize your workflow to deploy resources to your Azure environment and how to set when a workflow runs.

## What is the main goal?

After completing this module, you'll be able to use GitHub Actions to create a workflow that deploys a basic Bicep file to an Azure resource group.
