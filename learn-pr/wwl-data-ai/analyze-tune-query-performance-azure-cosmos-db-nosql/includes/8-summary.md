Query tuning in Azure Cosmos DB for NoSQL is a measurement discipline. Every operation reports its request charge. Queries can also return execution and index metrics, so you can investigate the work behind the charge before choosing a fix.

## What you learned

- Every operation returns its request charge. Compare recent measurements under matching data, account settings, and query options. Combining the charge with how often the operation runs identifies the queries worth tuning.
- The server-side query metrics report retrieved and output document counts, index hit ratio, and a per-partition breakdown, and the four causes of a 429 response call for four different responses.
- A retrieved count far above the output count can indicate document scanning. Check the query shape before attributing the gap to an unsupported filter. Index metrics name the utilized and potential paths, and the index impact score reflects the query shape rather than your data.
- Each physical partition holds its own index. An equality filter on the partition key routes to one partition, while an `IN` filter can reach one or more relevant partitions. A range filter or no partition key filter fans out across all of them.

## Clean up resources

The exercise used the Azure Cosmos DB account shared across this learning path. If you're finished with the course, delete the resource group only if you created it and every resource in it can be removed. Keep a lab-provided or shared resource group, and delete only the exercise resources you no longer need.

## Learn more

- [Tune query performance in Azure Cosmos DB](/azure/cosmos-db/query-metrics)
- [Get query performance and execution metrics](/azure/cosmos-db/query-metrics-performance)
- [Indexing metrics in Azure Cosmos DB](/azure/cosmos-db/index-metrics)
- [Troubleshoot query issues in Azure Cosmos DB for NoSQL](/azure/cosmos-db/troubleshoot-query-performance)
- [Diagnose and troubleshoot 429 exceptions](/azure/cosmos-db/troubleshoot-request-rate-too-large)
- [Query performance tips for SDKs](/azure/cosmos-db/performance-tips-query-sdk)
