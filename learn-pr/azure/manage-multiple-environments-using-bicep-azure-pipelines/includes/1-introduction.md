Pipelines enable you to deploy your Azure resources in a repeatable way. In this module, you'll learn how to extend a deployment pipeline to work with multiple environments. Your pipeline will help you validate and test your changes without adding risk to your production environment. After you validate your changes, your pipeline will use the same process to deploy to your production environment.

## Example scenario

Suppose you're the Azure administrator at a toy company. You've been working with your website team to create a Bicep template that deploys and configures the Azure resources. You've also been creating a pipeline to deploy the Bicep file automatically.

Your website team wants to integrate with a third-party product review service. The service will enable your customers to submit and view product reviews for your toys. The website team needs to be able to try out the service when it's integrating the service into your company's website, but the team doesn't want to submit real product reviews. The team has been given access to a sandbox version of the review service for safe testing.

Now, the team has asked you for help with updating its deployment pipeline. The team needs to deploy the site to a non-production environment that's separate from the production environment that customers use. The team needs to use different configuration settings for the ratings API in each environment:

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Diagram that shows the solution architecture, including the website app and integration with the third-party vendor." border="false":::

## What will you be doing?

In this module, you'll learn how you can extend a pipeline to deploy Bicep code to multiple Azure environments in a consistent way. You'll create separate service connections and service principals for each environment to support higher security and isolation.

You'll use pipeline template files to define your deployment steps in a single place, and you'll use Bicep parameters to handle configuration differences between your environments. You'll also secure your parameter values so they don't accidentally leak secrets in your pipeline's logs.

## What is the main goal?

After you complete this module, you'll be able to update your pipeline to target multiple environments. You'll know how to use pipeline templates to avoid repetition in your definitions, and you'll know how to provide parameters to your Bicep files for each environment.
