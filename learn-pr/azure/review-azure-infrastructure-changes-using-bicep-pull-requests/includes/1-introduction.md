When you work on Bicep code, the main branch of your Git repository becomes the source of truth. The main branch incorporates the latest changes from your whole team, and usually it reflects the state of your Azure environment. It's important that the changes that are merged into your repository's main branch are reviewed. In this module, you'll learn how to protect your main branch by using branches and pull request reviews.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your team is growing, and it's getting more difficult to keep control of all of the changes that everyone is making. Recently, a new team member accidentally changed an important Bicep file on your repository's main branch, which caused a production issue for your organization. You talk to your team and decide that it's time you start to review your code changes before they're merged and deployed.

Now, you need to make a change to the way your website processes orders. You need to add a message queue, so that your website can post messages whenever a customer places an order for a toy. A backend system, built by another team, will pick up these messages and process the orders later. You need to ensure that you don't start sending messages to the queue until the other team is ready.

After talking to your team, you decide that this is a great opportunity to try out a new process for how your Bicep changes are merged.

:::image type="content" source="../media/1-process.png" alt-text="Diagram showing a Bicep code review process. Code is written by the author, reviewed by a reviewer, and then merged to a Git repository before it's deployed to Azure." border="false":::

## What will we be doing?

In this module, you'll learn how you can protect the code on your main branch by enforcing a change control process through pull requests. You'll learn about some of the branching strategies you can use in your team, and how to prevent changes being made to your main branch unless they've followed the correct process. You'll also learn how you can use pull requests to review your code.

## What is the main goal?

After completing this module, you'll be able to use a branching strategy for your own Bicep code. You'll also know how to create, review, and merge pull requests, and you'll understand some important elements to look for when you review a pull request for Bicep code.

## Prerequisites

You should be familiar with using:

- Bicep for basic deployments to Azure.
- Basic Git commands, including cloning, branching, committing files, and pushing changes to either Azure Repos or GitHub.

To work through the exercises in the module, you'll need either of:

- An Azure DevOps organization and account.
- A GitHub account.

To follow along with the exercises in the module, you'll need:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true), installed locally.
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), installed.
- [Git](https://git-scm.com/download?azure-portal=true).
