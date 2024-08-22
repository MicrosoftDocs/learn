Deployment workflows need to communicate with Azure so that they can create and configure your Azure resources. In this module, you'll learn how workload identities work, how to create and manage them, and how to authorize them to work with Azure on your behalf.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've created a Bicep file to deploy your company's website. Until now, you've been deploying it from your own computer by using command-line tools. You've decided to move the deployment into a GitHub Actions workflow.

One of your colleagues has told you that you need to set up an identity for the deployment workflow. You need to understand what an identity is, then create it so you can deploy your company's website.

## What will we learn?

In this module, you'll learn how to create workload identities. You'll also learn how to authorize a workload identity to deploy and configure your website's resources.

> [!NOTE]
> The information in this module is specific to GitHub Actions deployment workflows. If you use Azure Pipelines, the way your pipelines authenticate is different. To learn more about Azure Pipelines and deployment authorization, see [Authenticate your Azure deployment pipeline by using service principals](/training/modules/authenticate-azure-deployment-pipeline-service-principals/).

## What is the main goal?

By the end of this module, you'll have an understanding of workload identities and how they relate to other Azure and Microsoft Entra security concepts. You'll be able to create a Microsoft Entra application registration and manage its federated credentials. You'll also be able to determine the best authorization policy to use for your workflow's identity and configure the appropriate role assignments in Azure.
