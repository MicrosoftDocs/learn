There are many scenarios where you wish to log the HTTP requests that the Azure Cosmos DB for NoSQL SDK performs "under the hood." The SDK includes a fluent client builder class that simplifies the process of injecting custom handlers into the HTTP requests and responses. You can take advantage of this functionality to build a logging mechanism.

## Client builder

The **Microsoft.Azure.Cosmos.Fluent.CosmosClientBuilder** class is a builder class that fluently configures a new client instance. It comes with multiple methods that are used as an alternative to the **CosmosClientOptions** class including, but not limited to:

| **Method** | **Description** |
| --- | --- |
| **WithApplicationRegion** or **WithApplicationPreferredRegions** | Configures preferred region\[s\] |
| **WithConnectionModeDirect** and **WithConnectionModeGateway** | Sets connection mode |
| **WithConsistencyLevel** | Overrides consistency level |

To use the builder, first you must add a using directive to the **Microsoft.Azure.Cosmos.Fluent** namespace.

```csharp
using Microsoft.Azure.Cosmos.Fluent;
```

While you can create a new instance of the **CosmosClientBuilder** class passing in a connection string or endpoint+key pair as constructor parameters, in a production environment, we recommend using managed identities. For this example, let's use a managed identity to authenticate with Azure Cosmos DB.

```csharp
// Using DefaultAzureCredential
TokenCredential defaultCredential = new DefaultAzureCredentialBuilder().build();
CosmosClientBuilder builder = new CosmosClientBuilder()
    .endpoint("<your-cosmos-endpoint>")
    .credential(defaultCredential)
    .consistencyLevel(ConsistencyLevel.EVENTUAL);

// Using ManagedIdentityCredential
TokenCredential managedIdentityCredential = new ManagedIdentityCredentialBuilder()
    .clientId("<your-managed-identity-client-id>")
    .build();
CosmosClientBuilder builder = new CosmosClientBuilder()
    .endpoint("<your-cosmos-endpoint>")
    .credential(managedIdentityCredential)
    .consistencyLevel(ConsistencyLevel.EVENTUAL);
```

At this point, you can add any fluent methods to configure the client. Once you're done with fluent methods, you can invoke the **Build** method to create an instance of type **CosmosClient**.

```csharp
CosmosClient client = builder.Build();
```

## Creating a custom log handler

To log HTTP requests, you need to create a new class that inherits from the abstract **RequestHandler** class. In the handler, you can add logic before and after the HTTP request is sent. For this example, we create a handler that performs the following workflow when an HTTP request is sent:

1. Writes the HTTP method and URI of the originating request to the console
1. Sends the request to the base implementation and stores the response in a variable
1. Writes the HTTP status code number and description to the console
1. Returns the response

### Creating a custom RequestHandler implementation

To implement this request, we need to create a new class that inherits from **RequestHandler**.

```csharp
public class LogHandler : RequestHandler
{   
}
```

The abstract class includes a **SendAsync** method that should be overridden to inject new logic around requests.

```csharp
public override async Task<ResponseMessage> SendAsync(RequestMessage request, CancellationToken cancellationToken)
{
}
```

Within the **SendAsync** method, the **RequestUri** and **Method** properties of the **RequestMessage** parameter are printed to the console. Then, the base **SendAsync** method is invoked to send the actual request and store the response in a local variable.

```csharp
Console.WriteLine($"[{request.Method.Method}]\t{request.RequestUri}");

ResponseMessage response = await base.SendAsync(request, cancellationToken);
```

After the response is stored in a local variable, the **StatusCode** of the response is printed in both numeric and string format. Then the response is returned as the result of the asynchronous method.

```csharp
Console.WriteLine($"[{Convert.ToInt32(response.StatusCode)}]\t{response.StatusCode}");

return response;
```

Here's the code for the complete class.

```csharp
public class LogHandler : RequestHandler
{    
    public override async Task<ResponseMessage> SendAsync(RequestMessage request, CancellationToken cancellationToken)
    {
        Console.WriteLine($"[{request.Method.Method}]\t{request.RequestUri}");

        ResponseMessage response = await base.SendAsync(request, cancellationToken);
        
        Console.WriteLine($"[{Convert.ToInt32(response.StatusCode)}]\t{response.StatusCode}");
        
        return response;
    }
}
```

### Using a custom RequestHandler implementation in the client builder

Once the request handler implementation is ready, invoke the **AddCustomHandler** method of the **CosmosClientBuilder** instance passing in a new instance of the custom request handler.

```csharp
builder.AddCustomHandlers(new LogHandler());
```

Here's the code for the complete creation of the client using the builder.

```csharp
// Using ManagedIdentityCredential
TokenCredential managedIdentityCredential = new ManagedIdentityCredentialBuilder()
    .clientId("<your-managed-identity-client-id>")
    .build();
CosmosClientBuilder builder = new CosmosClientBuilder()
    .endpoint("<your-cosmos-endpoint>")
    .credential(managedIdentityCredential)
    .consistencyLevel(ConsistencyLevel.EVENTUAL);

builder.AddCustomHandlers(new LogHandler());

CosmosClient client = builder.Build();
```

### Testing the custom logger

Let's assume we have a fictional scenario where we use our client instance to invoke the **CreateDatabaseIfNotExistsAsync** method. The client instance should check for the existence of the database first, and if it doesn't find the database, it creates a new one using the specified name.

For this fictional scenario, we use this example line of code to invoke the **CreateDatabaseIfNotExistsAsync** method.

```csharp
Database result = await client.CreateDatabaseIfNotExistsAsync("cosmicworks");
```

When you run the application for the first time, the logger outputs that it performed the following actions:

1. Sent an HTTP **GET** *request* to query for your specific database at the ``dbs/<database-name>`` endpoint.
1. Received a *response* of **404** that the database wasn't found.
1. Sent an HTTP **POST** *request* with the database details in the body of the request to the ``dbs/`` endpoint.
1. Received a *response* of **201** indicating that the database is created with the database's details in the response body.

```bash
[GET]   dbs/cosmicworks
[404]   NotFound
[POST]  dbs/
[201]   Created
```

If you ran the application again, the logger outputs a shorter workflow:

1. Sent an HTTP **GET** *request* to query for your specific database at the ``dbs/<database-name>`` endpoint.
1. Received a *response* of **200** indicating that the database was found with the database's details in the response body.

```bash
[GET]   dbs/cosmicworks
[200]   OK
```
