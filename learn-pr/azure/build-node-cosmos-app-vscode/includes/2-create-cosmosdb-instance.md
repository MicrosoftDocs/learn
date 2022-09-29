In this unit, you'll learn about Azure Cosmos DB an how it organizes data. You'll see how to use Visual Studio Code to create and maintain Azure Cosmos DB and containers.

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

## Cosmos DB partition keys

Each container is organized as a series of partitions. Partitions *roughly* correspond to the physical files on disk. A large partition might have its file, but several small partitions could be combined into a single file. Each document has a partition key that defines the partition to which it belongs. You use partitioning to store related documents together, and to help optimize the way you access data.

The following example shows a JSON document that stores product information, as part of the **Contoso** application. Since this data is coming from another system in the Contoso system of databases, the IDs are already configured to be GUIDs. In your own container, you can bring your ID, or allow Cosmos DB to provide one. 

```JSON
{
    "id": "08225A9E-F2B3-4FA3-AB08-8C70ADD6C3C2",
    "categoryId": "75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C",
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

The Contoso company decided to use the category name, categoryName, as the partition key. It could have also chosen the category ID. The partition key field is set when the container is created.


> [!NOTE]
> Azure Cosmos DB adds some fields of its own to your documents. Many of these fields are used for internal purposes, and in most cases you shouldn't modify them directly. The exception is a field named **id**. Azure Cosmos DB uses this field to identify the document in the database, and each document must have a unique **id**.

### Azure Cosmos DB throughput cost

Azure Cosmos DB uses the concept of **Request Units per second** (RU/s) to manage the performance and billing of databases. This measure abstracts the underlying physical resources that need to be provisioned to support the required performance. When you create a database or container, you specify how many RU/s to allocate. You'll incur charges accordingly.

The cost to do a point read (fetching a single item by its ID and partition key value) for a 1-KB item is 1 Request Unit (or 1 RU). All other database operations are similarly assigned a cost using RUs. No matter which API you use to interact with your Azure Cosmos container, costs are always measured by RUs. Whether the database operation is a write, point read, or query, costs are always measured in RUs.

To keep your RU/s as low as possible, consider the following:

* Item size: a larger item increases RUs
* Item indexing: performant indexing can decrease RUs
* Item property count: if you index all your properties, using more properties will increase RUs
* Data consistency: strong and bounded consistency levels consume more RU than other relaxed consistency levels
* Type of reads: point read using an item's ID cost significantly fewer RU than queries
* Query patterns: the complexity of a query affects how many RUs are consumed
* Script usage: stored procedures, triggers, and User-defined functions consume RUs based on complexity

## Access to Cosmos DB

Azure Cosmos DB provides the following ways to connect to the Cosmos DB:

* Visual Studio Code
* Azure portal
* Azure CLI
* PowerShell
* REST API
* JavaScript (and other language) SDKs

## Azure Cosmos DB APIs

Azure Cosmos DB supports several programmatic APIs. These APIs conform as closely as possible to the APIs used by other common NoSQL databases. The intention is to provide an easy migration pathway to Azure Cosmos DB from these databases, without developers having to learn a new paradigm, or make significant changes to their applications. The APIs currently supported are:

- Core (SQL)
- MongoDB
- Cassandra
- Gremlin (a common graph DB API)
- Azure Table Storage

The Core (SQL) API is a variant of the SQL language used by most relational database management systems. There are restrictions and adaptations for handling sets of schemaless documents rather than tables.

## Use Visual Studio Code to manage Azure Cosmos DB

When using Visual Studio Code as your development environment, you can install the Azure Databases extension to build Azure Cosmos DB databases and applications.

:::image type="content" source="../media/2-azure-databases-visual-studio-code-extension.png" alt-text="Screenshot of the Azure Databases extension in Visual Studio Code marketplace":::

You install the extension from the Extensions Marketplace for Visual Studio Code. Once you install the Databases extension, use the Azure explorer, <kbd>Shift<kbd> + <kbd>Alt<kbd> + <kbd>A<kbd>, to use the Cosmos DB extension. 

## Manage Cosmos DB from the Azure explorer

The Databases extension, in the Azure explorer of Visual Studio Code, provides a graphical user interface that is integrated with Visual Studio Code. Using the extension, you can create, delete, and manage Azure Cosmos DB accounts, databases, containers, and documents.

:::image type="content" source="../media/2-cosmosdb-extension.png" alt-text="Screenshot of the Azure Databases extension in Visual Studio Code as user right-clicks on the Documents node for a contextual menu to create a new document." loc-scope="vs-code":::

## Access account in portal

The extension also provides easy access to all the functionality for Cosmos DB by providing the ability to open your account in the Azure portal. You can access this when you right-click your account and select **Open in portal**.

:::image type="content" source="../media/2-cosmosdb-extension-open-in-portal.png" alt-text="Screenshot of the Azure Databases extension in Visual Studio Code as user right-clicks on the account node to open account in Azure portal." loc-scope="vs-code":::

The portal offers access to all the configurations for your Cosmos DB, and the **Data Explorer** for your databases and containers.

:::image type="content" source="../media/2-portal-data-explorer.png" alt-text="Screenshot of the Azure portal with the Data Explorer showing the query window open with a JSON document displayed.":::
