In Azure Cosmos DB, throughput is the rate at which data is processed. It's measured in _Request Units (RUs)_. An RU is the amount of CPU, disk I/O, and memory required to read 1 KB of data in 1 second. Other operations like reading more data, writing data, or querying data take more RUs. The greater the demand on the underlying physical resources, the higher the number of RUs used.

The number of RUs that a specific operation uses depends on the following factors:

- How the data is distributed across the physical resources in Azure
- Volume of data that's read and written
- Whether the operation is a read or a write
- Number of fields in your database that are indexed, and the indexing mode
- Complexity of the operation for queries
- Data consistency for geographically-replicated collections

We don't address geo-replication in this module.

## Maximum RUs that you need

When you create an Azure Cosmos DB collection, you configure a fixed maximum number of RUs. The sum of RUs that all of the operations consume in the collection must be less than this value. If you exceed this value, requests to the database are throttled.

To operate an Azure Cosmos DB database efficiently, you need to:

- Configure enough throughput to meet performance demands.
- Minimize unused excess throughput to keep your costs down.
- Regularly review metrics to maximize the efficiency of your provisioned throughput.

## Billing based on capacity you've configured

RUs are billed on an hourly basis, whether you consume them. The amount that you're charged for your Azure Cosmos DB collection is fixed. It's based only on the configured capacity in RUs.
