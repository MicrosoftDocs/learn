Azure Cosmos DB is Microsoft's fully managed NoSQL database on Azure. As a NoSQL database, Cosmos DB is both horizontally scalable and non-relational. The horizontal scalability allows Cosmos DB grow to sizes well beyond the size of a typical relational database. Also because it is horizontally scalable, it does not implement relational constraints on data, allowing Cosmos DB to provide predictable performance.

To achieve this level of scalability, users need to understand the concepts, techniques and technologies for modeling and partitioning data unique to NoSQL databases.

## Scenario

Imagine that you work for a retail startup that's designing a database to manage online orders. You're working on a proposal for an efficient database design. You've been given a relational model to start from. To improve scalability and performance, you want to migrate the model to NoSQL. But to do so the data needs to be modeled correctly to realize the best efficiency and performance.

The following diagram shows the model you will be starting from. The relational model has nine entities each in their own table.

:::image type="content" source="../media/1-full-relational-model.png" alt-text="Diagram that shows the relational model for our example application." border="false":::

## What will we be doing?

In this module we take our existing relational data model and redesign it as a NoSQL database for our e-commerce application. During this process you will learn the following:

- **Differences between relational vs. NoSQL databases:** We will explore how NoSQL databases differ relational databases and why they are that way.
- **Using access patterns to model data:** We will learn how understanding how an application reads and writes data influences how to model it for a NoSQL database.
- **Embedding versus referencing:** We will learn when you should embed data within the same document versus when you should store data as a separate row.
- **Choosing a partition key:** We will learn key concepts for choosing a partition key including how to avoid hot partitions and how to handle scenarios where you have workloads that are both read and write heavy.
- **Modeling lookup or reference data:** Finally, we will learn how to model data that is used as a reference or lookup for other data.

## What is the main goal?

By the end of this module, when combined with the companion module, Advanced Modeling Patterns for Azure Cosmos DB, you will have the knowledge and skills necessary to properly model and partition data for a NoSQL database like Azure Cosmos DB.
