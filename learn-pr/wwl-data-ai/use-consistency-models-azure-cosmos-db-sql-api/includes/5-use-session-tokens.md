When session consistency is selected, consistency is managed using a session token. This token is then passed back-and-forth between Azure Cosmos DB and the client to ensure that clients get read your own write guarantees.

Using the .NET SDK classes, the session token can be manually extracted and passed back to the Azure Cosmos DB resource.

> [!TIP]
> Typically, the .NET SDK automatically manages session tokens for you. You will not need to implement this code in most applications.

In this example, a new item is created. The response class contains a **Headers** property with a specific **Session** header, which contains the session token in string format.

```csharp
ItemResponse<Product> response = await container.CreateItemAsync<Product>(item);
string token = response.Headers.Session;
```

Future requests can use the **ItemRequestOptions** class to configure the session token. This example illustrates a request to read a new item while still honoring the session token.

```csharp
ItemRequestOptions options = new()
{
    SessionToken = token
};
ItemResponse<Product> readResponse = container.ReadItemAsync<Product>(id, partitionKey, requestOptions: options);)
```

> [!TIP]
> Session tokens can be manually pulled out of a client and used on another client to preserve a session between multiple clients.
