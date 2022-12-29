Azure App Service is used for hosting an Express.js app. To use the App Service correctly, you need to understand the App Service plan and app settings.

:::image type="content" source="../media/app-service-plan-with-three-services.png" alt-text="Diagram that displays the Azure App Service plan with three app services.":::

## Choose Azure App Service for hosting

Azure provides several hosting choices, each with tradeoffs for intended purpose, degree of configuration, and app type. An Express.js app is a server-side app. The following table lists server-side hosting choices:

|Service|Description|
|--|--|
|Azure App Service|A service that runs either a Windows or Linux hosting environment or container. You have control over all the normal server settings to configure and control your app.|
|Azure Container<br><br>Azure Kubernetes<br><br>Azure Container apps<br><br>Azure Virtual Machines|These other hosting choices provide the entire system that runs the hosting environment. These choices allow more flexibility. The tradeoff is more work to configure and maintain the environment.|

For this module, our hosting choice is App Service. This Express.js app doesn't require the level of customization provided by containers, virtual machines, and container apps.

## Azure App Service and the App Service plan

The parent unit for App Service is the App Service plan. When you create the App Service instance, you can create a plan at the same time or use an existing plan.

An App Service plan defines a set of compute resources for a web app to run. These compute resources are analogous to the server farm in conventional web hosting. You can configure one or more apps to run on the same computing resources or in the same App Service plan.

Each App Service plan defines the:

* Operating system, such as Windows or Linux.
* Region, such as West US or East US.
* Number of VM instances.
* Size of VM instances, such as small, medium, or large.
* Pricing tier, such as Free, Shared, Basic, Standard, Premium, PremiumV2, PremiumV3, Isolated, and IsolatedV2.

## Reuse a plan or create a new plan

You might save money by putting multiple apps into one App Service plan. You can continue to add apps to an existing plan if the plan has enough resources to handle the load. Apps in the same App Service plan all share the same compute resources.

To determine whether the new app has the necessary resources, you must understand the capacity of the existing App Service plan and the expected load for the new app. Overloading an App Service plan might cause downtime for your new and existing apps.

Isolate your app into a new App Service plan when:

* The app is resource intensive.
* You want to scale the app independently from the other apps in the existing plan.
* The app needs resources in a different geographical region.

## Linux for the Express.js web app

In this module, you'll use the Linux operating system for this web app.

## App Service settings during creation

When you create an App Service resource, you have various settings from which to choose. Many of the settings have default values.

The following table lists the settings available during creation:

|Setting|Value|
|--|--|
|Globally unique name|The resource name you choose must be unique from all other App Service resources, because the name is used in the URL: `YOUR-APP-NAME.azurewebsites.net`.|
|Resource group|The resource group allows you to have a virtual category for all related resources.|
|Runtime stack|App Service allows you to pick the programmatic runtime stack, such as a Node.js LTS version.|
|OS|The two operating systems of the App Service, Windows and Linux, provide comparable functionality. A few differences are specific to each.|
|Location|The geographical location where the app is deployed.|
|Pricing tier|The App Service pricing tier provides a range of capabilities and includes a free tier.|
|Azure Application Insights|Application Insights integrates into your App Service instance and captures metrics and logs to the cloud. App Service can capture logs without Application Insights, but they're held in the container and not backed up to the cloud.|
|Database|You can create a database for your web app at the same time. *This feature isn't used in this module.*|

## App Service settings after creation

Most of the web app settings aren't set at creation time but are available after creation. They include:

* CORS
* HTTP/HTTPS and TLS
* Port forwarding
* Custom domain
* Certificates
* Authentication and authorization

## App setting for port

App Service forwards requests to 8080. Typically, your JavaScript is flexible for this port, for example:

```javascript
const port = process.env.PORT || 8080;
```

If your app listens to any other port, set the `WEBSITES_PORT` app setting to the port number and read in the port by using the environment variable `PORT`. App Service forwards requests to that port.

|App setting|Value|
|--|--|
|WEBSITES_PORT|3000|

In the sample app used in this Learn module, the port is correctly configured for you.

## App setting to install npm modules

This app setting allows your Linux/Node.js deployment to install npm dependencies instead of the deployment process having to include those dependency files.

|App setting|Value|
|--|--|
|SCM_DO_BUILD_DURING_DEPLOYMENT|True|

## Public web app URL

After you create your App Service web app, the URL is public and immediately available. The URL includes your App Service resource name and looks like this example:

```console
https://YOUR-RESOURCE-NAME.azurewebsites.net/
```

## Default web app before your first deployment

Before you deploy your app, the file `hostingstart.html` is returned for any requests. You can change this static HTML file to fit your own needs, like branding and contact information.

## Authentication

After you create your App Service web app, the app is public without authentication enabled. After it's created, you can configure your App Service resource to use one of several social sign-ins, your own enterprise Active Directory, or a custom authentication platform.

Depending on which authentication system you choose, your web app might need programmatic changes to fully enable your authentication choice.
