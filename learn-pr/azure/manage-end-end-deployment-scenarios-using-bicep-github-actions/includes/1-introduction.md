When you use workflows, you can automate validating, testing, and deploying your Bicep code. Many of the benefits of using Bicep come from deploying your Azure infrastructure alongside the other components of your solution, such as applications and database configuration. In this module, you'll learn how to extend a workflow that already deploys Bicep code to deploy an entire solution.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've built a Bicep template to deploy your company's website, which deploys an App Service app, an Azure SQL database for your product list, and a storage account for hosting product images. You've already created a workflow that deploys your Azure resources by using your Bicep template. Now, you want to extend the workflow to deploy your app, to configure your database, and to seed some test data you need for your website.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram illustrating the solution's Azure components, with the workflow deploying the Bicep file and performing the additional steps on the resources." border="false":::

## What will you be doing?

In this module, you'll learn how to extend a deployment workflow so that it deploys Azure infrastructure, applications, databases, and data together. You'll add build jobs to your workflow that compile an application and database project, and you'll use workflow artifacts to propagate the deployable files through your workflow. You'll use Bicep outputs from your workflow to integrate your workflow's components together, and you'll update your deployment jobs to publish your application, website, and sample data.

## What is the main goal?

After completing this module, you'll be able to create a unified deployment workflow that:

- Provisions Azure resources by using a Bicep file.
- Deploys an application to Azure App Service.
- Publishes a database schema to an Azure SQL database.
- Adds sample data to an Azure SQL database and an Azure Storage blob container.

You'll also know how to effectively use workflow artifacts, Bicep outputs, and workflow variables to coordinate the different parts of your workflow.
