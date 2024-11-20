Azure resources often have complex lifecycle needs, because they can be spread across multiple places in your subscriptions. Some resources are short-lived or associated with a single application workload, while others are shared and reused throughout your organization. Deployment stacks enable you to manage the lifecycle of a collection of Azure resources as a single atomic unit, even if they span multiple resource groups or subscriptions.

## Example Scenario

Suppose you work as a DevOps engineer for a community bank that decided to use deployment stacks to better control lifecycle management of the bank's Azure resources. You've spent some time learning how to create deployment stacks to deploy a test version of the bank's new deposits application. You created and updated a deployment stack by adding a new resource to the stack. Additionally, you learned how to delete a deployment stack and its resources.

You're told to expect the deposits application's resources to change frequently as development continues. These changes could include resource modifications, additions, and deletions. You want to learn more about how deployment stacks manage resources and how updates impact them.

You decide to continue working with the test version of the deposits application using a command-line interface and a Bicep file that defines the application's resources.

## What will we be doing?

In this module, you learn about managed resources and how Azure handles detached and deleted resources. You also learn about when update operations for a deployment stack are required. Finally, you add, remove, modify, detach, and delete resources from a deployment stack.

## What is the main goal?

By the end of this module, you'll be able to add, remove, detach, and delete managed resources from a deployment stack.

## Prerequisites

You should be familiar with:

- Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Bicep, including creating and deploying basic files.
- Basic Azure PowerShell or Azure CLI commands.
