When creating an App Service, you will need to specify a resource group and service plan. Then there are few other configuration choices. You may need to ask your developer for assistance in completing this information.

:::image type="content" source="../media/web-instances-feb0bc48.png" alt-text="Screenshot of the instance details for a new app service.":::


 -  **Name**. The name must be unique and will be used to locate your app. For example, webappces1.azurewebsites.net. You can map a custom domain name, if you prefer to use that instead.
 -  **Publish**. The App service can host either Code or a Docker Container.
 -  **Runtime stack**. The software stack to run the app, including the language and SDK versions. For Linux apps and custom container apps, you can also set an optional start-up command or file. Choices include: .NET Core, .NET Framework, Node.js, PHP, Python, and Ruby. Various versions of each are available.
 -  **Operating system**. Choices are Linux and Windows.
 -  **Region**. Your choice will affect app service plan availability.

## Application settings

Once your app service is created, additional configuration information is available.

:::image type="content" source="../media/web-app-configuration-27facdc5.png" alt-text="Screenshot of the app service configuration blade.":::


Certain configuration settings can be included in the developer's code or configurated in the app service. Here are a few interesting settings.

 -  **Always On**. Keep the app loaded even when there's no traffic. It's required for continuous WebJobs or for WebJobs that are triggered using a CRON expression.
 -  **ARR affinity**. In a multi-instance deployment, ensure that the client is routed to the same instance for the life of the session.
 -  **Connection strings**. Connection strings are encrypted at rest and transmitted over an encrypted channel.
