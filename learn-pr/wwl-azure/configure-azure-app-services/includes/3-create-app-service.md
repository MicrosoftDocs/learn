You create Web Apps, Mobile Apps, or API Apps with Azure App Service in the Azure portal. To implement your app, you need to specify several configuration settings, including the resource group and App Service plan.

Watch this video to learn how to create an app with Azure App Service in the Azure portal. 


<iframe width="854" height="480" src="https://www.youtube.com/embed/dHTzv-zY17I" title="How to create an app with Azure App Service in the Azure portal | Azure Portal Series" allowfullscreen></iframe>


### Things to know about configuration settings

Let's examine some the basic configuration settings you need to specify to create an app with App Service. You might need to ask your developer for assistance in gathering information for these settings.

- **Name**: The name for your app must be unique because it's used to identify and locate your app in Azure. An example name is `webappces1.azurewebsites.net`. You can map a custom domain name, if you prefer to use that option instead.

- **Publish**: App Service hosts (publishes) your app as code or as a Docker Container.

- **Runtime stack**: App Service uses a software stack to run your app, including the language and SDK versions. For Linux apps and custom container apps, you can set an optional start-up command or file. Your choices for the stack include .NET Core, .NET Framework, Node.js, PHP, Python, and Ruby. Various versions of each product are available for Linux and Windows.

- **Operating system**: The operating system for your app runtime stack can be Linux or Windows.

- **Region**: The region location that you choose for your app affects the App Service plans that are available.

- **App Service plan**: Your app needs to be assoicated with an Azure App Service plan to establish avaialble resources, features, and capacity. You can choose from pricing tiers that are available for the region location you selected.

#### Post-creation settings

After your app is created, other configuration settings become available in the Azure portal, including app deployment options and path mapping.

:::image type="content" source="../media/web-app-configuration-27facdc5.png" alt-text="Screenshot that shows other configuration options for an app with the App Service in the Azure portal.":::

Some of the extra configuration settings can be included in the developer's code, while others can be configured in your app. Here are a few of the extra settings.

- **Always On**: You can keep your app loaded even when there's no traffic. This setting is required for continuous WebJobs or for WebJobs that are triggered by using a CRON expression.

- **ARR affinity**: In a multi-instance deployment, you can ensure your app client is routed to the same instance for the life of the session.

- **Connection strings**: Connection strings for your app are encrypted at rest and transmitted over an encrypted channel.