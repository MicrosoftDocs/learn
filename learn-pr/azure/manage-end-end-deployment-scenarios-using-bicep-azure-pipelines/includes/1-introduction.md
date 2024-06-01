When you use pipelines, you can automate the validation, testing, and deployment of your Bicep code. Many of the benefits of using Bicep come from deploying your Azure infrastructure alongside the other components of your solution, such as applications and the database configuration. In this module, you learn how to extend a pipeline that already deploys Bicep code to deploy an entire solution.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You built a Bicep template to deploy your company's website, which deploys an Azure App Service app, an Azure SQL database for your product list, and a storage account for hosting product images. Also, you created a pipeline that deploys your Azure resources by using your Bicep template. Now, you want to extend the pipeline to deploy your app, configure your database, and seed some test data that you need for your website.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram illustrating the solution's Azure components, with the pipeline deploying the Bicep file and performing the additional steps on the resources." border="false":::

## What will you be doing?

In this module, you learn how to extend a deployment pipeline so that it deploys Azure infrastructure, applications, databases, and data together. You add a build stage to your pipeline that compiles an application and database project, and you use pipeline artifacts to propagate the deployable files through your pipeline. Then, you use Bicep outputs from your pipeline to integrate your pipeline's components, and update your deployment stage to publish your application, website, and sample data.

## What is the main goal?

After you complete this module, you're able to create a unified deployment pipeline that does the following tasks:

- Provisions Azure resources by using a Bicep file.
- Deploys an application to Azure App Service.
- Publishes a database schema to an Azure SQL database.
- Adds sample data to an Azure SQL database and an Azure Storage blob container.

By completing these tasks, you learn how to use pipeline artifacts, Bicep outputs, and pipeline variables to coordinate the different parts of your pipeline.
