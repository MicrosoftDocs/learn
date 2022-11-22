In this unit, you'll learn about Azure Cosmos DB and how it organizes data. You'll see how to use Visual Studio Code to create and maintain Azure Cosmos DB databases and containers.

## What is Azure Cosmos DB?

Azure Cosmos DB is a cloud service that implements document databases. The data in a document must conform to JSON syntax. A JSON document can contain properties, subdocuments, and arrays of documents. 

```json
{
    "id": "08225A9E-F2B3-4FA3-AB08-8C70ADD6C3C2",
    "partitionKey": "Bikes",
    "name": "Touring-1000 Blue, 50",
    "description": "The product called \"Touring-1000 Blue, 50\"",
    "price": 2384.0700000000002,
    "inventory": [
        { "location": "Dallas", "inventory": 96 },
        { "location": "Seattle", "inventory": 85 }
      ]
}
```

Unlike a table in a relational database, documents in an Azure Cosmos DB don't follow a pre-defined schema. This allows the database to hold various documents with different *shapes* and sizes. For example, you could store varying information about different customers in the same database. Perhaps you could record a complete address history as an array for a customer. You might record additional information, such as their credit worthiness.

The Azure Cosmos DB cloud service is organized as a hierarchy. At the top is an Azure Cosmos DB account (your resource). The Azure Cosmos DB account is the unit of security for a set of databases. The Azure Cosmos DB account specifies the location of the databases together with the security information required to access those databases. Inside an account, you create one or more databases. You create one or more containers inside each database. You store documents in containers.

:::image type="content" source="../media/2-cosmos-db-resource-hierarchy.svg" alt-text="Conceptual image of parent-child relationship of account, database, and container in Cosmos D B.":::

## Cosmos DB containers and partition keys

Each container is organized as a series of partitions. Partitions *roughly* correspond to the physical files on disk. A large partition might have its file, but several small partitions could be combined into a single file. Each document has a partition key that defines the partition to which it belongs. You use partitioning to store related documents together, and to help optimize the way you access data.

The following example shows a JSON document that stores product information, as part of the **Contoso** application. Since this data is coming from another system, the IDs are already configured to be GUIDs. In your own container, you can bring your ID, or allow Cosmos DB to provide one. When you insert a new document, you need to provide the ID and the partition key (if using partition keys). 

```JSON
{
    "id": "08225A9E-F2B3-4FA3-AB08-8C70ADD6C3C2",
    "categoryName": "Bikes, Touring Bikes",
    "sku": "BK-T79U-50",
    "name": "Touring-1000 Blue, 50",
    "description": "The product called \"Touring-1000 Blue, 50\"",
    "price": 2384.0700000000002,
    "tags": [
        {
            "_id": "27B7F8D5-1009-45B8-88F5-41008A0F0393",
            "name": "Tag-61"
        }
    ],
    "inventory": [
        { "location": "Dallas", "inventory": 96 },
        { "location": "Seattle", "inventory": 85 },
        { "location": "Boston", "inventory": 4 },
        { "location": "Miami", "inventory": 12 },
        { "location": "San Diego", "inventory": 58 }
      ]
}
```

The Contoso company decided to use the category name, _categoryName_, as the partition key, because this provides for a _somewhat_ even distribution of documents across the container. The partition key field is set for the container when the container is created. For each new document inserted into the container, the partition key is included as part of the JSON document. In the above example, the **minimum requirements for a correctly formed document** are the unique id and as the partition key, `id` and `categoryName`. If you bring a dataset from another system and want to keep its unique ID in order to connect to other systems, you can choose to use the `id` field  or allow Cosmos DB to create a new unique `id` and your ID could be stored in a separate property name.

> [!NOTE]
> Azure Cosmos DB adds some fields of its own to your documents. Many of these fields are used for internal purposes, and in most cases you shouldn't modify them directly. The exception is a field named **id**. Azure Cosmos DB uses this field to identify the document in the database, and each document must have a unique **id**. 

### Azure Cosmos DB throughput cost

