As the change feed processor handles changes, it functions as a time-based pointer. The pointer moves forward in time across the change feed and sends batches of changes to the delegate to run business logic.

The change feed processor can potentially be constrained by the physical resources of the host application. If so, it’s almost immediately assumed that the change feed processor should be scaled out across multiple hosts, all reading from the change feed concurrently.

However, identifying if your change feed solution needs to scale out can be difficult and requires an estimator feature. The change feed estimator is a sidecar feature to the processor that measures the number of changes that are pending to be read by the processor at any point in time.

To implement the estimator, you must first analyze the processor. In this example, a processor is created with a specific lease container and a delegate to handle changes.

```csharp
Container sourceContainer = client.GetContainer("cosmicworks", "products");

Container leaseContainer = client.GetContainer("cosmicworks", "productslease");

ChangeFeedProcessor processor = sourceContainer.GetChangeFeedProcessorBuilder<Product>(
    processorName: "productItemProcessor",
    onChangesDelegate: changeHandlerDelegate)
    .WithInstanceName("desktopApplication")
    .WithLeaseContainer(leaseContainer)
    .Build();
```

Next, you should implement a delegate to using the type **ChangesEstimationHandler** to handle each time the estimator polls the change feed to see how many changes have not been processed yet.

```csharp
ChangesEstimationHandler changeEstimationDelegate = async (
    long estimation, 
    CancellationToken cancellationToken
) => {
    // Do something with the estimation
};
```

Finally, you build the estimator in a manner similar to the processor reusing the same lease container.

```csharp
ChangeFeedProcessor estimator = sourceContainer.GetChangeFeedEstimatorBuilder(
    processorName: "productItemEstimator",
    estimationDelegate: changeEstimationDelegate)
    .WithLeaseContainer(leaseContainer)
    .Build();
```
