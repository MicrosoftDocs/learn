::: zone pivot="csharp"

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

::: zone-end

::: zone pivot="python"

Proper logging is essential for monitoring and debugging your Azure Cosmos DB application. The Python SDK provides multiple mechanisms for enabling logging, capturing diagnostics, and fine-tuning the amount of information logged.

## Overview of Logging Features

The Azure Cosmos DB Python SDK integrates with Python's standard ``logging`` module. By default:

- Basic HTTP session information (for example, URLs and headers) is logged at the ``INFO`` level.
- Detailed request and response logging, including bodies and unredacted headers, is available at the ``DEBUG`` level.

### Key Capabilities

1. **Global Logging**: Enable logging at the client level to capture diagnostics for all operations.
2. **Per-Operation Logging**: Enable detailed logging for individual operations.
3. **Enhanced Diagnostics**: Use `CosmosHttpLoggingPolicy` to capture more debugging information specific to Cosmos DB.

## Enabling Basic Logging

The Python SDK uses the ``logging`` module for diagnostics. To start, you can configure basic logging to capture HTTP session details.

### Example: Basic Logging Configuration

```python
import sys
import logging
from azure.cosmos import CosmosClient

# Create a logger for the Azure SDK
logger = logging.getLogger("azure")
logger.setLevel(logging.DEBUG)  # Set log level to DEBUG for detailed output

# Configure console output
handler = logging.StreamHandler(stream=sys.stdout)
logger.addHandler(handler)

# Initialize the CosmosClient with global logging enabled
client = CosmosClient("<cosmos-endpoint>", "<cosmos-key>", logging_enable=True)

# Perform an operation to observe logs
database = client.create_database_if_not_exists("cosmicworks")
print(f"Database created or retrieved: {database.id}")
```

``logging_enable=True`` enables detailed logging at the client level, capturing all HTTP requests and responses. This setup is ideal for debugging during development.

## Enabling Per-Operation Logging

If you need detailed logging for a specific operation but not globally for the client, you can enable it per operation.

### Example: Operation-Level Logging

```python
# Perform an operation with logging enabled specifically for this request
database = client.create_database("cosmicworks", logging_enable=True)
print(f"Database created: {database.id}")
```

This approach limits logging to individual operations, reducing log noise in production environments.

## Enhanced Diagnostics with ``CosmosHttpLoggingPolicy``

The SDK provides an extended logging policy, ``CosmosHttpLoggingPolicy``, which builds on Azure's ``HttpLoggingPolicy``. This policy captures more diagnostic information specific to Cosmos DB, such as elapsed request times and error messages.

### Example: Using ``CosmosHttpLoggingPolicy``

```python
import logging
from azure.cosmos import CosmosClient

# Create a logger for the Azure SDK
logger = logging.getLogger("azure")
logger.setLevel(logging.DEBUG)

# Configure file output for logs
handler = logging.FileHandler(filename="cosmos_logs.txt")
logger.addHandler(handler)

# Initialize the CosmosClient with enhanced diagnostics logging
client = CosmosClient(
    "<cosmos-endpoint>", 
    "<cosmos-key>", 
    logger=logger, 
    enable_diagnostics_logging=True
)

# Perform an operation to observe enhanced diagnostics
database = client.create_database_if_not_exists("cosmicworks")
print(f"Database created or retrieved: {database.id}")
```

Passing ``enable_diagnostics_logging=True`` to the client enables ``CosmosHttpLoggingPolicy``. Logs include more details relevant to Cosmos DB, such as response timings and diagnostic headers.

## Combining Global and Operation-Level Logging

You can mix global logging and per-operation logging to gain granular control over what is logged.

### Example: Combining Logging Levels

```python
# Initialize the CosmosClient with enhanced diagnostics
client = CosmosClient(
    "<cosmos-endpoint>", 
    "<cosmos-key>", 
    enable_diagnostics_logging=True
)

# Perform an operation with a custom logger
logger = logging.getLogger("azure.operation")
logger.setLevel(logging.DEBUG)
handler = logging.StreamHandler(stream=sys.stdout)
logger.addHandler(handler)

# Use the custom logger for a specific operation
database = client.create_database("cosmicworks", logger=logger)
print(f"Database created: {database.id}")
```

This approach allows enhanced diagnostics at the client level while fine-tuning logging for specific operations.

::: zone-end

::: zone pivot="node"

Proper logging and diagnostics are essential for monitoring, debugging, and optimizing your Azure Cosmos DB application. The JavaScript SDK provides built-in mechanisms for logging HTTP request/response details and applying detailed diagnostics to analyze operations programmatically.

