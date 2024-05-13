Workflows enable you to deploy your Azure resources in a repeatable way. In this module, you'll learn how to extend a deployment workflow to work with multiple environments. Your workflow will help you validate and test your changes without adding risk to your production environment. After you validate your changes, your workflow will use the same process to deploy to your production environment.

## Example scenario

Suppose you're the Azure administrator at a toy company. You've been working with your website team to create a Bicep template that deploys and configures the Azure resources. You've also been creating a workflow to deploy the Bicep file automatically.

Your website team wants to integrate with a partner product review service. The service enables your customers to submit and view product reviews for your toys. The website team needs to be able to try out the service when it's integrating the service into your company's website, but the team doesn't want to submit real product reviews. The team has access to a sandbox version of the review service for safe testing.

Now, the team wants your help updating its deployment workflow. The team needs to deploy the site to a non-production environment that's separate from the production environment that customers use. The team needs to use different configuration settings for the ratings API in each environment:

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Diagram that shows the solution architecture, including the website app and integration with the vendor." border="false":::

## What will you learn?

In this module, you learn how to extend a workflow to deploy Bicep code to multiple Azure environments in a consistent way. You create separate workload identities for each environment to support higher security and isolation.

You'll use called workflows to define your deployment steps in a single place, and use Bicep parameters to handle configuration differences between your environments. You'll also secure your parameter values so they don't accidentally leak secrets in your workflow's logs.

## What is the main goal?

After you complete this module, you'll be able to update your workflow to target multiple environments. You'll know how to use called workflows to avoid repetition in your definitions, and know how to provide parameters to your Bicep files for each environment.
