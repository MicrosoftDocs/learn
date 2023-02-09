Azure Cosmos DB is a fully managed Microsoft NoSQL database on Azure. As a NoSQL database, Azure Cosmos DB is both horizontally scalable and non-relational. Horizontal scalability enables Azure Cosmos DB to grow well beyond the size of typical relational databases. And horizontal scalability doesn't impose relational constraints on data, which means that Azure Cosmos DB can deliver predictable performance.

To achieve this level of scalability, it's important to understand the concepts, techniques, and technologies for modeling and partitioning data that are unique to NoSQL databases. It's also important to understand how relational concepts, such as maintaining referential integrity, are applied in a NoSQL world.

:::image type="content" source="../media/1-introduction.png" alt-text="Diagram that illustrates the horizontal scalability of Azure Cosmos DB." border="false"::::

## Scenario

Imagine that you're working for a retail startup that's designing a database to manage online orders. You're working on a proposal for an efficient database design. You've been given a relational model to start from. To improve scalability, efficiency, and performance, you want to migrate the model to NoSQL. You've modeled most of the entities so far, but there are more entities to model and further optimizations to make.

## What will we be doing?

In this module, you'll complete the redesign of the NoSQL database for your e-commerce application by modeling the product and sales-order entities. During this process, you'll learn about and apply the following concepts:

* **Denormalization**: You'll apply this concept when you model your product data. You'll then measure the performance and cost difference between storing the data in a relational manner and modeling it for a NoSQL database.
* **Referential integrity**: You'll learn how to use a feature called *change feed* to maintain the referential integrity between data that's stored in two different containers. In our e-commerce scenario, you'll see how to use change feed to automatically update all the products in a category when the name of the category is changed.
* **Combining entities**: You'll explore the concept of storing different entities in the same container and learn how to explain when this technique can be applied in a NoSQL model.
* **Denormalizing aggregates**: You'll apply a technique that can help improve performance on queries where you're frequently querying for aggregate values on data. The technique also helps in queries that require a subquery to first do a *group by and aggregate* and then do an *outer query*, with an *order by* on the results. This technique uses Azure Cosmos DB transaction capability and, as part of the process, you'll learn about an SDK feature called *transactional batch*.

## What is the main goal?

After you've finished this module and its companion module [Model and partition your data in Azure Cosmos DB](../../model-partition-data-azure-cosmos-db\1-introduction.yml), you'll have the knowledge and skills necessary to properly model and partition data for a NoSQL database, such as Azure Cosmos DB.