## Overview of Logging Features

The Azure Cosmos DB JavaScript SDK uses the `@azure/logger` package for logging. It supports configurable log levels to control the verbosity of output. Logs can reveal valuable information about operations, failures, and performance bottlenecks.

## Enabling Logging

Logging can be enabled either through an environment variable or programmatically during runtime.

### Example 1: Enabling Logging via Environment Variable

Set the `AZURE_LOG_LEVEL` environment variable before starting your application.

#### On macOS/Linux:

```bash
export AZURE_LOG_LEVEL=info
node your-app.js
```

#### On Windows:

```cmd
set AZURE_LOG_LEVEL=info
node your-app.js
```

### Example 2: Enabling Logging Programmatically

You can also enable logging at runtime by importing and configuring the `@azure/logger` package:

```javascript
const { setLogLevel } = require("@azure/logger");
setLogLevel("info");
```

The `info` log level is suitable for production systems as it provides essential diagnostics without overwhelming verbosity. You can also filter logs by setting the level to `error` or `warning`.

For debugging during development, use `verbose` for more detailed output.

## Leveraging Cosmos Diagnostics

Cosmos Diagnostics provides detailed insights into operations performed using the SDK. A `CosmosDiagnostics` object is included in the response of all operations, capturing metrics such as payload sizes, retries, and endpoints contacted.

### Configuring Diagnostic Levels

Diagnostic levels control the granularity of the diagnostics information collected. The following levels are supported:

- **`info`**: Minimal diagnostics suitable for production systems.
- **`debug`**: Detailed diagnostics for debugging and performance analysis.
- **`debug-unsafe`**: Includes sensitive request and response payloads. **Not recommended for production**.

### Example 1: Setting Diagnostic Levels Programmatically

```javascript
const { CosmosClient, CosmosDbDiagnosticLevel } = require("@azure/cosmos");

const client = new CosmosClient({
    endpoint: "<cosmos-endpoint>",
    key: "<cosmos-key>",
    diagnosticLevel: CosmosDbDiagnosticLevel.debug
});
```

### Example 2: Setting Diagnostic Levels via Environment Variable

```bash
export AZURE_COSMOSDB_DIAGNOSTICS_LEVEL=debug
```

### Consuming Diagnostics Programmatically

The `CosmosDiagnostic` object is accessible on response objects and can be used to analyze various aspects of operations.

#### Example: Accessing Diagnostics for Common Operations

```javascript
// For creating a container
const { container, diagnostics: containerDiagnostics } = await database.containers.createIfNotExists({
    id: "sample-container",
    partitionKey: { paths: ["/key1"] }
});
console.log("Container diagnostics:", containerDiagnostics);

// For querying items
const queryIterator = container.items.query("SELECT * FROM c");
const { resources, diagnostics: queryDiagnostics } = await queryIterator.fetchAll();
console.log("Query diagnostics:", queryDiagnostics);

// For batch operations
const partitionKey = "partition1";
const operations = [
    { operationType: "Create", resourceBody: { id: "item1", key: partitionKey } }
];
const batchResponse = await container.items
    .bulk(operations, { partitionKey });
console.log("Batch diagnostics:", batchResponse.diagnostics);
```

The `diagnostics` object includes metrics like request duration, retries, and payload sizes. Diagnostic information can help identify and resolve issues such as inefficient queries or high retry rates.

## Debugging with Enhanced Diagnostics

### Example: Logging Diagnostics Using @Azure/logger

To log diagnostics automatically, set the diagnostic level to `debug` or `debug-unsafe` and configure the logger for verbose output.

```javascript
const { CosmosClient, CosmosDbDiagnosticLevel } = require("@azure/cosmos");
const { setLogLevel } = require("@azure/logger");

setLogLevel("verbose"); // Log detailed diagnostics

const client = new CosmosClient({
    endpoint: "<cosmos-endpoint>",
    key: "<cosmos-key>",
    diagnosticLevel: CosmosDbDiagnosticLevel.debugUnsafe
});

// Perform an operation
const { database } = await client.databases.createIfNotExists({ id: "sample-database" });
const { container } = await database.containers.createIfNotExists({ id: "sample-container" });
const { diagnostics } = await container.items.create({ id: "item1", key: "partition1" });
console.log("Diagnostics logged at verbose level:", diagnostics);
```

Use `debug` level diagnostics to analyze performance in nonproduction environments. Avoid using `debug-unsafe` in production as it includes sensitive payloads.

::: zone-end
