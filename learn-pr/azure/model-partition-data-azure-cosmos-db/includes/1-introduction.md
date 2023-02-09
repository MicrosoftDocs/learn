Azure Cosmos DB is Microsoft's fully managed NoSQL database on Azure. As a NoSQL database, Azure Cosmos DB is both horizontally scalable and nonrelational. 

The horizontal scalability allows Azure Cosmos DB to grow to sizes well beyond the size of a typical relational database. Horizontal scalability also means that the database provides predictable performance, because it doesn't implement relational constraints on data.

To achieve this level of scalability, we need to understand the concepts, techniques, and technologies unique to NoSQL databases for modeling and partitioning data.

## Scenario

Imagine that you work for a retail startup that's designing a database to manage online orders. You're working on a proposal for an efficient database design. You've been given a relational model to start from. To improve scalability and performance, you want to migrate the model to NoSQL. The data needs to be modeled correctly to realize the best efficiency and performance.

The following diagram shows the model you'll start from. The relational model has nine entities in their own tables.

:::image type="content" source="../media/1-full-relational-model.png" alt-text="Diagram that shows the relational model for our example application." border="false":::

## What will we be doing?

In this module, we'll take our existing relational data model and redesign it as a NoSQL database for our e-commerce application. During this process, you'll learn the following concepts:

- **Differences between relational versus NoSQL databases**: You'll explore how NoSQL databases differ from relational databases and why they're that way.
- **Using access patterns to model data**: You'll learn how understanding the way an application reads and writes data influences how to model it for a NoSQL database.
- **Embedding versus referencing**: You'll learn when you should embed data within the same document versus when you should store data as a separate row.
- **Choosing a partition key**: You'll learn key concepts for choosing a partition key. Information includes how to avoid hot partitions and how to handle workloads that are both read and write heavy.
- **Modeling lookup or reference data**: Finally, you'll learn how to model data that's used as a lookup or reference for other data.

## What is the main goal?

When you finish this module and the companion module, "Optimize your database by using advanced modeling patterns for Azure Cosmos DB," you'll have the knowledge and skills to properly model and partition data for a NoSQL database like Azure Cosmos DB.
