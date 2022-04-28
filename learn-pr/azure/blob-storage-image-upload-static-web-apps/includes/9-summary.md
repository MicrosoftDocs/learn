In this module, you learned how to grant secure access to your Blob Storage account so users of your application could upload images without the need for you to maintain a middleware application.

Achieving that required several steps:

* You needed to grant access to your Blob Storage account to your users
* You couldn’t share your Blob Storage account keys so you decided to use SAS
* SAS needed to be generated on-demand and delivered to your static web app
* An Azure Function API was the right way to generate SAS keys on-demand and deliver them to your static web app

Shared access signatures are the way to go when you need to provide secure and on-demand access to your cloud resources. An Azure Function was the best way to created SAS keys on-demand while at the same time reducing the maintenance costs of running cloud software, removing middleware, and letting Azure handle the task of running a backend service for you. In this way, you offered a fast storage solution to your users by applying Blob Storage, and allowed your developers to focus on the application development, instead of maintaining legacy image upload middleware.

## Learn more

Here you can learn more about some of the concepts presented in this module

* [Develop Azure Functions by using Visual Studio Code](/azure/azure-functions/functions-develop-vs-code?tabs=nodejs)
* [Same-origin Policy](https://www.w3.org/Security/wiki/Same_Origin_Policy)
* [Cross-Origin Resource Sharing](/rest/api/storageservices/cross-origin-resource-sharing--cors--support-for-the-azure-storage-services)
