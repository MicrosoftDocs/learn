An Azure deployment stack is a collection of Azure resources that can be managed as a single unit even if they span multiple resource groups or subscriptions.

## Example scenario

Suppose you work as a DevOps engineer for a community bank that is on a multi-year journey to modernize its applications to use cloud computing. The IT organization within the bank consists of individual teams, each dedicated to managing specific applications and the lifecycle of their resources. After many migrations, the number of applications are creating challenges around resource organization. Applications are now using shared resources, such as virtual networks, kubernetes clusters, and monitoring systems. Teams need to be able to manage their application resources without impacting existing and shared services. You're looking for a reliable solution to improve the resource management process for applications used across the company. The solution needs to adhere to the following characteristics:

- The ability to manage the lifecycle of an application across different scopes. For example, some teams deploy policies to management groups, or they deploy new resource groups into subscriptions.
- Allow teams to continue iterating on their solution by updating and deleting resources that they've deployed.
- Prevent unwanted changes, whether accidental or intentional, to deployed resources.

You want to evaluate whether deployment stacks might provide the right features for resource lifecycle management.

## What will we be doing?

In this module, you learn about deployment stacks and its benefits and find answers to these questions:

- What are deployment stacks?
- Why you would use deployment stacks for managing the lifecycle of your resources?
- What is the deployment stack resource?
- What are some use cases for deployment stacks?

## What is the main goal?

After completing this module, you'll be able to determine whether deployment stacks is the right tool for managing the lifecycle of your resources.

## Prerequisites

You should be familiar with:

- Azure resource organization, including resource groups, subscriptions, and management groups.
- Bicep, including creating and deploying basic files.
