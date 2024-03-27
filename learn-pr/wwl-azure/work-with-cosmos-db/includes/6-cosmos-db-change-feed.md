Change feed in Azure Cosmos DB is a persistent record of changes to a container in the order they occur. Change feed support in Azure Cosmos DB works by listening to an Azure Cosmos DB container for any changes. It then outputs the sorted list of documents that were changed in the order in which they were modified. The persisted changes can be processed asynchronously and incrementally, and the output can be distributed across one or more consumers for parallel processing.

## Change feed and different operations

Today, you see all inserts and updates in the change feed. You can't filter the change feed for a specific type of operation. Currently change feed doesn't log delete operations. As a workaround, you can add a soft marker on the items that are being deleted. For example, you can add an attribute in the item called "deleted," set its value to "true," and then set a time-to-live (TTL) value on the item. Setting the TTL ensures that the item is automatically deleted.

## Reading Azure Cosmos DB change feed

You can work with the Azure Cosmos DB change feed using either a push model or a pull model. With a push model, the change feed processor pushes work to a client that has business logic for processing this work. However, the complexity in checking for work and storing state for the last processed work is handled within the change feed processor.

With a pull model, the client has to pull the work from the server. The client, in this case, not only has business logic for processing work but also storing state for the last processed work, handling load balancing across multiple clients processing work in parallel, and handling errors.

> [!NOTE]
> It is recommended to use the push model because you won't need to worry about polling the change feed for future changes, storing state for the last processed change, and other benefits.

Most scenarios that use the Azure Cosmos DB change feed use one of the push model options. However, there are some scenarios where you might want the additional low level control of the pull model. These include:

* Reading changes from a particular partition key
* Controlling the pace at which your client receives changes for processing
* Doing a one-time read of the existing data in the change feed (for example, to do a data migration)

## Reading change feed with a push model

There are two ways you can read from the change feed with a push model: Azure Functions Azure Cosmos DB triggers, and the change feed processor library. Azure Functions uses the change feed processor behind the scenes, so these are both similar ways to read the change feed. Think of Azure Functions as simply a hosting platform for the change feed processor, not an entirely different way of reading the change feed. Azure Functions uses the change feed processor behind the scenes, it automatically parallelizes change processing across your container's partitions.

### Azure Functions

You can create small reactive Azure Functions that will be automatically triggered on each new event in your Azure Cosmos DB container's change feed. With the [Azure Functions trigger for Azure Cosmos DB](/azure/azure-functions/functions-bindings-cosmosdb-v2-trigger), you can use the Change Feed Processor's scaling and reliable event detection functionality without the need to maintain any worker infrastructure.

:::image type="content" source="../media/functions-change-feed.png" alt-text="Diagram showing the change feed triggering Azure Functions for processing.":::

### Change feed processor

The change feed processor is part of the Azure Cosmos DB [.NET V3](https://github.com/Azure/azure-cosmos-dotnet-v3) and [Java V4](https://github.com/Azure/azure-sdk-for-java/tree/main/sdk/cosmos/azure-cosmos) SDKs. It simplifies the process of reading the change feed and distributes the event processing across multiple consumers effectively.

There are four main components of implementing the change feed processor:

1. **The monitored container**: The monitored container has the data from which the change feed is generated. Any inserts and updates to the monitored container are reflected in the change feed of the container.

1. **The lease container**: The lease container acts as a state storage and coordinates processing the change feed across multiple workers. The lease container can be stored in the same account as the monitored container or in a separate account.

1. **The compute instance**: A compute instance hosts the change feed processor to listen for changes. Depending on the platform, it could be represented by a VM, a kubernetes pod, an Azure App Service instance, an actual physical machine. It has a unique identifier referenced as the instance name throughout this article.

1. **The delegate**: The delegate is the code that defines what you, the developer, want to do with each batch of changes that the change feed processor reads.

When implementing the change feed processor the point of entry is always the monitored container, from a `Container` instance you call `GetChangeFeedProcessorBuilder`:

```csharp
/// <summary>
/// Start the Change Feed Processor to listen for changes and process them with the HandleChangesAsync implementation.
/// </summary>
private static async Task<ChangeFeedProcessor> StartChangeFeedProcessorAsync(
    CosmosClient cosmosClient,
    IConfiguration configuration)
{
    string databaseName = configuration["SourceDatabaseName"];
    string sourceContainerName = configuration["SourceContainerName"];
    string leaseContainerName = configuration["LeasesContainerName"];

    Container leaseContainer = cosmosClient.GetContainer(databaseName, leaseContainerName);
    ChangeFeedProcessor changeFeedProcessor = cosmosClient.GetContainer(databaseName, sourceContainerName)
        .GetChangeFeedProcessorBuilder<ToDoItem>(processorName: "changeFeedSample", onChangesDelegate: HandleChangesAsync)
            .WithInstanceName("consoleHost")
            .WithLeaseContainer(leaseContainer)
            .Build();

    Console.WriteLine("Starting Change Feed Processor...");
    await changeFeedProcessor.StartAsync();
    Console.WriteLine("Change Feed Processor started.");
    return changeFeedProcessor;
}
```

Where the first parameter is a distinct name that describes the goal of this processor and the second name is the delegate implementation that will handle changes. Following is an example of a delegate:

```csharp
/// <summary>
/// The delegate receives batches of changes as they are generated in the change feed and can process them.
/// </summary>
static async Task HandleChangesAsync(
    ChangeFeedProcessorContext context,
    IReadOnlyCollection<ToDoItem> changes,
    CancellationToken cancellationToken)
{
    Console.WriteLine($"Started handling changes for lease {context.LeaseToken}...");
    Console.WriteLine($"Change Feed request consumed {context.Headers.RequestCharge} RU.");
    // SessionToken if needed to enforce Session consistency on another client instance
    Console.WriteLine($"SessionToken ${context.Headers.Session}");

    // We may want to track any operation's Diagnostics that took longer than some threshold
    if (context.Diagnostics.GetClientElapsedTime() > TimeSpan.FromSeconds(1))
    {
        Console.WriteLine($"Change Feed request took longer than expected. Diagnostics:" + context.Diagnostics.ToString());
    }

    foreach (ToDoItem item in changes)
    {
        Console.WriteLine($"Detected operation for item with id {item.id}, created at {item.creationTime}.");
        // Simulate some asynchronous operation
        await Task.Delay(10);
    }

    Console.WriteLine("Finished handling changes.");
}
```

Afterwards, you define the compute instance name or unique identifier with `WithInstanceName`, this should be unique and different in each compute instance you're deploying, and finally, which is the container to maintain the lease state with `WithLeaseContainer`.

Calling `Build` gives you the processor instance that you can start by calling `StartAsync`.

The normal life cycle of a host instance is:

1. Read the change feed.
1. If there are no changes, sleep for a predefined amount of time (customizable with `WithPollInterval` in the `Builder`) and go to #1.
1. If there are changes, send them to the delegate.
1. When the delegate finishes processing the changes successfully, update the lease store with the latest processed point in time and go to #1.
