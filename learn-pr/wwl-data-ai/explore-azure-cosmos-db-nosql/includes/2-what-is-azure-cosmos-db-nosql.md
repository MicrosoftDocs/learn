Azure Cosmos DB for NoSQL organizes data differently than a relational database. Understanding this structure helps you decide if it fits the Contoso application. In this unit, you learn the data model behind the service and the resources you work with. This foundation supports every decision you make later in the module.

## What a NoSQL database is

Modern applications place demands on data platforms that differ from those applications of traditional relational systems. NoSQL databases address needs such as:

- High volumes of data from many sources.
- Data that arrives in different shapes and formats.
- Schemas that change as an application evolves.
- High-velocity or real-time data.

You define NoSQL databases by the characteristics they share rather than by a single formal definition. Most NoSQL databases store data in a nonrelational format, scale out horizontally, and don't enforce a fixed schema. Because they avoid rigid relational constraints, they support high write throughput, and because they partition data across many machines, they maintain performance as data grows.

NoSQL databases use several data models, including key-value, document, graph, and column-family stores. Azure Cosmos DB for NoSQL uses the *document* data model, which is the focus of this module.

:::image type="content" source="../media/nosql-data-models.png" alt-text="Diagram comparing four NoSQL data models: key-value, document, column-family, and graph stores." lightbox="../media/nosql-data-models.png":::

## The document data model and JSON

The document data model stores each entity as a self-contained *document*. Azure Cosmos DB for NoSQL uses JSON as the document format. A document is an atomic entity that carries its own structure, independent of other documents in the same container. This flexibility means you don't define a schema in advance, so you can change applications without a schema migration and store different types of data together.

JSON (JavaScript Object Notation) is a lightweight, readable data format with well-defined data types and broad support across languages and services. A JSON document looks like this:

```json
{
  "id": "44A6D5F6-AF44-4B34-8AB5-21C5DC50926E",
  "type": "customer",
  "customerId": "44A6D5F6-AF44-4B34-8AB5-21C5DC50926E",
  "firstName": "Dalton",
  "lastName": "Perez",
  "emailAddress": "dalton37@adventure-works.com",
  "addresses": [
    {
      "addressLine1": "6083 San Jose",
      "city": "Haney",
      "state": "BC",
      "countryOrRegion": "CA",
      "zipCode": "V2W 1W2"
    }
  ],
  "salesOrderCount": 28
}
```

Azure Cosmos DB for NoSQL stores documents natively, indexes them automatically, and makes them available through a query language with SQL-like syntax designed for JSON data.

## The resource model

Azure Cosmos DB for NoSQL organizes data in a hierarchy of four resources: accounts, databases, containers, and items.

- **Account**: The top-level resource. An account defines the regions where your data lives, provides a globally unique DNS name for API requests, and sets account-wide options such as the default consistency level. You create and manage accounts through the Azure portal, Bicep or Azure Resource Manager templates, the Azure CLI, or Azure PowerShell.
- **Database**: A logical unit of management that groups one or more containers within an account.
- **Container**: The fundamental unit of scalability. You usually provision throughput on a container, although a database can also share throughput across the containers it holds. Azure Cosmos DB partitions a container's data automatically, based on a partition key that you choose. You can also set options such as an indexing policy or a default time-to-live value on a container.
- **Item**: An individual JSON document stored in a container. Because a container is schema-agnostic, items in the same container can differ in shape. A write to a single item is atomic, so an item is never left partially written.

> [!NOTE]
> Throughput and time-to-live configuration are introduced here as container options. Default consistency is an account-level setting. You configure these settings in detail in a later module.

:::image type="content" source="../media/resource-hierarchy.png" alt-text="Diagram showing the Azure Cosmos DB resource hierarchy from account to database to container to item." lightbox="../media/resource-hierarchy.png":::

## Develop applications with Azure Cosmos DB for NoSQL

Azure Cosmos DB for NoSQL provides the native programming model for working with the accounts, databases, containers, and items introduced earlier. Applications connect by using software development kits (SDKs) for .NET, Java, Python, JavaScript/Node.js, Go, and Rust.

In addition to item operations and queries, Azure Cosmos DB for NoSQL supports:

- Transactional batches for items that share a logical partition key.
- Change feed processing for responding to inserts and updates.
- Vector indexing, full-text search, and hybrid search for AI retrieval scenarios.

For Contoso, a product item can contain both its catalog data and vector embedding. Keeping this information together supports patterns such as retrieval-augmented generation and agent memory without requiring a separate vector database.

## Key characteristics

Four characteristics define how the service behaves. You meet each one again in later units, but it helps to know up front what Azure Cosmos DB for NoSQL commits to:

- **Global distribution**: You add regions to an account at any time, and the service replicates your data to them. Adding or removing a region is an online operation, so the application keeps running and doesn't need to be redeployed. Turn on multi-region writes, and every region accepts writes and reads.
- **Elastic scale**: Throughput follows demand. Autoscale moves throughput between 10% and 100% of the maximum you set, instantly and without disrupting client connections. Storage grows as you add data, and a container has no total size cap. Each logical partition holds up to 20 GB, which is a limit that shapes how you choose a partition key. The next unit returns to that point.
- **Guaranteed low latency**: Reads of a single item and indexed writes finish in under 10 ms at the 99th percentile. That number is a service-level agreement, not a target. Writes to multi-region accounts configured with strong consistency are an exception because they require replication across regions. Availability carries a Service Level Agreement (SLA) too. A single-region account gets 99.99%, any multi-region account gets 99.999% read availability, and multi-region writes extend that 99.999% figure to writes.
- **Tunable consistency**: Five consistency levels run from strongest to weakest: strong, bounded staleness, session, consistent prefix, and eventual. Most distributed databases pick one point on that scale for you. Here you choose the trade-off between consistency and latency yourself.

One more behavior is easy to miss because it happens without any action from you. Azure Cosmos DB indexes every property of every item by default, with no schema to declare and no secondary indexes to create. Queries work from the moment you write data. You can narrow that policy later to reduce cost, which is a topic for a subsequent module.

> [!TIP]
> Think about an application you work on today. Which of its data (user records, events, catalog entries) would map naturally to self-contained JSON documents, and which relationships would be harder to express without a fixed relational schema?

You now know what Azure Cosmos DB for NoSQL is and the resources you work with. Next, you learn how the service distributes and scales that data.
