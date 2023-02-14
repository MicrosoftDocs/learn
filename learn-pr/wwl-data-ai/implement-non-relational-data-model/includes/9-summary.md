In this module, you learned key concepts and techniques for modeling and partitioning data for NoSQL databases like Azure Cosmos DB. We applied these to our e-commerce application that we needed to migrate from a relational database to a NoSQL database. The things that you learned in this module include:

- **Differences between relational versus NoSQL databases**: You learned how NoSQL databases like Azure Cosmos DB are horizontally scalable, whereas relational databases are typically vertically scalable.
- **Using access patterns to model data**: You learned how understanding an application's access patterns to data plays an important role in how to model and partition data.
- **Embedding versus referencing**: You learned when you should embed different entities within the same document versus when you should reference the data and store it as separate rows.
- **Choosing a partition key**: You learned key concepts for choosing a partition key. These concepts include how to avoid hot partitions and how to handle workloads that are both read and write heavy.
- **Modeling lookup or reference data**: Finally, you learned how to model data that's used as a lookup or reference for other data.

We applied all of these concepts and techniques to a relational database to model it for a NoSQL database. We modeled the three customer entities and embedded them in a single document. This resulted in an increase in performance by reducing the number of requests for the data. 

We also modeled the product category and product tag entities. And we used a special technique to reduce the overall storage and throughput required for small lookup tables.

Now that you have completed this module, you can:

- Determine access patterns for data.
- Apply data model and partitioning strategies to support an efficient and scalable NoSQL database.

## Learn more

- [Understanding the differences between NoSQL and relational databases][/azure/cosmos-db/relational-nosql]
- [Data modeling in Azure Cosmos DB][/azure/cosmos-db/modeling-data]
- [How to model and partition data on Azure Cosmos DB using a real-world example][/azure/cosmos-db/how-to-model-partition-example]
- [Partitioning and horizontal scaling in Azure Cosmos DB][/azure/cosmos-db/partitioning-overview]
- [Partitioning strategy and provisioned throughput costs][/azure/cosmos-db/optimize-cost-throughput#partitioning-strategy-and-provisioned-throughput-costs]

[/azure/cosmos-db/relational-nosql]: /azure/cosmos-db/relational-nosql
[/azure/cosmos-db/modeling-data]: /azure/cosmos-db/modeling-data
[/azure/cosmos-db/how-to-model-partition-example]: /azure/cosmos-db/how-to-model-partition-example
[/azure/cosmos-db/partitioning-overview]: /azure/cosmos-db/partitioning-overview
[/azure/cosmos-db/optimize-cost-throughput#partitioning-strategy-and-provisioned-throughput-costs]: /azure/cosmos-db/optimize-cost-throughput#partitioning-strategy-and-provisioned-throughput-costs