# Introduction

Azure Cosmos DB is Microsoft's fully-managed NoSQL database on Azure. As a NoSQL database, Cosmos DB is both horizontally scalable and non-relational. The horizontal scalability allows Cosmos DB grow to sizes well beyond the size of a typical relational database. Also because it is horizontally scalable, it does not implement relational constraints on data. This allows Cosmos DB to provide predictable performance.

To achieve this level of scalability users need to understand the concepts, techniques and technologies for modeling and partitioning data unique to NoSQL databases. It's also important to understand how relational concepts, such as maintaining referential integrity, are applied in a NoSQL world.

:::image type="content" source="../media/1-introduction.png" alt-text="show how Cosmos DB is horizontally scalable":::

## Scenario

Imagine that you work for a retail startup that's designing a database to manage online orders. You're working on a proposal for an efficient database design. You've been given a relational model to start from. To improve scalability and performance, you want to migrate the model to NoSQL. But to do so the data needs to be modeled correctly to realize the best efficiency and performance. You've modeled most of the entities so far but there are additional entities and further optimizations to make.

## What will we be doing?

In this module, we will complete the redesign of the NoSQL database for our e-commerce application by modeling the product and sales order entities. During the process of doing this you will learn the following:

* **De-normalization:** We will apply this concept when we model our product data. We will then measure the performance and cost difference between storing the data in a relational manner, versus when it has been modeled for a NoSQL database.
* **Referential integrity:** We will learn how to use a feature called Change Feed to maintain the referential integrity between data stored in two different containers. In our e-commerce scenario, we will show how this can be used to automatically update all the products for a category when the name of the category is changed.
* **Combining entities:** We will explore the concept of storing different entities in the same container and explain when this technique can be applied in a NoSQL model.
* **De-normalizing aggregates** We will detail a technique that can be used to improve performance on queries where you frequently are querying for aggregate values on data. It also helps in queries that require a sub-query to first do a group by and aggregate, then an outer query with an order by on the results. This technique leverages Cosmos DB transaction capability and we will learn about an SDK feature called Transactional Batch.

## What is the main goal?

By the end of this module, when combined with the companion module, [Model and partition your data in Azure Cosmos DB](./model-partition-data-azure-cosmos-db) you will have the knowledge and skills necessary to properly model and partition data for a NoSQL database like Azure Cosmos DB.
