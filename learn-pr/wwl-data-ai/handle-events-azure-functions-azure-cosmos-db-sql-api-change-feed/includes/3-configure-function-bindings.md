To configure an Azure Function to use an Azure Cosmos DB SQL API binding, you should first create an app setting in the function instance with the connection string of the Azure Cosmos DB account. If you are using the Azure portal, this can be done automatically on your behalf. Once you have the app setting with the connection string, you can

> [!NOTE]
> The following examples assume that an app setting named **cosmosdbsqlconnstr** is already configured in the function instance with the connection string of the Azure Cosmos DB account.

The function.json file is the configuration file for all bindings within a function. The file contains a JSON object with a property named bindings. The bindings object is an array of trigger, input, and output bindings for that particular function.

```json
{
  "bindings": []
}
```

## Trigger function on changes in the change feed

Configuring the Azure Cosmos DB SQL API trigger requires a JSON object within the bindings array. This object contains various properties that you can configure to change the behavior of the trigger. These properties include, but are not limited to:

| **Property** | **Description** |
| ---: | :--- |
| **type** | This is statically set to **cosmosDBTrigger** |
| **name** | This is the name used for the method parameter that will map to this binding in code |
| **direction** | For a trigger, this will be set to **in** |
| **connectionStringSetting** | This is the name of the connection string in the function’s app settings |
| **databaseName** | The name of the database, which contains the container to monitor |
| **collectionName** | The name of the container to monitor |
| **leaseCollectionName** | The name of the container used to manage change feed leases |
| **createLeaseCollectionIfNotExists** | A boolean value to indicate if the Azure Functions runtime should create the lease container on your behalf if it does not already exist |

An example of a trigger that monitors changes in the **cosmicworks** database and **products** container is included here. This trigger will use the change feed to monitor if new items are created or if existing items are updated.

```json
{
  "type": "cosmosDBTrigger",
  "name": "changes",
  "direction": "in",
  "connectionStringSetting": "cosmosdbsqlconnstr",
  "databaseName": "cosmicworks",
  "collectionName": "products",
  "leaseCollectionName": "productslease",
  "createLeaseCollectionIfNotExists": false
}
```

This trigger will start the function when there is a new batch of items to process from the change feed.

## Bind the function's input parameter to an item or query

The bindings array can optionally have multiple input bindings within the bindings array. There are two types of input bindings; input bindings that perform a point read and lookup a single item, and input bindings that perform a SQL query and return multiple items.

### Point read input binding

A point read input bindings uses an item's unique identifier and partition key value to perform a quick read operation. This configuration object only differs from the trigger with a few changes to the properties:

| **Property** | **Description** |
| ---: | :--- |
| **type** | This input binding has a static type of **cosmosDB** |
| **direction** | Input bindings will be set to **in** |
| **id** | Unique identifier for the target item |
| **partitionKey** | Partition key value for the target item |

> [!NOTE]
> Duplicate properties, such as **databaseName** and **collectionName**, are excluded from this table as they were described earlier in this unit.

An example of an input binding that reads an item with an **id** of **91AA100C-D092-4190-92A7-7C02410F04EA** and a **partition key** of **F3FBB167-11D8-41E4-84B4-5AAA92B1E737** is included here.

```json
{
  "type": "cosmosDB",
  "name": "item",
  "direction": "in",
  "connectionStringSetting": "cosmosdbsqlconnstr",
  "databaseName": "cosmicworks",
  "collectionName": "products",
  "id": "91AA100C-D092-4190-92A7-7C02410F04EA",
  "partitionKey": "F3FBB167-11D8-41E4-84B4-5AAA92B1E737"
}
```

This input binding, as configured, will include a single item as an input value to the function.

### SQL query input binding

A SQL query input binding uses a SQL query to look up multiple items and provide them to the function. The configuration object for this type of binding only includes one extra field:

| **Property** | **Description** |
| ---: | :--- |
| **sqlQuery** | SQL query used to look up multiple items |

Included here is an example of this type of input bindings that performs a SQL query to return a subset of items from the container with only a few fields included in the results.

```json
{
  "type": "cosmosDB",
  "name": "items",
  "direction": "in",
  "connectionStringSetting": "cosmosdbsqlconnstr",
  "databaseName": "cosmicworks",
  "collectionName": "products",
  "sqlQuery": "SELECT p.id, p.name, p.categoryId FROM products p WHERE p.price > 500"
}
```

This input binding, as configured, will include multiple items as an input value to the function.

## Output items from the function

Finally, the bindings array includes an output binding to configure pipelines to send data to other application components or cloud services. There are primarily two ways to configure the output binding; use the output binding to write a single item to a container, or use the output binding to write multiple items to a container.

In both examples, the output binding is configured by manipulating only a few properties:

| **Property** | **Description** |
| ---: | :--- |
| **type** | This output binding has a static type of **cosmosDB** |
| **direction** | Output bindings will be set to **out** |

An example of an output binding that writes one or more items to the **cosmicworks** container is included here.

```json
{
  "type": "cosmosDB",
  "name": "output",
  "direction": "out",
  "connectionStringSetting": "cosmosdbsqlconnstr",
  "databaseName": "cosmicworks",
  "collectionName": "products"
}
```
