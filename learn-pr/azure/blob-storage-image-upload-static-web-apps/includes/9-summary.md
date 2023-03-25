In this module, you learned how to grant secure access to your Blob Storage account so your application's users can upload images without the need for you to maintain a middleware application.

Achieving that required several steps:

* You needed to grant access to your Blob Storage account to your users
* You couldn’t share your Blob Storage account keys, so you decided to use shared access signatures
* You needed to generate shared access signatures on demand and deliver them to your static web app
* An Azure Function API was the best way to generate SAS keys on demand and deliver them to your static web app

Shared access signatures are the way to go when you need to provide secure and on-demand access to your cloud resources. An Azure Function was the best way to created SAS keys on demand while reducing the maintenance costs of running cloud software, removing middleware, and letting Azure handle the task of running a backend service for you. In this way, you offered your users a fast storage solution by applying Blob Storage, and allowed your developers to focus on the application development instead of maintaining legacy image upload middleware.

## Clean up

In the course of this module, you created several resources in your Azure subscription. To remove these resources and avoid charges to your subscription, delete the resource group.

1. In the Azure portal, go to the resource group you created for this module.
1. In the **Overview** pane, select **Delete resource group** at the top of the screen.
1. Type the name of your resource group to confirm deletion, then select **Delete**.
1. Select **Delete** again to confirm that you want to delete the resource group and its dependent resources.

## Learn more

Check out the following resources to learn more about some of the concepts presented in this module:

* [Develop Azure Functions by using Visual Studio Code](/azure/azure-functions/functions-develop-vs-code?tabs=nodejs)
* [Same-origin Policy](https://www.w3.org/Security/wiki/Same_Origin_Policy)
* [Cross-Origin Resource Sharing (CORS) support for Azure Storage](/rest/api/storageservices/cross-origin-resource-sharing--cors--support-for-the-azure-storage-services)
