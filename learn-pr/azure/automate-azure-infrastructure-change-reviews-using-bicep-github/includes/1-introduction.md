When you work on Bicep code, it's important for all changes to be reviewed and tested. Even when your deployment workflows and processes are designed to detect bugs or problems, it's less time-consuming for any problems to be found and fixed as early as possible. Pull requests provide an opportunity for code changes to be reviewed. When you work with Azure deployments, it's a good practice not only to validate the code changes, but also to verify that the changes deploy successfully.

In this module, you'll learn how to add automated checks to your pull request review process. You'll learn how to validate changes to your Bicep code within a pull request, well before it's merged or deployed to a real environment. You'll also learn how you can automatically create ephemeral environments - temporary environments where collaborators and reviewers can test the code changes before they're approved and merged into the repository's main branch.

## Example scenario

Suppose you're the Azure administrator at a toy company. You've been working with your website team to create Bicep code that deploys and configures the Azure resources for your website.

Your website team is growing, and it's getting more difficult to keep control of all of the changes that everyone is making. You recently started to use pull requests to ensure that changes are reviewed before they are merged to the main branch of your project's GitHub repository. Each of the reviewers validates the Bicep code changes in the pull request, and many reviewers even deploy the changes to a temporary environment so they can try them out.

Your colleagues have told you that the current manual review process is cumbersome and time consuming. It's important that your pull request reviews are easy for everybody on the team, so you decide to automate some of the review process within the pull requests.

## What will you be doing?

In this module, you'll learn how you can run automated checks and tests for each pull request to build confidence in the changes to your Bicep code.

You'll configure your pull request workflow to scan your Bicep code against recommended practices by using the Bicep linter. You'll also configure the creation of ephemeral environments for each pull request, which can be used to review the changes to your Azure environment, and automatically delete the environment when the pull request is merged or closed.

## What is the main goal?

After completing this module, you'll be able to add automated checks and validation to your GitHub pull requests for your Bicep code.

## Prerequisites

You should be familiar with using:

  - Bicep, including creating and deploying basic files.
  - Azure, including the Azure portal, subscriptions, resource groups, and resources.
  - Basic Git commands, including cloning, committing files, and pushing changes to GitHub.
  - Pull requests in GitHub, including creating, reviewing, and merging pull requests.
  - Basic GitHub Actions workflows, including secrets for connecting to your Azure environment.

To work through the exercises in the module, you'll need:

  - An Azure account, with the ability to create resource groups, Azure Active Directory applications, and service principals.
  - A GitHub account.
  
You'll also need the following installed locally:
  
  - [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
  - The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true)
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools *or* the latest [Azure PowerShell](/powershell/azure/install-az-ps) version
  - [Git](https://git-scm.com/download?azure-portal=true)
