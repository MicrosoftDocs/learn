Azure App Service is a highly scalable platform that you can use to host web applications. Each web app runs on one or more web servers, and App Service distributes users' requests across these servers. As the volume of requests varies over time, App Service scales out and back in, increasing and decreasing the number of servers available. This scaling strategy helps to ensure that response times and costs remain acceptable, even as the workload fluctuates.

Many older web applications depend on retaining session state information between a user's requests. Often this state information is held in memory on the web server. However, this approach won't work effectively if you're migrating a web app that follows this strategy to Azure App Service. You can't guarantee that all requests from a user will be routed to the same web server. 

You might try to implement *sticky sessions*, which maintain the affinity between a web server and the user's session. This scheme can affect scalability, though. The load between servers can become unbalanced, and you risk losing the elasticity of being able to scale in and out as the workload changes.

In this module, you'll learn how to implement scalable sessions in an ASP.NET web application that you want to deploy to Azure App Service.

The scenario in this module revolves around an existing .NET Framework web application that runs on-premises. You'll start by migrating this application to Azure App Service. Next, you'll modify the way in which session data is stored, to enable the web application to store and retrieve session data in Azure App Service.

## Learning objectives

By the end of this module, you'll be able to configure ASP.NET to store session data by using Azure Cache for Redis.

## Prerequisites

- Some C# programming experience
- Familiarity with ASP.NET development
- A development environment that has Windows 10 and Visual Studio 2019 with the latest updates
- Git for Windows installed on your desktop 


