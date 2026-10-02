In this module, you transformed the Contoso schema from nine relational tables into three Azure Cosmos DB containers. You first identified business ownership and lifecycle boundaries, then used access patterns to optimize the item model. Finally, you selected partitioning strategies that distribute storage and throughput across tenants of different sizes.

## What you learned

- Begin by identifying candidate aggregate roots from business ownership, lifecycle, and consistency requirements.
- Use access patterns to test and optimize aggregate boundaries rather than deriving ownership from queries alone.
- Embed bounded data that belongs to an aggregate. Reference data that is independently owned, shared, or unbounded.
- Treat copied and pre-aggregated values as projections with an authoritative source, synchronization mechanism, and acceptable consistency window.
- Keep aggregate, item, logical-partition, and container boundaries distinct. An item is a JSON document, while a logical partition defines routing, scale, and the scope of multi-item transactions.
- Co-locate separate aggregate items under the same partition-key value when the workload benefits from single-partition queries or multi-item transactions.
- Select a partition key by evaluating cardinality, storage and request distribution, immutability, and alignment with important query filters.
- A logical partition can hold up to 20 gigabytes (GB) and serve up to 10,000 request units per second (RU/s). A physical partition can hold up to 50 GB and serve up to 10,000 RU/s.
- Use hierarchical partition keys when prefix routing and growth beyond one logical partition are required. Use synthetic keys when the source data has no property that provides sufficient distribution.
- Review the design for unbounded items, ambiguous sources of truth, fan-out queries, hot partitions, and tenant skew before creating production containers.
- Estimate cost from measured request charges, peak operation rates, storage, regions, backup, data transfer, and optional features.

## Learn more

- [Partitioning and horizontal scaling in Azure Cosmos DB](/azure/cosmos-db/partitioning)
- [Hierarchical partition keys in Azure Cosmos DB](/azure/cosmos-db/hierarchical-partition-keys)
- [Create a synthetic partition key](/azure/cosmos-db/synthetic-partition-keys)
- [Data modeling in Azure Cosmos DB for NoSQL](/azure/cosmos-db/modeling-data)
- [Model and partition data on Azure Cosmos DB for NoSQL](/azure/cosmos-db/model-partition-example)
- [Container copy jobs in Azure Cosmos DB](/azure/cosmos-db/container-copy)
- [Create an alert on the logical partition key storage size](/azure/cosmos-db/how-to-alert-on-logical-partition-key-storage-size)
- [Azure Cosmos DB Cost Estimator](https://cosmos.azure.com/costestimator/)
- [Multitenancy and Azure Cosmos DB](/azure/architecture/guide/multitenant/service/cosmos-db)

## Clean up resources

If you created an Azure Cosmos DB account for the exercise and no longer need it, delete its resource group in the Azure portal to stop incurring charges.
