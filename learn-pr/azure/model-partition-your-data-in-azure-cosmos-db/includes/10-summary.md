In this module we've started the process of taking a relational database and modeling it for a NoSQL database. We've designed the three customer entities and embedded all three into a single document, which resulted in an increase in performance by reducing the number of requests for our data. We have also modeled the product category and product tag entities and leveraged a unique technique to reduce overall storage and throughput required for small lookup tables.

## Notes

To learn more about these concepts in Azure Cosmos DB, see:

-[Understanding the differences between NoSQL and relational databases](https://docs.microsoft.com/azure/cosmos-db/relational-nosql)
-[Data modeling in Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/modeling-data)
-[How to model and partition data on Azure Cosmos DB using a real-world example](https://docs.microsoft.com/azure/cosmos-db/how-to-model-partition-example)
-[Partitioning and horizontal scaling in Azure Cosmos DB](https://docs.microsoft.com/cosmos-db/partitioning-overview)
-[Partitioning strategy and provisioned throughput costs](https://docs.microsoft.com/azure/cosmos-db/optimize-cost-throughput#partitioning-strategy-and-provisioned-throughput-costs)