If you need to host your application on Azure, you might initially turn to a virtual machine (VM) or containers. Both VMs and containers provide excellent hosting solutions. VMs give you maximum control of the hosting environment and allow you to configure it exactly how you want. VMs also may be the most familiar hosting method if you’re new to the cloud. Containers, with the ability to isolate and individually manage different aspects of the hosting solution, can also be a robust and compelling option.

There are other hosting options that you can use with Azure, including Azure App Service.

:::image type="content" source="../media/application-hosting-spectrum.png" alt-text="Hosting spectrum from VMs with more control, to containers, to App Service with less operational effort.":::

## Azure App Service

App Service lets you build and host web apps, background jobs, mobile back-ends, and RESTful APIs in the programming language of your choice without managing infrastructure. It offers automatic scaling and high availability. App Service supports Windows and Linux and supports automated deployments from GitHub, Azure DevOps, or any Git repo for continuous deployment.

Azure App Service is an HTTP-based service for hosting web applications, REST APIs, and mobile back ends. It lets you focus on building and maintaining your app while Azure keeps the environment up and running. App Service supports multiple languages and frameworks, including .NET, .NET Core, Java, PHP, Python, and Node.js.

### Types of app services

With App Service, you can host most common app styles:

 -  Web apps
 -  API apps
 -  WebJobs
 -  Mobile apps

App Service handles most of the infrastructure decisions you deal with in hosting web-accessible apps:

 -  Deployment and management are integrated into the platform.
 -  Endpoints can be secured.
 -  Sites can be scaled quickly to handle high traffic loads.
 -  The built-in load balancing and traffic manager provide high availability.

All of these app styles are hosted in the same infrastructure and share these benefits. This flexibility makes App Service the ideal choice to host web-oriented applications.

### Web apps

App Service includes full support for hosting web apps by using ASP.NET, ASP.NET Core, Java, Ruby, Node.js, PHP, or Python. You can choose either Windows or Linux as the host operating system.

### API apps

Much like hosting a website, you can build REST-based web APIs by using your choice of language and framework. App Service provides full Swagger support and the ability to package and publish your API in Azure Marketplace. The published APIs can be consumed from any HTTP- or HTTPS-based client.

### WebJobs

You can use the WebJobs feature to run a program (.exe, Java, PHP, Python, or Node.js) or script (.cmd, .bat, PowerShell, or Bash) in the same context as a web app, API app, or mobile app. They can be scheduled or run by a trigger. WebJobs are often used to run background tasks as part of your application logic.

### Mobile apps

Use the Mobile Apps feature of App Service to quickly build a back end for iOS and Android apps. With just a few actions in the Azure portal, you can:

 -  Store mobile app data in a cloud-based SQL database.
 -  Authenticate customers against common social providers, such as MSA, Google, X, and Facebook.
 -  Send push notifications.
 -  Execute custom back-end logic in C\# or Node.js.

On the mobile app side, there's SDK support for native iOS and Android, Xamarin, and React Native apps.

