When you work on Bicep code, the main branch of your Git repository becomes the source of truth. The main branch incorporates the latest changes from your whole team, and it usually reflects the state of your Azure environment.

It's important that the changes that are merged into your repository's main branch are reviewed. In this module, you'll learn how to protect your main branch by using other branches and pull request reviews.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your team is growing, and it's getting more difficult to keep track of all the changes that everyone is making.

Recently, a new team member accidentally changed an important Bicep file on your repository's main branch. That change caused a problem in your organization's production environment. You talk to your team and decide that it's time for you to start reviewing code changes before they're merged and deployed.

Now, you need to make a change to the way your website processes orders. You need to add a message queue so that your website can post messages whenever a customer places an order for a toy. A back-end system, built by another team, will pick up these messages and process the orders later. You need to ensure that you don't start sending messages to the queue until the other team is ready.

You decide that this is a great opportunity to try out a new process. You'll use pull requests to control how your Bicep changes are merged. Code will be written by the author, reviewed by a reviewer, and then merged to a Git repository before it's deployed to Azure.

:::image type="content" source="../media/1-process.png" alt-text="Diagram that shows a Bicep code review process of authoring, reviewing and merging." border="false":::

## What will we be doing?

In this module, you'll learn how to protect the code on your main branch by enforcing a change-control process through pull requests. You'll learn about branching strategies, and how to prevent your team from making changes to the main branch unless they've followed the correct process. You'll also learn how to use pull requests to review your code.

## What is the main goal?

After you complete this module, you'll be able to use a branching strategy for your own Bicep code. You'll also know how to create, review, and merge pull requests. You'll understand important elements to look for when you review a pull request for Bicep code.
