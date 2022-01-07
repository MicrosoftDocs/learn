The change feed processor is created in a few steps:

1. Get the processor builder from the monitored (source) container variable
1. Use the builder to build-out the processor by specifying the delegate, processor name, lease container, and host instance name
1. Start the processor

First, you should create an instance of **Microsoft.Azure.Cosmos.Container** for both the source and lease container.

```csharp
Container sourceContainer = client.GetContainer("cosmicworks", "products");

Container leaseContainer = client.GetContainer("cosmicworks", "productslease");
```

Next, you can use the **GetChangeFeedProcessorBuilder** method from a container instance to create a builder. At this point, you should specify the name of the processor and the delegate to handle each batch of changes.

```csharp
var builder = sourceContainer.GetChangeFeedProcessorBuilder<Product>(
    processorName: "productItemProcessor",
    onChangesDelegate: changeHandlerDelegate
);
```

The builder ships with a series of fluent methods to configure the processor that includes, but is not limited to:

| **Method** | **Description** |
| ---: | :--- |
| **WithInstanceName** | Name of host instance |
| **WithStartTime** | Set the pointer (in time) to start looking for changes after |
| **WithLeaseContainer** | Configures the lease container |
| **WithErrorNotification** | Assigns a delegate to handle errors during execution |
| **WithMaxItems** | Quantifies the max number of items in each batch |
| **WithPollInterval** | Sets the delay when the processor will poll the change feed for new changes |

A simple example would be to configure the instance name using **WithInstanceName**, the lease container using **WithLeaseContainer**, and then **Build** the change feed processor.

```csharp
ChangeFeedProcessor processor = builder
    .WithInstanceName("desktopApplication")
    .WithLeaseContainer(leaseContainer)
    .Build();
```

The resulting change feed processor includes both **StartAsync** and **StopAsync** methods to run and terminate the processor asynchronously.

```csharp
await processor.StartAsync();

// Wait while processor handles items

await processor.StopAsync();
```
