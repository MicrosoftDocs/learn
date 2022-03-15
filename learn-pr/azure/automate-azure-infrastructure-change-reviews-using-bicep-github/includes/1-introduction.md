When you work on Bicep templates, the main branch of your repository becomes the source of truth. The main branch incorporates the latest changes from all collaborators. It's important that the changes that are merged into the main branch are reviewed and tested. In this module, you'll learn how to protect your main branch by using automated pull request validation.

You'll also learn how you can create ephemeral environments for collaborators and reviewers where they can test changes before they are approved and merged into the main branch.

## Example scenario

Suppose you're the Azure administrator at a toy company. You've been working with your website team to create a Bicep template that deploys and configures the Azure resources, and you've recently also been creating a GitHub Actions workflow to deploy the Bicep file automatically to multiple environments.

Your website team is growing, and it's getting more difficult to keep control of all of the changes that everyone is making. You already set up pull requests so changes can be reviewed before they are merged in the main branch of your project. However manually reviewing all changes is becoming cumbersome for your team. You want to give them a more automated review process.

You decide to run additional checks before changes are merged to the main branch of your repository. You also need to find a way for your team members to try out their in-progress changes in a separate environment, without affecting the main repository branch and without being deployed to your environments.

You also don't want any changes to be deployed to production before they've been through your review and test process.

## What will you be doing?

In this module, you'll learn how you can run automatic checks and tests for each pull request to build confidence in the changes that were made. You'll also create an ephemeral environment for each pull request which can be used to review each change. 

## What is the main goal?

After completing this module, you'll know how to run automatic validation for each pull request.

## Prerequisites

You should have:

- Familiarity with basic Bicep template deployments, resource group and subscription level deployments.
- Familiarity with Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Familiarity with basic Git commands, including cloning, branching, committing files, and pushing changes to a GitHub repo.
- Familiarity with basic GitHub Actions workflows and basic experience deploying Bicep code using GitHub Actions workflows.
- Familiarity with basic pull requests.

To follow along with the exercises in the module, you'll need:

- [Visual Studio Code](https://code.visualstudio.com) installed locally.
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true)
- Azure account and subscription
- Git