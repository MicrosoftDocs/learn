In this module, you learned key concepts, techniques, and technologies that are used to model and partition data for NoSQL databases, such as Azure Cosmos DB. You applied them to your e-commerce application, which you needed to migrate from a relational database to a NoSQL database. 

The concepts you learned about in this module include:

* **Denormalization**: You applied this concept to your product data and measured the performance versus querying individual containers.
* **Referential integrity**: You learned how to use change feed to help maintain referential integrity between data that's stored in two different containers.
* **Combining entities**: You learned when it makes sense to store different entities in the same container.
* **Denormalizing aggregates**: You learned a technique that improves performance on high concurrency queries that involve aggregate values on data. You applied it to scenarios that require a subquery to first do a *group by and aggregate*, then do an outer query with an *order by* on the results. You also learned about transactions in Azure Cosmos DB and an SDK feature called transactional batch.

Applying these concepts, techniques, and technologies help ensure that your final database design is efficient in terms of compute. This means that it can scale out as either the size of the database grows or the amount of throughput is increased to handle a higher volume of operations.

Now that you have completed this module, you can:

- Manage relationships between data entities by using advanced modeling and partitioning strategies.
- Maintain the referential integrity of your data by using change feed.
- Implement pre-aggregating and denormalizing data strategies to improve data-model performance and scaling.
- Optimizing storage and compute by mixing entity types in a single container

## Learn more

* [Understand the differences between NoSQL and relational databases][/azure/cosmos-db/relational-nosql]
* [Data modeling in Azure Cosmos DB][/azure/cosmos-db/modeling-data]
* [Model and partition data on Azure Cosmos DB by using a real-world example][/azure/cosmos-db/how-to-model-partition-example]
* [Change feed in Azure Cosmos DB][/azure/cosmos-db/change-feed]
* [Transactional batch operations in Azure Cosmos DB that use the .NET SDK][/azure/cosmos-db/transactional-batch]

[/azure/cosmos-db/relational-nosql]: https://docs.microsoft.com/azure/cosmos-db/relational-nosql
[/azure/cosmos-db/modeling-data]: https://docs.microsoft.com/azure/cosmos-db/modeling-data
[/azure/cosmos-db/how-to-model-partition-example]: https://docs.microsoft.com/azure/cosmos-db/how-to-model-partition-example
[/azure/cosmos-db/change-feed]: https://docs.microsoft.com/azure/cosmos-db/change-feed
[/azure/cosmos-db/transactional-batch]: https://docs.microsoft.com/azure/cosmos-db/transactional-batch
