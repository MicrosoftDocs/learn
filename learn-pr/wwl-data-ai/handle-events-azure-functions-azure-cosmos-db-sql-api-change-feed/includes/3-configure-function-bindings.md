To configure an Azure Function to use an Azure Cosmos DB for NoSQL binding, you should first create an app setting in the function instance with the account endpoint. If you're using the Azure portal, you can enable a managed identity and assign it to the function app. Once you configure the app setting for the account endpoint, you can use the setting in bindings for your Azure Function.

> [!NOTE]
> The following examples assume that an app setting named **CosmosDBConnection** is already configured in the function instance with the Azure Cosmos DB account endpoint and managed identity enabled for authentication. You can name this setting whatever you prefer.

The `function.json` file is the configuration file for all bindings within a function. The file contains a JSON object with a property named `bindings`. The `bindings` object is an array of trigger, input, and output bindings for that particular function.

```json
{
  "bindings": []
}
```

## Trigger function on changes in the change feed

Configuring the Azure Cosmos DB for NoSQL trigger requires a JSON object within the `bindings` array. This object contains various properties that you can configure to change the behavior of the trigger. These properties include, but aren't limited to:

| **Property**                   | **Description**                                                                 |
|--------------------------------|---------------------------------------------------------------------------------|
| **type**                       | Set to **cosmosDBTrigger**                                                      |
| **name**                       | Name used for the method parameter that maps to this binding in code            |
| **direction**                  | For a trigger, set to **in**                                                    |
| **connection**                 | Name of the app setting containing the account endpoint and credential type     |
| **databaseName**               | The name of the database, which contains the container to monitor               |
| **containerName**              | The name of the container to monitor                                            |
| **leaseContainerName**         | The name of the container used to manage change feed leases                     |
| **createLeaseContainerIfNotExists** | A boolean value to indicate if the Azure Functions runtime should create the lease container on your behalf if it doesn't already exist |

An example of a trigger that monitors changes in the `cosmicworks` database and **products** container is included here. This trigger uses the change feed to monitor if new items are created or if existing items are updated.

```json
{
  "type": "cosmosDBTrigger",
  "name": "changes",
  "direction": "in",
  "connection": "CosmosDBConnection",
  "databaseName": "cosmicworks",
  "containerName": "products",
  "leaseContainerName": "productslease",
  "createLeaseContainerIfNotExists": false
}
```

The trigger starts the function when there's a new batch of items to process from the change feed.

## Explanation of the connection app setting

The app setting referenced in the `connection` property is used to securely connect your Azure Function to the Azure Cosmos DB account using a managed identity. The name of this setting is entirely user-defined and can be customized as needed, but for these examples, the setting is named **CosmosDBConnection**.

### Creating the connection

You don't create **CosmosDBConnection** as a single setting. Instead, it serves as a prefix for related configuration values. In this example, you configure two settings with keys prefixed by `CosmosDBConnection` (**__accountEndpoint** and **__credential**).:

1. **Enable managed identity on the Azure Function app**:
   - In the Azure portal, navigate to the **Identity** section of your Azure Function app.
   - Enable the system-assigned managed identity.

1. **Grant permissions to the managed identity**:
   - Navigate to your Azure Cosmos DB account in the Azure portal.
   - Under **Access control (IAM)**, assign a role such as `Cosmos DB Built-in Data Contributor` to the Azure Function's managed identity.

1. **Add the prefixed app settings**:
   - Go to your Azure Function app and open the **Configuration** section.
   - Add the following settings:
     - **Key**: `CosmosDBConnection__accountEndpoint`
       - **Value**: `https://<your-cosmos-account>.documents.azure.com:443/` (replace `<your-cosmos-account>` with your Azure Cosmos DB account name).
     - **Key**: `CosmosDBConnection__credential`
       - **Value**: `managedidentityID` (replace `managedidentityID` with the managed identity ID of your Azure Function).

By using a prefix (in this case, **CosmosDBConnection**) for the keys, you logically group these settings. Azure Functions automatically looks for keys with this prefix when resolving the connection defined in the `connection` property of your `function.json` file.

### Why use a user-defined app setting?

A custom app setting with managed identities, such as **CosmosDBConnection**,  provides the following benefits:

- **Enhanced security**: Eliminates the need to store connection strings in the application configuration.
- **Ease of management**: Automatically integrates with **Microsoft Entra ID** for secure, token-based access.
- **Scalability**: Simplifies permissions management across multiple Azure services.

This app setting is referenced in the `connection` property of your `function.json` file. When the Azure Function is triggered, it uses the managed identity and the app setting to authenticate and connect to Azure Cosmos DB securely.

## Bind the function's input parameter to an item or query

The `bindings` array can optionally have multiple input bindings. There are two types of input bindings: bindings that perform a point read to look up a single item, and bindings that perform a SQL query to return multiple items.

### Point read input binding

A point read input binding uses an item's unique identifier and partition key value to perform a quick read operation. This configuration object differs from the trigger with a few changes to the properties:

| **Property**  | **Description**                                         |
|---------------|---------------------------------------------------------|
| **type**      | The input binding has a static type of **cosmosDB**     |
| **direction** | Input bindings are set to **in**                    |
| **id**        | Unique identifier for the target item                   |
| **partitionKey** | Partition key value for the target item             |

> [!NOTE]
> Duplicate properties, such as **databaseName** and **containerName**, are excluded from the table as they were described earlier.

An example of an input binding that reads an item with an **id** of **91AA100C-D092-4190-92A7-7C02410F04EA** and a **partition key** of **F3FBB167-11D8-41E4-84B4-5AAA92B1E737** is included here.

```json
{
  "type": "cosmosDB",
  "name": "item",
  "direction": "in",
  "connection": "CosmosDBConnection",
  "databaseName": "cosmicworks",
  "containerName": "products",
  "id": "91AA100C-D092-4190-92A7-7C02410F04EA",
  "partitionKey": "F3FBB167-11D8-41E4-84B4-5AAA92B1E737"
}
```

The input binding, as configured, include a single item as an input value to the function.

### SQL query input binding

A SQL query input binding uses a SQL query to look up multiple items and provide them to the function. The configuration object for this type of binding includes one extra field:

| **Property** | **Description**                                  |
|--------------|--------------------------------------------------|
| **sqlQuery** | SQL query used to look up multiple items         |

Included here's an example of this type of input binding that performs a SQL query to return a subset of items from the container with only a few fields included in the results.

```json
{
  "type": "cosmosDB",
  "name": "items",
  "direction": "in",
  "connection": "CosmosDBConnection",
  "databaseName": "cosmicworks",
  "containerName": "products",
  "sqlQuery": "SELECT p.id, p.name, p.categoryId FROM products p WHERE p.price > 500"
}
```

This input binding, as configured, includes multiple items as an input value to the function.

## Output items from the function

Finally, the `bindings` array includes an output binding to configure pipelines to send data to other application components or cloud services. There are primarily two ways to configure the output binding: use the output binding to write a single item to a container, or use the output binding to write multiple items to a container.

In both examples, the output binding is configured by manipulating only a few properties:

| **Property**  | **Description**                                         |
|---------------|---------------------------------------------------------|
| **type**      | This output binding has a static type of **cosmosDB**   |
| **direction** | Set the output bindings to **out**                      |

An example of an output binding that writes one or more items to the `cosmicworks` container is included here.

```json
{
  "type": "cosmosDB",
  "name": "output",
  "direction": "out",
  "connection": "CosmosDBConnection",
  "databaseName": "cosmicworks",
  "containerName": "products"
}
```
