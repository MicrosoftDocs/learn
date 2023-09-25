You can use the Web Apps, Mobile Apps, or API Apps features of Azure App Service, and create your own apps in the Azure portal.

Watch the following video to learn how to create an app with Azure App Service. 

#### <!-- Video -->

> [!VIDEO https://www.youtube.com/embed/dHTzv-zY17I]


### Things to know about configuration settings

Let's examine some of the basic configuration settings you need to create an app with App Service.

- **Name**: The name for your app must be unique because it's used to identify and locate your app in Azure. An example name is `webappces1.azurewebsites.net`. You can map a custom domain name, if you prefer to use that option instead.

- **Publish**: App Service hosts (publishes) your app as code or as a Docker Container.

- **Runtime stack**: App Service uses a software stack to run your app, including the language and SDK versions. For Linux apps and custom container apps, you can set an optional start-up command or file. Your choices for the stack include .NET Core, .NET Framework, Node.js, PHP, Python, and Ruby. Various versions of each product are available for Linux and Windows.

- **Operating system**: The operating system for your app runtime stack can be Linux or Windows.

- **Region**: The region location that you choose for your app affects the App Service plans that are available.

- **App Service plan**: Your app needs to be associated with an Azure App Service plan to establish available resources, features, and capacity. You can choose from pricing tiers that are available for the region location you selected.

#### Post-creation settings

After your app is created, other configuration settings become available in the Azure portal, including app deployment options and path mapping.

:::image type="content" source="../media/web-app-configuration-27facdc5.png" alt-text="Screenshot that shows other configuration options for an app with the App Service in the Azure portal.":::

Some of the extra configuration settings can be included in the developer's code, while others can be configured in your app. Here are a few of the extra application settings.

- **Always On**: You can keep your app loaded even when there's no traffic. This setting is required for continuous WebJobs or for WebJobs that are triggered by using a CRON expression.

- **ARR affinity**: In a multi-instance deployment, you can ensure your app client is routed to the same instance for the life of the session.

- **Connection strings**: Connection strings for your app are encrypted at rest and transmitted over an encrypted channel.