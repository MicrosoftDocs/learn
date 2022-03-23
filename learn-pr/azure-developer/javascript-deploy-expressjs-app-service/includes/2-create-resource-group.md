## How do you organize Azure services? 

When you use Azure, you need a subscription. Then inside the subscription, you create resource groups, and resources inside the resource groups.

:::image type="content" source="../media/azure-subscription-resource-group.png" alt-text="Diagram that shows the relationship of management hierarchy levels.":::

* **Management groups** are enterprise level units of Azure management. This won't be used in this module.
* The **Subscription**, used in the sandbox, associates your account with the resources created in this module. The Learn sandbox provides a free subscription, without any need to enter credit card information.
* The **Resource group** is a logical container where you manage Azure resources. The Learn sandbox provides a resource group for all your resources used in this module. 
* The **Resources** are instances of services you create, like Azure App Service.

## What is a resource group? 

A resource group allows you to group your Azure resources in a logical unit that fits your needs. The naming strategy you use for your resource groups help you find your resources quickly, understand their purpose, and have an idea of what to expect for billing. 

Examples of resource group names include:

* `learn-module-deploy-expressjs`
* `temporary-rental-web-app`
* `web-app-rental-property`

For this module, you use a resource group containing resources to host your web app. 

## How do you create a resource group? 

You can create a resource group with any of the following:

|Tool|Explanation|
|--|--|
|Visual Studio Code extension for Azure resources|This is a good tool for in-the-moment developer tasks because you don't have to leave your development environment.|
|Azure portal|This is a good tool for people new to Azure.|
|Azure CLI|This is a good tool for automation tasks.|
|PowerShell|This is a good tool for automation tasks.|
|Azure SDKs for management|This is a good tool for automation with a high-degree of customization specific to your needs.|

## Resource group properties

In this module, you will use Visual Studio Code extension for Azure resources and the Azure portal.

A resource group has required and optional properties

|Property|Explanation|
|--|--|
|Location (Required)|Azure region such as `U.S. West`. This allows you to group your resources by region.|
|Tags (Optional)|Name/values pairs that can help you add more granularity to the resource group that naming doesn't provide. |

## Use tags for rich categorization

**Do use tags** for:
* Additional information about the project, people, and dependencies of the resource
* Ability to filter or sort for ownership and billing

Because a subscription has a limited number of allowed tags (50), complex data for tagging should be stored as JSON objects in the value of the tag with a maximum of 256 characters.


**Don't use tags** for:
* Secrets because tags are not guaranteed to be secure. 

## Use the Learn Sandbox?

This module uses the Learn sandbox with a **4-hour subscription**. The subscription and its resources are deleted after that time period.  

The sandbox allows you to skip steps you would otherwise need:

* Enter credit card information to create a subscription
* Create resource group
* Delete resources when you are done so you aren't billed

Because the subscription and resource group are already created for you, as part of the sandbox, you use that subscription to create the resources necessary to deploy your web app. 