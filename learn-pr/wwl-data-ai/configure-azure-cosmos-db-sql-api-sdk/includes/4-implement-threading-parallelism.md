::: zone pivot="csharp"

While the SDK implements thread-safe types and some degrees of parallelism, there are best practices that you can implement in your application code to ensure that the SDK has the best performance it can possibly have in your workload.

## Avoid resource-related time-outs

Many times request time-outs occur due to high CPU or port utilization on client machines rather than a service-side issue. It's important to monitor resource utilization on client machines and scale-out appropriately to avoid SDK errors or retries due to local resource exhaustion.

## Use async/await in .NET

The C# language in .NET has a series of Task-based features to asynchronously invoke SDK client methods. For example, the **CreateDatabaseIfNotExistsAsync** method is invoked asynchronously using the following syntax.

```csharp
Database database = await client.CreateDatabaseIfNotExistsAsync("cosmicworks");
```

This syntax uses the **awaited** keyword to run the task asynchronously and return the result into the indicated variable. Using the asynchronous keywords allows the SDK to manage requests simultaneously in an efficient manner.

Avoid blocking the asynchronous execution using **Task.Wait** or **Task.Result** such as in the following example code.

```csharp
Database database = client.CreateDatabaseIfNotExistsAsync("cosmicworks").Result;
```

## Use built-in iterators instead of LINQ methods

LINQ methods such as **ToList** eagerly and synchronously drain a query while blocking any other calls from executing. For example, this invocation of ToList() blocks all other calls and potentially retrieve a large set of data:

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

When you're issuing a query from the SDK, the **QueryRequestOptions** includes a set of properties to tune a query's performance.

### Max item count

All query results in Azure Cosmos DB for NoSQL are returned as "pages" of results. This property indicates the number of items you would like to return in each "page". The service default is 100 items per page of results. You can set this value to **-1** to set a dynamic page size.

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

The **MaxBufferedItemCount** property sets the maximum number of items that are buffered client-side during a parallel query execution. If set to **-1**, the SDK manages this setting. The ideal value for this setting largely depends on the characteristics of your client machine.

In this example, the **MaxBufferedItemCount** property is set to a value of **5,000**.

```csharp
QueryRequestOptions options = new ()
{
    MaxBufferedItemCount = 5000
};
```

::: zone-end

::: zone pivot="python"

There are several best practices and options you can implement in your Python application when using the Azure Cosmos DB Python SDK to ensure optimal performance for your workloads.

## Avoid resource-related time-outs

Many request time-outs occur due to high CPU or resource utilization on client machines, rather than issues happening on the Azure Cosmos DB service side. Monitor resource usage on client machines, and scale out your application appropriately to avoid SDK errors or retries due to local resource exhaustion.

## Use asynchronous queries

The Azure Cosmos DB Python SDK supports asynchronous operations through Python's `asyncio` framework and provides classes for asynchronous programming under the [``azure.cosmos.aio``](/python/api/azure-cosmos/azure.cosmos.aio) namespace. For example, you can use the `query_items` method asynchronously:

```python
from azure.cosmos.aio import CosmosClient
import asyncio

endpoint = "<cosmos-endpoint>"
key = "<cosmos-key>"

client = CosmosClient(endpoint, key)

async def query_items_async(client):
    # Get database and container clients
    database = client.get_database_client("cosmicworks")
    container = database.get_container_client("products")

    # Define the query and parameters
    query = "SELECT * FROM c WHERE c.categoryId = @categoryId"
    parameters = [{"name": "@categoryId", "value": "bikes"}]

    # Perform the query asynchronously
    async for item in container.query_items(
        query=query,
        parameters=parameters
    ):
        print(item)
    
    # Close the client
    await client.close()

asyncio.run(query_items_async(client))
```

Before you use the ``azure.cosmos.aio`` classes for asynchronous operations, ensure that you installed the ``aiohttp`` library (``pip install aiohttp``).

Using `asyncio` ensures that multiple operations can be handled concurrently without blocking the execution of other code.

Avoid blocking asynchronous execution by improperly mixing synchronous and asynchronous methods, such as:

```python
iterator = client.query_items(query=query, parameters=parameters).result()  # Incorrect
```

Instead, always use `await` for asynchronous calls.

## Use iterators for queries

The Python SDK includes built-in iterators to retrieve query results efficiently without blocking other operations. Avoid collecting all query results eagerly, as it can result in large memory usage and block other operations.

### Inefficient example:

```python
results = list(container.query_items(
    query="SELECT * FROM c WHERE c.categoryId = 'bikes'"
))
```

### Efficient example using an iterator:

```python
iterator = container.query_items(
    query="SELECT * FROM c WHERE c.categoryId = 'bikes'"
)

async for item in iterator:
    print(item)
```

Using iterators allows you to handle data in a memory-efficient manner and process results as they arrive.

## Configure query options for performance

When you're issuing a query, the Python SDK allows you to configure several options via the `QueryIterable` or `query_items` methods to improve performance.

### Max item count

All query results in Azure Cosmos DB for NoSQL are returned in "pages" of results. The `max_item_count` parameter specifies the number of items to return in each page. The service default is 100 items per page.

Example with a `max_item_count` of 500:

```python
iterator = container.query_items(
    query="SELECT * FROM c",
    max_item_count=500
)
```

> [!TIP]
> If you use a `max_item_count` of `-1`, ensure the total response size doesn't exceed the service limit of 4 MB.

### Partition key usage

Whenever possible, include the partition key in your query filter. This partition key reduces the query scope to a single partition, improving performance significantly.

