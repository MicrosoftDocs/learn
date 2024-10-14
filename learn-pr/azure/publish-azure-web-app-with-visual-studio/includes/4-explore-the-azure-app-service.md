You've created a new site, and your next step is to deploy it to Azure. We need to consider which Azure services to leverage. Azure App Service provides a highly scalable, self-patching web hosting service for your applications.

Here, we'll look at how to use Visual Studio to publish your ASP.NET Core web application to an Azure App Service plan.

## What is the Azure App Service?

Azure App Service is a service for hosting web applications, REST APIs, and backend services. App Service supports code written in .NET Core, .NET Framework, Java, Ruby, Node.js, PHP, and Python. App Service is ideal for most websites, particularly if you don't need tight control over the hosting infrastructure.

## What is the App Service plan?

The App Service plan defines the compute resources your app will consume, where those resources are located, how many additional resources the plan can consume, and the pricing tier. These compute resources are analogous to the server farm in conventional web hosting. You can configure one or more apps to run on the same App Service plan.

When you deploy your apps, you can create an App Service plan, or you can continue to add apps to an existing plan. However, apps in the same App Service plan share the same compute resources. To determine whether the new app has the necessary resources, you need to understand the existing App Service plan's capacity and the expected load for the new app. Overloading an App Service plan can cause reduced performance or downtime for your new and existing apps.

You can define an App Service plan in advance in the Azure portal, with PowerShell or the Azure CLI, or set one up as you publish your application in Visual Studio.

Each App Service plan defines:

- Region (West US, East US, and so on)
- Number of VM instances
- Size of VM instances (small, medium, large)
- Pricing tier (Free, Shared, Basic, Standard, Premium, Premium V2, Isolated)

## Select a region

When creating an App Service plan, you have to define a region or location where that plan will be hosted. Typically, you'd choose a region geographically close to your expected customers.

## Pricing and reliability levels

**Shared compute**: **Free** and **Shared**, the two base tiers, run an app on the same Azure VM as other App Service apps, including apps of other customers. These tiers allocate CPU quotas to each app that runs on the shared resources, and the resources cannot scale out.

Free and Shared plans are best for small-scale personal projects with limited traffic demands, with a set limit of 165 MB of outbound data every 24 hours.

**Dedicated compute**: The **Basic, Standard, Premium, and Premium V2** tiers run apps on dedicated Azure VMs. Only apps in the same App Service plan share the same compute resources. The higher the tier, the more VM instances are available to you for scale-out.

The Standard service plan is best suited for live production workloads where you're publishing commercial applications to customers.

The Premium service plans support high-capacity web apps where you don't want the additional costs of a dedicated (isolated) plan.

**Isolated**: This tier runs dedicated Azure VMs on dedicated Azure virtual networks, which provide network isolation on top of compute isolation to your apps. It provides the maximum scale-out capabilities. You'd only select an Isolated service plan when you have a specific requirement for the highest levels of security and performance.

Isolate your app into a new App Service plan when:

- The app is resource-intensive.
- You want to scale the app independently from the other apps in the existing plan.
- The app needs resources in a different geographical region.

You can scale your App Service plan up and down at any time. You can choose a lower pricing tier at first and scale up later when you need more App Service features.

## Specify the resource group

A resource group is a logical container into which you deploy and manage Azure resources like web apps, databases, and storage accounts. It's a mechanism for organizing resources for the purpose of management, monitoring, and billing. You can use an existing resource group or create one directly from Visual Studio.  
