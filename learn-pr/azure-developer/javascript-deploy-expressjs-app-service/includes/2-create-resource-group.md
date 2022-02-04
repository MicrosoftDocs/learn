## Deployment steps

Deploying a web app to Azure App Service consists of a few steps:

* Create a resource group
* Create the hosting resource
* Configure the resource and deploy the web app
* Create a database resource
* Connect the web app to the database
* Use the public web app
* View the logs


<!-- Pattern for complex chunks (repeat as needed) -->
## Organize your Azure usage with a Resource group

When you come to Azure, you create a subscription. Then inside the subscription, you create resource groups, and resources inside the resource groups.

:::image type="content" source="../media/azure-subscription-resource-group.png" alt-text="Diagram that shows the relationship of management hierarchy levels.":::

The **Subscription**, used in the sandbox, associates your account with the resources created in this module. The **Resource group** is a logical container where you manage Azure resources. The **Resources** are instances of services you create, like Azure App Service, and Cosmos DB.

When you use the Learn sandbox, the subscription is provided for you. You will create the resource group and resources in this module.

## Steps to create your resource group

In the next exercise, follow these steps to create the resource group:

1. Open the sandbox.
2. Create the resource group.
