You created a site and you want to deploy it to Azure. Now we need to consider which Azure services to leverage to best support our needs. App Service provides a highly scalable, self-patching web hosting service for your applications.

Here, we look at how to use Visual Studio to publish your ASP.NET Core web application to an Azure App Service plan.

## What is the Azure App Service?

Azure App Service is a service for hosting web applications, REST APIs, and mobile backends. App Service supports code written in  .NET, .NET Core, Java, Ruby, Node.js, PHP, and Python. App Service is ideal for most websites, particularly if you don't need a lot of control over the hosting infrastructure.

## What is the App Service plan?

The App Service plan defines the compute resources your app will consume, where those resources are located, how many additional resources the plan can consume, and the pricing tier. These compute resources are analogous to the server farm in conventional web hosting. One or more apps can be configured to run on the same App Service plan.

When you deploy your apps, you can create an App Service plan or you can continue to add apps to an existing plan.  However, apps in the same App Service plan share the same compute resources. To determine whether the new app has the necessary resources, you need to understand the capacity of the existing App Service plan, and the expected load for the new app. Overloading an App Service plan can cause reduced performance or downtime for your new and existing apps.

You can define an App Service plan in advance in the Azure portal with PowerShell or the Azure CLI, or set one up as you publish your application in Visual Studio.

Each App Service plan defines:

- Region (West US, East US, and so on)
- Number of VM instances
- Size of VM instances (small, medium, large)
- Pricing tier (Free, Shared, Basic, Standard, Premium, Premium V2, Isolated)

## Specify the region

When creating an App Service plan, you have to define a region or location where that plan will be hosted. Typically, you would choose a region geographically close to your expected customers.

## What are the pricing and reliability levels?

**Shared compute**: **Free** and **Shared**, the two base tiers, run an app on the same Azure VM as other App Service apps, including apps of other customers. These tiers allocate CPU quotas to each app that runs on the shared resources, and the resources cannot scale out.

Free and Shared plans are best for small-scale personal projects with very limited traffic demands, with a set limit of 165 MB of outbound data every 24 hours.

**Dedicated compute**: The **Basic, Standard, Premium, and Premium V2** tiers run apps on dedicated Azure VMs. Only apps in the same App Service plan share the same compute resources. The higher the tier, the more VM instances are available to you for scale out.

The Standard service plan is best suited for live production workloads, where you are publishing commercial applications to customers.

The Premium service plans support high-capacity web apps where you do not want the additional costs of a dedicated (isolated) plan.

**Isolated**: This tier runs dedicated Azure VMs on dedicated Azure virtual networks, which provide network isolation on top of compute isolation to your apps. It provides the maximum scale-out capabilities. You would only select an Isolated service plan when you have a specific requirement for the highest levels of security and performance.

Isolate your app into a new App Service plan when:

- The app is resource-intensive
- You want to scale the app independently from the other apps in the existing plan
- The app needs resources in a different geographical region

Your App Service plan can be scaled up and down at any time. You can choose a lower pricing tier at first and scale up later when you need more App Service features.

## Specify the resource group

A resource group is a logical container into which Azure resources like web apps, databases, and storage accounts are deployed and managed. It is a mechanism for organizing resources for the purpose of management, monitoring and billing. You can use an existing resource group or create one directly from Visual Studio.  
