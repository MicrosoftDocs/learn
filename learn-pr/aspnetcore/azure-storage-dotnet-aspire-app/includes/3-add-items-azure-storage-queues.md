Azure Storage accounts don't only store blobs; they also enable developers to create and manage message queues and tables of data entities. You can use a message queue to increase the reliability of communications between microservices and ensure that your app handles service outages and periods of peak demand robustly.

In the outdoor equipment retailer you work for, two of your microservice teams have implemented Azure Storage accounts to serve blobs to users. However, stress testing has identified a potential issue with microservice communications at times of high load. You want to investigate whether queues in Azure Storage accounts can help resolve the problem.

In this unit, you'll learn about the .NET Aspire Azure Queue Storage component and how you can use it to communicate between microservices in a cloud-native app.

## Why use Azure Queue Storage?

Cloud-native apps are composed of microservices that run in containers. Each microservice is loosely coupled to the others and developed by separate teams on independent bug fixing and upgrade schedules. However, to create a complete response to a user request, each microservice must communicate with one or more of the others, for example to find out about products, place an order, or authenticate users.

Each microservice implements an Application Programming Interface (API), usually conforming to Representational State Transfer (REST) standards, that others can use to call its functions. Microservices can call these REST interfaces directly, but this approach can struggle with reliability:

- What happens if the destination microservice instance is unavailable? Are requests lost?
- What happens if there's a large increase in user demand? Are requests satisfied in an orderly and reliable fashion?

You can use a message queue to help with these concerns. Instead of calling the destination microservice directly, a source microservice places a message in a queue. The destination retrieves these messages one at a time from the queue and processes each one before sending a reply.

If the destination microservice is temporarily unavailable, messages wait in the queue until it recovers. If user load peaks, the queue may build up but no messages are lost. In both cases, no messages are lost although the sending service may have to wait longer for a response. Using queues increases the robustness of your cloud-native app and you should consider it for business-critical transactions, such as taking payments or updating stock numbers.

> [!NOTE]
> Azure Queue Storage provides simple queues without message distribution or complex filtering and routing options. If your queuing needs are complex, consider RabbitMQ for messaging queuing hosted outside of Azure, or Azure Service Bus, for message queuing in Azure.

## Using Azure Queue Storage with .NET Aspire

If you're using .NET Aspire to build a cloud-native app, you can add the **.NET Aspire Azure Queue Storage component** to work with Azure storage queues. The component registers a `QueueServiceClient` object in the dependency injection container maintained by the app host project. When you pass that object to consuming microservices, you can use it to create queues and send or receive messages.

### Modifying the app host Project

As for the blob client, you must install the `Aspire.Hosting.Azure.Storage` package in the app host project:

```dotnetcli
dotnet add package Aspire.Hosting.Azure.Storage
```

Then, register the Azure Queue Storage component:

```csharp
var queues = builder.AddAzureStorage("storage")
    .AddQueues("queues");
```

Now, you can pass the service to each microservice that consumes it:

```csharp
var catalogMicroservice = builder.AddProject<Projects.CatalogMicroservice>()
    .WithReference(queues);
```

### Modifying the consuming projects

In a microservice where you want to send or receive messages, you must first install the component:

```dotnetcli
dotnet add package Aspire.Azure.Storage.Queues
```

In the _Program.cs_ file, register a `QueueServiceClient` object in the dependency injection container:

```csharp
builder.AddAzureQueueClient("queues");
```

Now, you can use dependency injection to obtain a `QueueServiceClient` object, when you want to send or receive messages:

```csharp
public class CatalogService(QueueServiceClient client)
{
    // Use the client object to send and receive messages.
}
```

### Sending messages

The `QueueServiceClient` object represents a connection to an Azure Queue Storage account, which can contain multiple queues. To get a specific queue, use the `GetQueueClient()` method:

```csharp
QueueClient authQueue = client.GetQueueClient("AuthenticationRequests");
```

Now, you can send a message:

```csharp
await authQueue.SendMessageAsync("UserName: user1 Password: secret");
```

To get messages, use the `ReceiveMessagesAsync()` method to get a list of messages:

```csharp
QueueMessage[] messages = await authQueue.ReceiveMessagesAsync(maxMessages: 5);

for each (QueueMessage message in messages)
{
    // Process each message here.
}
```

### Configuring the connection to the Storage account

When you register the Azure Queue Service client in the consuming microservice, you use this code:

```csharp
builder.AddAzureQueueClient("queues");
```

The string you pass to this method is the name of a connection string. You should store this connection string in one of the project's app settings files:

```json
{
  "ConnectionStrings": {
    "queues": "https://{account_name}.queue.core.windows.net/"
  }
}
```

## Learn more

- [.NET Aspire Azure Queue Storage component](/dotnet/aspire/storage/azure-storage-queues-component)
- [Azure Storage Queues client library for .NET](/dotnet/api/overview/azure/storage.queues-readme)
- [Quickstart: Azure Queue Storage client library for .NET](/azure/storage/queues/storage-quickstart-queues-dotnet)
