Azure Cosmos DB is Microsoft's fully managed NoSQL database on Azure. As a NoSQL database, Azure Cosmos DB is both nonrelational and horizontally scalable or scales out. This ability to scale out is achieved by adding more nodes, or partitions, to a container.

This ability to scale out allows containers to grow to a theoretically infinite size. So as a container grows in size, the container can also handle increasing numbers of requests, providing the same performance regardless of how large the container gets.

However, to achieve this level of scalability, users need to understand the concepts and techniques unique to Azure Cosmos DB for modeling and partitioning data. The users also need to understand as the concepts for NoSQL databases in general.

## Scenario

Imagine that you work for a retail startup that's designing a database to manage online orders. You're working on a proposal for an efficient database design using Azure Cosmos DB for NoSQL. You are provided with an entity-relationship model to start from. You want to provide the maximum scalability, performance, and efficiency possible and to achieve this task so the data needs to be modeled correctly.

The following entity-relationship diagram (ER model) provides you with the details of the nine entities you expect to work with. The relational model has nine entities in their own tables.

:::image type="content" source="../media/1-full-relational-model.png" alt-text="Diagram that shows the relational model for our example application.":::

## How do we accomplish this?

In this module, we take our existing relational data model and redesign it as a NoSQL database for our e-commerce application. During this process, you learn the following concepts:

- **Differences between relational versus NoSQL databases**: You explore some of the differences between NoSQL databases and relational databases and why they're that way.
- **Using application data access patterns to model data**: You learn how understanding the way an application reads and writes data influences how to model it for a NoSQL database.
- **Embedding versus referencing**: You learn when you should embed data within the same document versus when you should store data as a separate document.
- **Choosing a partition key**: You learn key concepts needed for choosing the best partition key to achieve the ability to scale out, and optimize workloads that are either read or write heavy, or both.
- **Modeling lookup or reference data**: Finally, you learn how to model data that's used as a lookup or reference for other data.

## What is the main goal?

When you finish this module (and the companion module, *Optimize your database by using advanced modeling patterns for Azure Cosmos DB*), you'll have the knowledge and skills to properly model and partition data for a NoSQL database deployed on Azure Cosmos DB.

After completing this module, you’ll be able to:

- Determine access patterns for data.
- Apply data model and partitioning strategies to support an efficient and scalable NoSQL database.

