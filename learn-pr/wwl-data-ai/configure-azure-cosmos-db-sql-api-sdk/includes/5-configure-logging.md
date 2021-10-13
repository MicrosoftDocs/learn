There are many scenarios where you wish to log the HTTP requests that the Azure Cosmos DB SQL API SDK performs "under the hood." The SDK includes a fluent client builder class that simplifies the process of injecting custom handlers into the HTTP requests and responses. You can take advantage of this functionality to build a simple logging mechanism.

## Client builder

The **Microsoft.Azure.Cosmos.Fluent.CosmosClient** class is a builder class that fluently configures a new client instance. It comes with multiple methods that are used as an alternative to the **CosmosClientOptions** class including, but not limited to:

| **Method** | **Description** |
| --- | --- |
| **WithApplicationRegion** or **WithApplicationPreferredRegions** | Configures preferred region\[s\] |
| **WithConnectionModeDirect** and **WithConnectionModeGateway** | Sets connection mode |
| **WithConsistencyLevel** | Overrides consistency level |

To use the builder, first you must add a using directive to the **Microsoft.Azure.Cosmos.Fluent** namespace.

:::code language="csharp" source="../media/5-script.cs" range="1":::

Now, you can create a new instance of the **CosmosClientBuilder** class passing in a connection string or endpoint+key pair as constructor parameters.

:::code language="csharp" source="../media/5-script.cs" range="3-5":::

At this point, you can add any fluent methods to configure the client. Once you are done with fluent methods, you can invoke the **Build** method to create an instance of type **CosmosClient**.

:::code language="csharp" source="../media/5-script.cs" range="9":::

## Creating a custom log handler

To log HTTP requests, you will need to create a new class that inherits from the abstract **RequestHandler** class. In the handler, you can add logic before and after the HTTP request is sent. For this example, we will create a handler that performs the following workflow when an HTTP request is sent:

1. Writes the HTTP method and URI of the originating request to the console
1. Sends the request to the base implementation and stores the response in a variable
1. Writes the HTTP status code number and description to the console
1. Returns the response

### Creating a custom RequestHandler implementation

To implement this, we need to create a new class that inherits from **RequestHandler**.

:::code language="csharp" source="../media/5-script.cs" range="13-14,25":::

The abstract class includes a **SendAsync** method that should be overriden to inject new logic around requests.

:::code language="csharp" source="../media/5-script.cs" range="15-16,24":::

Within the **SendAsync** method, the **RequestUri** and **Method** properties of the **RequestMessage** parameter are printed to the console. Then, the base **SendAsync** method is invoked to send the actual request and store the response in a local variable.

:::code language="csharp" source="../media/5-script.cs" range="17-19":::

After the response is stored in a local variable, the **StatusCode** of the response is printed in both numeric and string format. Then the response is returned as the result of the asynchronous method.

:::code language="csharp" source="../media/5-script.cs" range="21-23":::

Here is the code for the complete class.

:::code language="csharp" source="../media/5-script.cs" range="13-25":::

### Using a custom RequestHandler implementation in the client builder

Once the request handler implementation is ready, invoke the **AddCustomHandler** method of the **CosmosClientBuilder** instance passing in a new instance of the custom request handler.

:::code language="csharp" source="../media/5-script.cs" range="7":::

Here is the code for the complete creation of the client using the builder.

:::code language="csharp" source="../media/5-script.cs" range="5-9":::

### Testing the custom logger

Let's assume we have a fictional scenario where we use our client instance to invoke the **CreateDatabaseIfNotExistsAsync** method. The client instance should check for the existence of the database first, and if it doesn't find the database, it will create a new one using the specified name.

For this fictional scenario, we will use this example line of code to invoke the **CreateDatabaseIfNotExistsAsync** method.

:::code language="csharp" source="../media/5-script.cs" range="11":::

When you run the application for the first time, the logger will output that it performed the following actions:

1. Sent a HTTP **GET** *request* to query for your specific database at the ``dbs/<database-name>`` endpoint.
1. Received a *response* of **404** that the database was not found.
1. Sent a HTTP **POST** *request* with the database details in the body of the request to the ``dbs/`` endpoint.
1. Received a *response* of **201** indicating that the database has been created with the database's details in the response body.

:::code language="azurecli" source="../media/5-output.sh" range="1-4":::

If you ran the application again, the logger will output a much shorter workflow:

1. Sent a HTTP **GET** *request* to query for your specific database at the ``dbs/<database-name>`` endpoint.
1. Received a *response* of **200** indicating that the database has been found with the database's details in the response body.

:::code language="azurecli" source="../media/5-output.sh" range="6-7":::
