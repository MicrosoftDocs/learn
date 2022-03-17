To deploy the Express.js app to Azure, you need a service that supposed hosting a web app.

## Choose Azure App Service for hosting

Azure provides several hosting choices, each with tradeoffs for intended purpose, degree of configuration, and app type. An Express.js app is a server-side app. The server-side hosting choices include:

|Service|Description|
|--|--|
|Azure App Service|A service that runs either a Windows or Linux hosting environment or container. You have control over all the normal server settings to configure and control your app.|
|Azure Container<br>Azure Kubernetes<br>Azure Container apps<br>Azure Virtual machines|These other hosting choices provide the entire system running the hosting environment. This allows more flexibility at the tradeoff of more work to configure and maintain the environment.|

For this module, the hosting choice is Azure App Service because this Express.js app doesn't require the level of customization provided by containers and virtual machines. 

## Azure App Service and the App Service Plan

The parent unit for App Service is the **App Service Plan**. When you create the App Service, you can create a plan at the same time, or use an existing plan.

An App Service plan defines a set of compute resources for a web app to run. These compute resources are analogous to the server farm in conventional web hosting. One or more apps can be configured to run on the same computing resources (or in the same App Service plan). 

Each App Service plan defines:

* Operating System (Windows, Linux)
* Region (West US, East US, etc.)
* Number of VM instances
* Size of VM instances (Small, Medium, Large)
* Pricing tier (Free, Shared, Basic, Standard, Premium, PremiumV2, PremiumV3, Isolated, IsolatedV2)

## Reuse plan or create a new plan

You can potentially save money by putting multiple apps into one App Service plan. You can continue to add apps to an existing plan as long as the plan has enough resources to handle the load. However, keep in mind that apps in the same App Service plan all share the same compute resources. To determine whether the new app has the necessary resources, you need to understand the capacity of the existing App Service plan, and the expected load for the new app. Overloading an App Service plan can potentially cause downtime for your new and existing apps.

Isolate your app into a new App Service plan when:

* The app is resource-intensive.
* You want to scale the app independently from the other apps in the existing plan.
* The app needs resource in a different geographical region.

## Linux for the Express.js web app

In this module, use the Linux operating system for this web app. 

## Next steps to create your hosting resource

In the next exercise:

* Create your App Service Plan and App Service resource