Azure Cosmos DB uses the concept of **Request Units per second** (RU/s) to manage the performance and billing of databases. This measure abstracts the underlying physical resources that need to be provisioned to support the required performance. When you create a database or container, you specify how many RU/s to allocate. You'll incur charges accordingly.

The cost to do a point read (fetching a single item by its ID and partition key value) for a 1-KB item is 1 Request Unit (or 1 RU). All other database operations are similarly assigned a cost using RUs. No matter which API you use to interact with your Azure Cosmos DB container, costs are always measured by RUs. Whether the database operation is a write, point read, or query, costs are always measured in RUs.

If you provision 400 RU/s and issue a query that costs 40 RUs, you will be able to issue 10 such queries per second. Any request beyond that will get rate-limited and you should retry the request. If you are using client drivers, they support the automatic retry logic.

To keep your RU/s as low as possible, consider the following:

|Object|Considerations|
|--|--|
|Document size| A larger document in KBs increases RUs.|
|Document indexing| Performant indexing can decrease RUs.|
|Document property count| If you index all your properties, using more properties will increase RUs. Selectively indexing key properties will require fewer RUs.|
|Data consistency|Strong and bounded consistency levels consume more RUs than other relaxed consistency levels.|
|Type of document reads|Point read using an item's ID and partition key cost significantly fewer RUs than queries.|
|Query patterns|The complexity of a query affects how many RUs are consumed.|
|Script usage|Stored procedures, triggers, and User-defined functions consume RUs in addition to the queries inside these scripts.|

## Access to Cosmos DB

Azure Cosmos DB includes the following ways to connect to the Cosmos DB:

* **Visual Studio Code**
* **JavaScript (and other language) SDKs**
* Azure portal
* Azure CLI
* PowerShell
* REST API

## Azure Cosmos DB APIs

Azure Cosmos DB supports several programmatic APIs. These APIs conform as closely as possible to the APIs used by other common NoSQL databases. The intention is to provide an easy migration pathway to Azure Cosmos DB from these databases, without developers having to learn a new paradigm, or make significant changes to their applications. The APIs currently supported are:

- **Core (SQL)**
- MongoDB
- Cassandra
- Gremlin (a common graph DB API)
- Azure Table Storage

The Core (SQL) API is a variant of the SQL language used by most relational database management systems. There are restrictions and adaptations for handling sets of schemaless documents rather than tables.

## Use Visual Studio Code to manage Azure Cosmos DB

When using Visual Studio Code as your development environment, you can install the Azure Databases extension to build Azure Cosmos DB databases and applications.

:::image type="content" source="../media/2-azure-databases-visual-studio-code-extension.png" alt-text="Screenshot of the Azure Databases extension in Visual Studio Code marketplace":::

You install the extension from the Extensions Marketplace for Visual Studio Code. Once you install the Databases extension, use the Azure explorer, <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>, to use the Cosmos DB extension. 

## Manage Cosmos DB from the Azure explorer

The Databases extension, in the Azure explorer of Visual Studio Code, provides a graphical user interface that is integrated with Visual Studio Code. Using the extension, you can create, delete, and manage Azure Cosmos DB accounts, databases, containers, and documents.

:::image type="content" source="../media/2-cosmosdb-extension.png" alt-text="Screenshot of the Azure Databases extension in Visual Studio Code as user right-clicks on the Documents node for a contextual menu to create a new document." loc-scope="vs-code":::

## Access account in portal

The extension also provides easy access to all the functionality for Cosmos DB by providing the ability to open your account in the Azure portal. You can access this when you right-click your account and select **Open in portal**.

:::image type="content" source="../media/2-cosmosdb-extension-open-in-portal.png" alt-text="Screenshot of the Azure Databases extension in Visual Studio Code as user right-clicks on the account node to open account in Azure portal." loc-scope="vs-code":::

The portal offers access to all the configurations for your Cosmos DB, and the **Data Explorer** for your databases and containers. Use the Data Explorer to insert, update, delete, and query your data. 

:::image type="content" source="../media/2-portal-data-explorer.png" alt-text="Screenshot of the Azure portal with the Data Explorer showing the query window open with a JSON document displayed.":::
