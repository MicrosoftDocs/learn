When you automate your Bicep deployments by using GitHub Actions workflows, you create a consistent and reusable process for managing your Azure resources. Over time, your workflow becomes the only way that changes can be made to your Azure environment. It's important to ensure that your workflow enforces quality checks before, during, and after each deployment.

In this module, you'll learn how to extend your workflow to add validation, checks, and tests. By doing verifications, you'll build confidence that your deployments meet your quality standards.

## Example scenario

Suppose you're the Azure administrator at a toy company. You've been working with your website team to create a Bicep template that deploys and configures the Azure resources for your company's main website. You've recently also been creating a workflow to deploy the Bicep file automatically.

Recently, you and your team have made several changes to your website's Bicep files that included mistakes. You're worried that one day these mistakes might cause a production outage. You want to add testing to your Bicep deployment workflow to ensure that each deployment has the best chance of succeeding.

## What will you be doing?

In this module, you'll learn how you can test your Bicep code within your GitHub Actions workflow. When your workflow runs, you'll immediately get feedback on the changes that were made to your Bicep files.

You'll add linting to ensure the quality of your Bicep code, and preflight deployment validation to increase the chance that your deployments will succeed. You'll also use the what-if operation to add a manual approval step to your workflow. After deployment, you'll verify your environment by running more tests.

## What is the main goal?

After you complete this module, you'll be able to update your Bicep deployment workflow with validation and tests that help to ensure the quality of your Azure environment.
