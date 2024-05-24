An Azure deployment stack is a type of Azure resource that enables you to manage the lifecycle of a collection of Azure resources as a single atomic unit, even if they span multiple resource groups or subscriptions. It allows for consistent and repeatable deployments, simplifies management, and enables efficient scaling and updating of resources.

## Example Scenario

Suppose you work as a DevOps engineer for a community bank that decided to use deployment stacks to better control lifecycle management of the bank's Azure resources. You've been asked to deploy a test version of a new deposits application.

The initial deployment will include an app service plan and an app service, but the next sprint will include integrating an Azure SQL server and database.

You decide to create and modify the deployment stack using a command-line interface and a bicep file that defines the application's resources.

## What will we be doing?

In this module, you create, update, and delete a deployment stack and its managed resources.

## What is the main goal?

By the end of this module, you'll be able to create, update, and delete a deployment stack and its managed resources. You'll also understand how to use a command-line interface to work with deployment stacks.

## Prerequisites

You should be familiar with:

- Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Bicep, including creating and deploying basic files.
- Basic Azure PowerShell or AZ CLI commands.
