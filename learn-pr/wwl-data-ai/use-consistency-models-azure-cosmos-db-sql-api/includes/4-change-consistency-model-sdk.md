The **ItemRequestOptions** class contains configuration properties to modify a specific request. Using this class, you can relax the current default consistency level to a weaker one.

For example, a new variable illustrated here, named **options,** contains a **ConsistencyLevel** property configured to the weakest consistency level.

```csharp
ItemRequestOptions options = new()
{ 
    ConsistencyLevel = ConsistencyLevel.Eventual 
};
```

Now, the options variable can be added to any operation request. In this example, a request is made to add a new item to a container. The **CreateItemAsync** method has an extra parameter to accept the options variable.

```csharp
var item = new Product {
    id = $"{Guid.NewGuid()}",
    categoryId = $"{Guid.NewGuid()}",
    name = "Reflective Handlebar"
};
await container.CreateItemAsync<Product>(item, requestOptions: options);
```

> [!NOTE]
> The consistency level can only be relaxed on a per-request basis, not strengthened.
