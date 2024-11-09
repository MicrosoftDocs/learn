Requests return status code **429** for the exception **request rate too large** status code. This status code indicates that your requests against Azure Cosmos DB are being rate-limited.

When provisioned throughput is used, the request units per second (RU/s) is set for the workload.  Operations (read, writes, queries) against the service consume request units (RUs). If, in any given second, the operations consume more RUs than the provisioned RU/s, Azure Cosmos DB will return a 429 exception. Let's review the three different reasons why this exception is encountered.

## Request rate is large

Request rate is large is the most common reason for a 429 exception. Review occurrences of this exception in the Azure Cosmos DB Insight report **Total Request by Status Code** under the *Request* tab. Review what is the percentage of 429 exceptions vs. successful requests against your database. 

By default, the Azure Cosmos DB SDK will retry 429 exceptions 10 times before returning a 429 exception to your application. When the SDK retries are exceeded, the error is returned to your application. Ideally inspecting the **x-ms-retry-after-ms** header in the response can be used as a hint to decide how long to wait before retrying the request. Another alternative would be an exponential back-off algorithm or configuring the client to extend the retries on 429 exceptions.

No action should be required, if your analysis of the chart determines that 1-5% of the workload requests are generating a 429 exception, and end-to-end latency is acceptable. This small percentage of exceptions is a healthy sign of RU/s utilization.

However, if the percentage of 429 exceptions is higher than 5%, it's possible the exceptions are caused by a hot partition. If a relative small number of logical partition keys consume a much larger amount of the total request units per second, that can create a hot partition. Hot partitions can cause 429 exceptions by not distributing the throughput across multiple partitions better. 

In addition to the percentage of 429 exceptions to monitor, another key metric to monitor along with these is average request latency. When the service, or your application, retries requests due to 429 exceptions, latency increases as operations have to wait to complete. If this gets too high for the application to tolerate, increasing throughput for a container may be needed to handle the volume of concurrent operations if the cause is not due to hot partitions.

To determine if we have a hot partition, review the Azure Cosmos DB insight report **Normalized RU Consumption (%) By PartitionKeyRangeID** under the *Throughput* tab. In this report, the *PartitionKeyRangeID* identifies each physical partition. Any physical partition that is identified with a significant higher consumption on this chart, could be a hot partition. It's especially true if that physical partition stays at 100% constantly, while the other physical partitions remain at much lower percentages almost all of the time.

To determine which request types are causing the 429 exceptions, running a query under **Azure Diagnostic Logs** can return the RUs consumed by request type. The sample query below returns the average RUs per minute per operation for those operations with 429 exceptions.

```kusto
AzureDiagnostics
| where TimeGenerated >= ago(24h)
| where Category == "DataPlaneRequests"
| summarize throttledOperations = dcountif(activityId_g, statusCode_s == 429), totalOperations = dcount(activityId_g), totalConsumedRUPerMinute = sum(todouble(requestCharge_s)) by databaseName_s, collectionName_s, OperationName, requestResourceType_s, bin(TimeGenerated, 1min)
| extend averageRUPerOperation = 1.0 * totalConsumedRUPerMinute / totalOperations 
| extend fractionOf429s = 1.0 * throttledOperations / totalOperations
| order by fractionOf429s desc
```

Some possible solutions to this type of 429 exception are:
- If it's determined that the 429 exceptions occur because of a hot partition, consider changing the partition key. This can be accomplished by migrating the data to a new container with a new partition key. See the documentation for options on how to do this.
- If the exceptions aren't caused by a hot partition, increasing the RU/s on the container might be the solution.
- If the exceptions occur on query document requests, troubleshoot the queries with high RU charge.

## Rate-limiting on metadata requests

A high volume of metadata operations can cause 429 exceptions. Metadata operations are those operations that list, create, modify, or delete database or containers. They could also be operations like querying the current provisioned throughput.

Review occurrences of this type of 429 exception in the Azure Cosmos DB Insight report **Metadata Requests That Exceeded Capacity (429s)** under the *System* tab. 

If this type of request causes 429 exceptions, increasing the provisioned RU/s isn't recommended. Increasing the provisioned RU/s won't have any impact on the occurrence of the exceptions. There's a system-reserve RU limit for metadata requests.

Possible solutions for 429 exceptions caused by metadata requests are:
- Consider implementing a backoff policy to perform the metadata requests at a lower rate.
- Use a single CosmosClient instance for the lifetime of your application.
- Cache the names of the databases and containers within your application.

## Rate-limiting due to transient service error

If this type of request causes 429 exceptions, increasing the provisioned RU/s isn't recommended. Just increasing the provisioned RU/s won't have any impact on the occurrence of the exceptions. Retrying the request is the only recommended solution, if the exception persists, open a support ticket from the Azure portal. Transient service errors might also be reported around the same time you're getting 429 errors.

