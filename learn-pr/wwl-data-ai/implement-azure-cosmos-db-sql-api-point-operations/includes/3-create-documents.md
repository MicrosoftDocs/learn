To create a new item, we must first create a new variable in C# code of the **Product** type.

```csharp
Product saddle = new()
{
    id = "027D0B9A-F9D9-4C96-8213-C8546C4AAE71",
    categoryId = "26C74104-40BC-4541-8EF5-9892F7F03D72",
    name = "LL Road Seat/Saddle",
    price = 27.12d,
    tags = new string[] 
    {
        "brown",
        "weathered"
    }
};
```

Let’s infer there’s already a variable of type Microsoft.Azure.Cosmos.**Container** named **container**.

We can asynchronously invoke the **CreateItemAsync\<\>** method passing in the generic Product type and the new item variable into the constructor.

```csharp
await container.CreateItemAsync<Product>(saddle);
```

This invocation of the method will create the new item, but you will not have any metadata about the result of the operation. Alternatively, you can store the result of the operation in a variable of type **ItemResponse\<\>**.

```csharp
ItemResponse<Product> response = await container.CreateItemAsync<Product>(saddle);

HttpStatusCode status = response.StatusCode;
double requestUnits = response.RequestCharge;

Product item = response.Resource;
```

If you are using a try-catch block, you can handle the **CosmosException** type, which includes a **StatusCode** property for HTTP status code values. There are a few common HTTP status codes that you should consider in your application code:

| Code | Title | Reason |
| :---: | :--- | :--- |
| 400 | Bad Request | Something was wrong with the item in the body of the request |
| 403 | Forbidden | Container was likely full |
| 409 | Conflict | Item in container likely already had a matching id |
| 413 | RequestEntityTooLarge | Item exceeds max entity size |
| 429 | TooManyRequests | Current request exceeds the maximum RU/s provisioned for the container |

In this example

```csharp
try
{
    await container.CreateItemAsync<Product>(saddle);
}
catch(CosmosException ex) when (ex.StatusCode == HttpStatusCode.Conflict)
{
    // Add logic to handle conflicting ids
}
catch(CosmosException ex) 
{
    // Add general exception handling logic
}
```
