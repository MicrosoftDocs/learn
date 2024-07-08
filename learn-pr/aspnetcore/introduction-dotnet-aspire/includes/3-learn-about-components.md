Although each microservice in your app is likely to be unique, they frequently have similar requirements for backing services such as databases and caches. It can be challenging to write code in each microservice that interfaces with these backing services. In .NET Aspire, that code is reduced as you instead add a .NET Aspire component. There are built-in components for many commonly backing requirements that you're likely to need in microservices.

Imagine you work for an outdoor clothing and equipment company. Your development teams have begun to design their microservices for the new eShop web app. Each microservice may need services such as databases, messaging services, and caches. You want to assess how .NET Aspire can help interact with these services.

In this unit, you'll learn about the components that are included in .NET Aspire out-of-the-box and how to choose the best component for your microservice.

## Use .NET Aspire components

Each .NET Aspire component is a NuGet package, and you can add it to your project using the NuGet package manager. In Visual Studio, there is a new **Add > .NET Aspire component** menu item. This action displays the package manager with a filter applied to display only .NET Aspire components:

:::image type="content" source="../media/add-component.png" lightbox="../media/add-component.png" alt-text="Screenshot showing the NuGet package manager in Visual Studio displaying .NET Aspire components.":::

> [!NOTE]
> You'll see how to use this component tools in the exercise later in this module.

Alternatively, the .NET CLI can add .NET components. For example:

```dotnetcli
dotnet add package Aspire.StackExchange.Redis --prerelease
```

In the **AppHost** project, you must register the component and consume it in the projects that call it:

```csharp
var cache = builder.AddRedis("cache");

builder.AddProject<Projects.AspireSample_Web>("webfrontend")
    .WithReference(cache);
```

Then you can use dependency injection to add it to the consuming project:

```csharp
build.AddRedisClient("cache");
```

Other usage code varies depending on the component you're using.

> [!NOTE]
> Each .NET Aspire component type usually has an equivalent hosting package. Hosting packages configure the resources and dependencies that the app requires and you install them in the **AppHost** project, not the consuming project.

## Database components

In cloud-native apps, each microservice is responsible for storing its own data and may need a database of structured or semi-structured data to read from and write to. Since each microservice is developed independently, you might find that several different database systems are in use by different parts of your complete application.

.NET Aspire includes components for the following relational database servers:

- **PostgreSQL**: A popular, open-source database server with an implementation of the Structured Query Language (SQL).
- **MySQL**: Another open-source SQL database server.
- **SQL Database**: Microsoft's SQL database system. 

> [!NOTE]
> The .NET Aspire SQL Database component can work with Microsoft SQL Server or Azure SQL Database, which is an implementation of SQL Server in the Azure cloud. Similarly, Azure includes Platform-as-a-Service (PaaS) implementations of PostgreSQL and MySQL. The location where you run a database is a decision for each microservice architecture team but .NET Aspire components can support many cloud locations and don't enforce any particular hosting service.

If you want to work with semi-structured data, .NET Aspire includes supports for these NoSQL systems:

- **MongoDB**: A cross-platform, document-oriented, NoSQL database server.
- **Azure Cosmos DB**: Microsoft's flexible NoSQL database system, hosted in Azure.

## Storage components

In .NET Aspire, the storage components are provided for microservices that need to store files, data, or messages in Azure Storage accounts. There's one component for each of the three services in Azure Storage. Choose your component according to what you want to do with Azure Storage:

- **Azure Blob Storage**: Use this service to store and retrieve blob files, such as images and videos.
- **Azure Table Storage**: Use this service to store and retrieve rows in semi-structure data tables.
- **Azure Queue Storage**: Use this service to add messages to queues for distribution to other subscribing microservices.

## Messaging components

One way to improve the reliability and flexibility of communications between microservices in a cloud-native app is to use messaging solutions that provide queues, topics, and subscriptions instead of direct communications. .NET Aspire includes components for the following three messaging services. Choose the component based on the messaging broker your developer want to use:

- **RabbitMQ**: This message broker is widely used, open-source, and supports several messaging protocols to provide, queues, topics, and subscriptions.
- **Apache Kafka**: This service processes streams of events, which can include messages, and includes the Kafka Connect API to import and export data to and from other systems.
- **Azure Service Bus**: This message broker is hosted in Azure and provides queues and subscription-based message distribution.

## Caching components

When a microservice receives a request from a user or another microservice, it might need to construct a response using data from multiple locations or complex operations. This operation can take time. By caching parts of such responses, you can save time later when similar or identical requests arrive. In this way, caching optimizes performance.

One popular cache service is Redis. It has message broker and in-memory database functionality but is most commonly used to cache responses in web applications and services. .NET Aspire has three different components that work with Redis. Choose a component based on the caching task you want to achieve in your microservice:

- **Redis component**: Use this component when you want to use Redis as an in-memory database.
- **Redis Output Caching component**: Use this component when you want to cache complete HTTP responses, such as entire web pages.
- **Redis Distributed Cache component**: Use this component when you want to create a single cache for multiple microservices in your app.

## Security

In a cloud-native application, data security is often a business-critical topic. Because your customers may be trusting you with personal and sensitive data, you must ensure that it's encrypted and protected against interception or tampering. Digital signatures and encryption require you to store private keys and retrieve them for decryption. Azure Key Vault is one location where you can securely store keys and other secrets such as passwords and certificates. 

.NET Aspire includes the Azure Key Vault component so that you can easily store and retrieve secrets in the Azure Key Vault.

## Learn more

- [.NET Aspire Components](/dotnet/aspire/get-started/aspire-overview#net-aspire-components)
