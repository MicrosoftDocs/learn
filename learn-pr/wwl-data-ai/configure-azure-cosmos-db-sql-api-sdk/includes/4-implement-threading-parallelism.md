While the SDK implements thread-safe types and some degrees of parallelism, there are best practices that you can implement in your application code to ensure that the SDK has the best performance it can possibly have in your workload.

## Avoid resource-related timeouts

Many times request timeouts occur due to high CPU or port utilization on client machines rather than a service-side issue. It is important to monitor resource utilization on client machines and scale-out appropriately to avoid SDK errors are retries due to local resource exhaustion.

## Use async/await in .NET

The C# language in .NET has a series of Task-based features to asynchronously invoke SDK client methods. For example, the **CreateDatabaseIfNotExistsAsync** method is invoked asynchronously using the following syntax.

```csharp
Database database = await client.CreateDatabaseIfNotExistsAsync("cosmicworks");
```

This syntax uses the **await** keyword to run the task asynchronously and return the result into the indicated variable. Using the asynchronous keywords allows the SDK to manage requests simultaneously in a efficient manner.

Avoid blocking the asynchronous execution using **Task.Wait** or **Task.Result** such as in the example code below.

```csharp
Database database = client.CreateDatabaseIfNotExistsAsync("cosmicworks").Result;
```

## Use built-in iterators instead of LINQ methods

LINQ methods such as **ToList** will eagerly and synchronously drain a query while blocking any other calls from executing. For example, this invocation of ToList() will block all other calls and potentially retrieve a large set of data:

```csharp
container.GetItemLinqQueryable<T>()
    .Where(i => i.categoryId == 2)
    .ToList<T>();
```

The SDK includes methods such as **ToFeedIterator\<T\>** that asynchronously retrieves the results of a query without blocking other calls. This example illustrates the same scenario but using the special iterator instead of **ToList**.

```csharp
container.GetItemLinqQueryable<T>()
    .Where(i => i.categoryId == 2)
    .ToFeedIterator<T>();
```

## Configure max concurrency, parallelism, and buffered item count

When issuing a query from the SDK, the **QueryRequestOptions** includes a set of properties to tune a query's performance.

### Max item count

All query results in Azure Cosmos DB SQL API are returned as "pages" of results. This property indicates the number of items you would like to return in each "page". The service default is 100 items per page of results. You can set this value to **-1** to set a dynamic page size.

In this example, the **MaxItemCount** property is set to a value of **500**.

```csharp
QueryRequestOptions options = new ()
{
    MaxItemCount = 500
};
```

> [!TIP]
> If you use a **MaxItemCount** of -1, you should ensure the total response doesn't exceed the service limit for response size. For instance, the max response size is 4 MB.

### Max concurrency

**MaxConcurrency** specifies the number of concurrent operations ran client side during parallel query execution. If set to **1**, parallelism is effectively disabled. If set to **-1**, the SDK manages this setting. Ideally, you would set this value to the number of physical partitions for your container.

In this example, the **MaxConcurrency** property is set to a value of **5**.

```csharp
QueryRequestOptions options = new ()
{
    MaxConcurrency = 5
};
```

### Max buffered item count

The **MaxBufferedItemCount** property sets the maximum number of items that are buffered client-side during a parallel query execution. If set to **-1**, the SDK manages this setting. The ideal value for this setting will largely depend on the characteristics of your client machine.

In this example, the **MaxBufferedItemCount** property is set to a value of **5,000**.

```csharp
QueryRequestOptions options = new ()
{
    MaxBufferedItemCount = 5000
};
```

> [!NOTE]
> These settings are explored much deeper in other Azure Cosmos DB SQL API modules on issuing queries using the SDK.
