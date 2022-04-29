The **ItemRequestOptions** class contains configuration properties to modify a specific request. Using this class, you can relax the current default consistency level to a weaker one.

For example, a new variable illustrated here, named **options,** contains a **ConsistencyLevel** property configured to the weakest consistency level.

```csharp
ItemRequestOptions options = new()
{ 
    ConsistencyLevel = ConsistencyLevel.Eventual 
};
```

Now, the options variable can be added to any operation request. In this example, a request is made to read an item from the container. The **ReadItemAsync** method has an extra parameter to accept the options variable.

```csharp
string id = "706cd7c6-db8b-41f9-aea2-0e0c7e8eb009";

string categoryId = "9603ca6c-9e28-4a02-9194-51cdb7fea816";
PartitionKey partitionKey = new (categoryId);

Product item = await container.ReadItemAsync<Product>(id, partitionKey, requestOptions: options);
```

> [!NOTE]
> The consistency level can only be relaxed on a per-request basis, not strengthened.

As an alternative, you can relax the consistency for the entire **CosmosClient** instance using the **CosmosClientOptions** class.

```csharp
CosmosClientOptions options = new()
{
    ConsistencyLevel = ConsistencyLevel.Eventual 
};

CosmosClient client = new (endpoint, key, options);
```
