<!--Need to rewrite so you are only discussing this module. See the guidance on how to write this unit. See the mini-toc and rubric in this article for key points: https://review.docs.microsoft.com/help/learn/id-guidance-module-summary-unit?branch=master#rubric -->

At the beginning of the first module we started with a relational database model that had nine tables. Throughout both of the modules we learned about the importance of understanding the usage patterns for data for determining how to model and partition data. We also explored when you would embed versus reference data in a NoSQL model. We explored partitioning, and made sure data was partitioned to ensure both requests and storage were even and high volume queries were served by one logical partition, allowing for infrequently run queries to run as cross partition. We demonstrated how using features like Change Feed can help maintain referential integrity across containers and transactions can be used to materialize aggregates for in-partition data.

All of these concepts and techniques explored in both of the modules for this lab ensure that our final database design is efficient in terms of compute and can scale as either the size of the database grows or the amount of throughput is increased to handle a higher volume of operations.

## Learn more

- [Understanding the differences between NoSQL and relational databases](https://docs.microsoft.com/azure/cosmos-db/relational-nosql)
- [Data modeling in Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/modeling-data)
- [How to model and partition data on Azure Cosmos DB using a real-world example](https://docs.microsoft.com/azure/cosmos-db/how-to-model-partition-example)
- [Change Feed in Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/change-feed)
- [Transactional batch operations in Azure Cosmos DB using the .NET SDK](https://docs.microsoft.com/azure/cosmos-db/transactional-batch)
