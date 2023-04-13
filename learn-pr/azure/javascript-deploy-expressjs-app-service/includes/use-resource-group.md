The Azure platform organizes cloud services to which you subscribe. It's important to understand the virtual organizational units. You need to know what you need to create and what the free Microsoft Learn sandbox provides for you while you use this module. Here, you'll learn about subscriptions, resource groups, and resources.

:::image type="content" source="../media/azure-subscription-resource-group.png" alt-text="Diagram that shows the relationship of management hierarchy levels.":::

## How do you organize Azure services?

When you use Azure, you need a subscription. Inside the subscription, you create resource groups. Inside the resource groups, you create resources. The terms are described here:

* **Management groups**: Enterprise-level units of Azure management. *This feature won't be used in this module.*
* **Subscription**: A subscription is used in the sandbox and associates your account with the resources created in this module. The Learn sandbox provides a free subscription. There's no need to enter credit card information.
* **Resource group**: A logical container where you manage Azure resources. The Learn sandbox provides a resource group for all your resources used in this module.
* **Resources**: Instances of services you create, like Azure App Service.

## What is a resource group?

A resource group allows you to group your Azure resources in a logical unit that fits your needs. The naming strategy you use for your resource groups helps you find your resources quickly, understand their purpose, and have an idea of what to expect for billing.

Examples of resource group names include:

* `learn-module-deploy-expressjs`
* `temporary-rental-web-app`
* `web-app-rental-property`

For this module, you'll use a resource group that contains resources to host your web app.

## How do you create a resource group?

You can create a resource group with any of the following tools:

|Tool|Explanation|
|--|--|
|Visual Studio Code extension for Azure resources|This tool is good for in-the-moment developer tasks, because you don't have to leave your development environment.|
|Azure portal|This tool is good for people new to Azure.|
|Azure CLI|This tool is good for automation tasks.|
|PowerShell|This tool is good for automation tasks.|
|Azure SDKs for management | This tool is good for automation with a high degree of customization specific to your needs.|

## Resource group properties

In this module, you'll use the Visual Studio Code extension for Azure resources and the Azure portal.

A resource group has required and optional properties:

|Property|Explanation|
|--|--|
|Location (required)|Azure region, such as `West US`, allows you to group your resources by region.|
|Tags (optional)|Name/values pairs that can help you add more granularity to the resource group that naming doesn't provide. |

## Use tags for rich categorization

*Do use tags* for:

* More information about the project, people, and dependencies of the resource.
* Ability to filter or sort for ownership and billing.

A subscription allows only 50 tags. Store complex data for tagging as JSON objects in the value of the tag. The maximum number of characters is 256.

*Don't use tags* for secrets, because tags aren't guaranteed to be secure.

## Use the Learn sandbox

This module uses the Learn sandbox with a *four-hour subscription*. The subscription and its resources are deleted after that time.  

The sandbox allows you to skip steps you would otherwise need. You can:

* Enter credit card information to create a subscription.
* Create a resource group.
* Delete resources when you're finished so that you aren't billed.

The subscription and resource group are already created for you. As part of the sandbox, you'll use that subscription to create the resources necessary to deploy your web app.
