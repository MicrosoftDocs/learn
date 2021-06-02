In this module we learned key concepts and techniques that are used to model and partition data for NoSQL databases like Azure Cosmos DB. We applied these to our e-commerce application that we needed to migrate from a relational database to a NoSQL database. The things we learned in this module include:

    - **Differences between relational vs. NoSQL databases:** We learned how NoSQL databases like Cosmos DB are horizontally scalable versus relational databases which are typically vertically scalable.
    - **Using access patterns to model data:** We learned how understanding an application's access patterns to data plays an important role in how to model and partition data.
    - **Embedding versus referencing:** We learned when you should embed different entities within the same document versus when you should reference the data and store it as separate rows.
    - **Choosing a partition key:** We learned key concepts for choosing a partition key including how to avoid hot partitions and how to handle scenarios where you have workloads that are both read and write heavy.
    - **Modeling lookup or reference data:** Finally, we learned how to model data that is used as a reference or lookup for other data.

All of these concepts and techniques we applied to our relational database to model it for a NoSQL database. We've modeled the three customer entities and embedded all three into a single document. This resulted in an increase in performance by reducing the number of requests for our data. We have also modeled the product category and product tag entities and used a special technique to reduce overall storage and throughput required for small lookup tables.

## Learn more

- [Understanding the differences between NoSQL and relational databases](/azure/cosmos-db/relational-nosql)
- [Data modeling in Azure Cosmos DB](/azure/cosmos-db/modeling-data)
- [How to model and partition data on Azure Cosmos DB using a real-world example](/azure/cosmos-db/how-to-model-partition-example)
- [Partitioning and horizontal scaling in Azure Cosmos DB](/azure/cosmos-db/partitioning-overview)
- [Partitioning strategy and provisioned throughput costs](/azure/cosmos-db/optimize-cost-throughput#partitioning-strategy-and-provisioned-throughput-costs)