Example:

```python
iterator = container.query_items(
    query="SELECT * FROM c WHERE c.categoryId = @categoryId",
    parameters=[{"name": "@categoryId", "value": "bikes"}],
    partition_key="bikes"
)
```

## Perform batch operations

The Python SDK allows batch operations on items within the same partition key. Use the `TransactionalBatch` class to perform multiple operations atomically.

Example:

```python
# Define the partition key and batch operations
partition_key = "socks"
batch = [
    ("create", ({"id": "sock7", "categoryId": partition_key, "name": "Red Racing Socks"},)),
    ("create", ({"id": "sock8", "categoryId": partition_key, "name": "White Racing Socks"},))
]

# Execute the batch
batch_response = container.execute_item_batch(batch, partition_key=partition_key)

# Print the resource body results to see the created items
for result in batch_response:
    print(result.get("resourceBody"))
```

> [!NOTE]
> Batch operations must target a single partition key and can include up to 100 operations or 4 MB in size.

::: zone-end

::: zone pivot="node"

There are several best practices and options you can implement in your application when using the Azure Cosmos DB JavaScript SDK to ensure optimal performance for your workloads.

## Avoid resource-related time-outs

Request time-outs often occur due to high CPU or resource utilization on client machines rather than service-side issues. Monitor resource usage on client machines, and scale out your application appropriately to avoid SDK errors or retries caused by local resource exhaustion.

## Use asynchronous queries

The Azure Cosmos DB JavaScript SDK supports asynchronous operations using Promises and `async/await`. For example, you can use the `createDatabaseIfNotExists` method asynchronously:

```javascript
const { CosmosClient } = require("@azure/cosmos");

const client = new CosmosClient({ endpoint: "<cosmos-endpoint>", key: "<cosmos-key>" });

async function createDatabase() {
    const { database } = await client.databases.createIfNotExists({ id: "cosmicworks" });
    console.log(`Database created: ${database.id}`);
}
createDatabase();
```

Using `async/await` ensures nonblocking operations and allows the SDK to handle multiple requests efficiently.

Avoid blocking asynchronous execution by improperly using `.then()` or `.catch()` in a way that hinders performance.

## Use iterators for queries

The JavaScript SDK includes built-in iterators to retrieve query results efficiently without blocking other operations. Avoid eagerly collecting all query results, as it can consume a large amount of memory and block other operations.

### Inefficient example

```javascript
const results = await container.items
    .query("SELECT * FROM c WHERE c.categoryId = 2", { enableCrossPartitionQuery: true })
    .fetchAll();
console.log(results.resources);
```

### Efficient example using an iterator

```javascript
const iterator = container.items.query(
    "SELECT * FROM c WHERE c.categoryId = 2",
    { enableCrossPartitionQuery: true }
);

while (iterator.hasMoreResults()) {
    const { resources } = await iterator.fetchNext();
    for (const item of resources) {
        console.log(item);
    }
}
```

Using iterators allows you to process results in smaller batches, which reduce memory usage and improves efficiency.

## Configure query options for performance

When you're issuing a query, the JavaScript SDK allows you to configure several options via the `query` method to improve performance.

### Max item count

All query results in Azure Cosmos DB for NoSQL are returned in "pages" of results. The `maxItemCount` parameter specifies the number of items to return in each page. The service default is 100 items per page.

Example with a `maxItemCount` of 500:

```javascript
const iterator = container.items.query(
    "SELECT * FROM c",
    { maxItemCount: 500, enableCrossPartitionQuery: true }
);
```

> [!TIP]
> If you use a `maxItemCount` of `-1`, ensure the total response size doesn't exceed the service limit of 4 MB.

### Partition key usage

Whenever possible, include the partition key in your query filter. This partition key reduces the query scope to a single partition, improving performance significantly.

Example:

```javascript
const iterator = container.items.query(
    {
        query: "SELECT * FROM c WHERE c.categoryId = @categoryId",
        parameters: [{ name: "@categoryId", value: "socks" }]
    },
    { partitionKey: "socks" }
);
```

Since ``categoryId`` is also the partition key, you can also use the shorthand syntax:

```javascript
const iterator = container.items.query(
    {
        query: "SELECT * FROM c"
    },
    { partitionKey: "socks" }
);
```

## Perform batch operations

The JavaScript SDK allows batch operations on items within the same partition key. Use the `container.items.batch` method to perform multiple operations atomically.

Example:

```javascript
const { CosmosClient, BulkOperationType } = require("@azure/cosmos");

const partitionKey = "bikes";
    const operations = [
        {
            operationType: BulkOperationType.Create,
            resourceBody: {
                id: "rb3k",
                name: "Road Bike 3000",
                description: "This is a very fast road bike.",
                categoryId: "bikes"
            }
        },
        {
            operationType: BulkOperationType.Create,
            resourceBody: {
                id: "mb2k",
                name: "Mountain Bike 2000",
                description: "This is a capable and sturdy mountain bike.",
                categoryId: "bikes"
            }
        },
        {
            operationType: BulkOperationType.Create,
            resourceBody: {
                id: "tb1k",
                name: "Touring Bike 1000",
                description: "This is a casual touring bike.",
                categoryId: "bikes"
            }
        }
    ];

    const response = await container.items
        .bulk(operations, { partitionKey });
    console.log(response);
```

> [!NOTE]
> Batch operations must target a single partition key and can include up to 100 operations or 2 MB in size.

::: zone-end

> [!NOTE]
> These settings are explored in more detail in other Azure Cosmos DB for NoSQL modules on issuing queries using the SDK.
