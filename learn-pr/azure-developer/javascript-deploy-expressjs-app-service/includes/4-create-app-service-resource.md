## Choose Azure App Service for hosting

Azure provides several hosting choices, each with tradeoffs for intended purpose, degree of configuration, and app type. An Express.js app is a server-side app. The server-side hosting choices include:

|Service|Description|
|--|--|
|Azure App Service|A service that runs either a Windows or Linux hosting environment or container. You have control over all the normal server settings to configure and control your app.|
|Azure Container<br><br>Azure Kubernetes<br><br>Azure Container apps<br><br>Azure Virtual machines|These other hosting choices provide the entire system running the hosting environment. This allows more flexibility at the tradeoff of more work to configure and maintain the environment.|

For this module, the hosting choice is Azure App Service because this Express.js app doesn't require the level of customization provided by containers, virtual machines, and container apps. 

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
* The app needs resources in a different geographical region.

## Linux for the Express.js web app

In this module, use the Linux operating system for this web app. 

## App Service settings during creation

When you create an App Service resource, you have various settings to choose from, many have default values. 

The following table covers the settings available during creation:

|Setting|Value|
|--|--|
|Globally unique name|The resource name you choose must be unique from all other App Service resource because the name is used in the URL, `YOUR-APP-NAME.azurewebsites.net`.|
|Resource group|The resource group allows you to have a virtual category for all related resources.|
|Runtime stack|App Service allows you to pick the programmatic runtime stack, such as a Node.js LTS version.|
|OS|Each of the two operating systems of the App Service, Windows and Linux, generally provide comparable functionality with a few differences specific to each.|
|Location|The geographical location where the app is deployed.|
|Pricing tier|The App Service pricing tier provides a wide range of capabilities including a free tier.|
|Application Insights|Application Insights is an Azure service, which integrates into your App Service and captures a wide variety of metrics and logs to the cloud. While your App Service does captures log without Application Insights, those are held in the container and not backed up to the cloud.|
|Database|You can create a database for your web app at the same time. NOT USED IN THIS MODULE.|

## App Service settings after creation

Most of the web app settings aren't set at creation time but are available after creation. They include:

* CORS
* HTTP/HTTPS and TLS
* Port forwarding
* Custom Domain
* Certificates
* Authentication and authorization

## App setting for port

App Service forwards requests to 8080. Typically, your JavaScript is flexible for this, for example:

```javascript
const port = process.env.PORT || 8080;
```

If your app listens to any other port, you need to set the `WEBSITES_PORT` app setting to the port number and read in the port using the environment variable `PORT`.App Service forwards requests to that port. 

|App setting|value|
|--|--|
|WEBSITES_PORT|3000|


In the sample app used in this Learn module, the port is correctly configured for you.

## App setting to install npm modules

This setting allows your Linux/Node.js deployment to install npm dependencies instead of the deployment process having to include those dependency files.

|App setting|value|
|--|--|
|SCM_DO_BUILD_DURING_DEPLOYMENT|true|

## Public web app URL

Once you create your App Service web app, the URL is public and immediately available. The URL includes your App Service resource name and looks like:

```console
https://YOUR-RESOURCE-NAME.azurewebsites.net/
```

## Default web app before your first deployment

Before you deploy your app, there's one file, `hostingstart.html`, which is returned for any requests. This is a static HTML file, which you can change to fit your own needs such as branding and contact information.

## Authentication

Once you create your App Service web app, the app is public without authentication enabled. Once created, you can configure your App Service resource to use one of several social logins, your own enterprise Active Directory, or a custom authentication platform.

Depending on which authentication system you choose, your web app may need no, some, or many programmatic changes to fully enable your authentication choice. 