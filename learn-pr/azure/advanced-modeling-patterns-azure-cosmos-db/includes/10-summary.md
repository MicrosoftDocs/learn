In this module, you learned key concepts, techniques and technologies that are used to model and partition data for NoSQL databases like Azure Cosmos DB. You applied these to our e-commerce application that we needed to migrate from a relational database to a NoSQL database. The things you learned in this module include:

* **De-normalization:** We applied this concept to our product data and measured the performance versus querying individual containers.
* **Referential integrity:** We learned how to use Change Feed to maintain the referential integrity between data stored in two different containers.
* **Combining entities:** We learned when it makes sense to store different entities in the same container.
* **De-normalizing aggregates**: We learned a technique that improves performance on high concurrency queries involving aggregate values on data and for scenarios that require a sub-query to first do a group by and aggregate, then an outer query with an order by on the results. We also learned about transactions in Cosmos DB and an SDK feature called Transactional Batch.

All of these concepts, techniques and technologies explored in this module ensure that our final database design is efficient in terms of compute and can scale as either the size of the database grows or the amount of throughput is increased to handle a higher volume of operations.

## Learn more

* [Understanding the differences between NoSQL and relational databases](/azure/cosmos-db/relational-nosql)
* [Data modeling in Azure Cosmos DB](/azure/cosmos-db/modeling-data)
* [How to model and partition data on Azure Cosmos DB using a real-world example](/azure/cosmos-db/how-to-model-partition-example)
* [Change Feed in Azure Cosmos DB](/azure/cosmos-db/change-feed)
* [Transactional batch operations in Azure Cosmos DB using the .NET SDK](/azure/cosmos-db/transactional-batch)
