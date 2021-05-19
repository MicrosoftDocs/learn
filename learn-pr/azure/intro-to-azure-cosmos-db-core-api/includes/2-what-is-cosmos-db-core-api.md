Let's start with a few definitions and a quick tour through Azure Cosmos DB SQL API. This overview should help you see whether Azure Cosmos DB might be a good fit for your work.

## What is a NoSQL database?

Developers require new kinds of databases that can address the needs of modern apps. NoSQL databases were designed to address these needs and unique challenges such as:

- High volumes of data
- Data with many different sources and forms
- Dynamic data schemas to store different types of data
- Using high-velocity and/or real-time data

NoSQL databases are defined by common characteristics they share rather than a specific formal definition. These characteristics include:

- Data store is non-relational
- Designed for scale out
- Does not enforce a specific schema

NoSQL databases generally do not enforce relational constraints or put locks on data, making writes fast. They are also often horizontally scalable via sharding or partitioning, which allows them to maintain high-performance regardless of size.

While there are many NoSQL data models, there are four broad data model families that are used when modeling data in a NoSQL database:

:::image type="content" source="../media/2-nosql-db.svg" alt-text="Illustration of various NoSQL models including; a key-value store with a one-to-one relationship between identifiers and values, a document store with a hierarchy of entities, a graph store with traversal paths, and a column family store with multiple columns" border="false":::

> ![NOTE]
> Moving forward, we will focus on the document data model.

## Why use a NoSQL database with the document data model?

The document data model breaks data down into individual **document** entities. A document can be any structured data type, but [JSON](what-is-a-json-document) is commonly used as the data format.

:::image type="content" source="../media/2-document-db.svg" alt-text="A" border="false":::

A document is an atomic entity and can have its own data form, regardless of what is stored in other documents in the same database. Because of this flexibility, there is no need for a pre-defined schema making it easier to build new applications rapidly. Additionally, this flexibility enables scenarios where different types of data can be stored together and where models can evolve over the lifetime of an application.

## What is a JSON document?

JavaScript Object Notation, or [JSON](https://www.json.org), is a lightweight data format. JSON was built to be highly compatible with the literal notation of an object in the JavaScript language. Many frameworks, browsers, and even databases support JavaScript natively making JSON a popular format for transmitting and storing data.

Here is an example of a JSON document:

:::code language="json" source="../samples/3-document.json" range="1-6":::

As you can see, JSON is a relatively readable data format that clearly exposes its content. JSON is also relatively easy to parse and use in JavaScript applications.

## What is Azure Cosmos DB SQL API?

Azure Cosmos DB SQL API is a fast NoSQL database service that offers rich querying over diverse data, helps deliver configurable and reliable performance, is globally distributed, and enables rapid development.

<!-- Source for the following diagram is at https://commons.wikimedia.org/wiki/File:Simplified_blank_world_map_without_Antartica_(no_borders).svg -->
<!-- We will need to replace this with approved art -->
:::image type="content" source="../media/2-azure-cosmos-db.svg" alt-text="An illustration of a world map with four globally distributed nodes that are connected via lines" border="false":::

Azure Cosmos DB SQL API has a few advantages such as:

- **Guaranteed speed at any scale**—even through bursts—with instant, limitless elasticity, fast reads, and multi-master writes, anywhere in the world
- **Fast, flexible app development** with SDKs for popular languages, a native Core (SQL) API along with APIs for MongoDB, Cassandra, and Gremlin, and no-ETL (extract, transform, load) analytics
- **Ready for mission-critical applications** with guaranteed business continuity, 99.999-percent availability, and enterprise-level security
- **Fully managed and cost-effective serverless database** with instant, automatic scaling that responds to application needs

These capabilities make Azure Cosmos DB ideally suited for modern application development. Azure Cosmos DB SQL API is especially suited for applications that:

- Experience unpredictable spikes and dips in traffic
- Generate lots of data
- Need to deliver real-time user experiences
- Are depended upon for business continuity

The Azure Cosmos DB SQL API can arbitrarily store native JSON documents with flexible schema. Data is indexed automatically and is available for query using a flavor of the SQL query language designed for JSON data. the SQL API also supports cross-document transactions written in JavaScript and executed server-side. The SQL API can be accessed using SDKs for popular frameworks such as [.NET](/azure/cosmos-db/sql-api-sdk-dotnet-standard), [Python](/azure/cosmos-db/sql-api-sdk-python), [Java](/azure/cosmos-db/sql-api-sdk-java-v4), and [Node.js](/azure/cosmos-db/sql-api-sdk-node). The SQL API can also be accessed using a [RESTful HTTP API](/rest/api/cosmos-db/) endpoint.
