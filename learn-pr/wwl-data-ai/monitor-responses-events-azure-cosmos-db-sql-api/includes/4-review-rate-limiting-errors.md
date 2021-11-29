Request return status code **429** for the exception **request rate too large** status code. This status code indicates that your requests against Azure Cosmos DB are being rate-limited.

When provisioned throughput is used, the request units per second (RU/s) is set for the workload.  Operations (read, writes, queries) against the service consume request units(RUs). If, in any given second, the operations consume more RUs than the provisioned RU/s, Azure Cosmos DB will return a 429 exception. Let's review the three different reasons why this exception is encountered.

## Request rate is large

Request rate is large is the most common reason for a 429 exception. Review occurrences of this exception in the Azure Cosmos DB Insight report **Total Request by Status Code** under the *Request* tab. Review what is the percentage of 429 exceptions occur vs. successful requests against your database. 

While you could see 429 exceptions in your charts, notes that many applications are designed to retry one or more times if this type of exception is encountered. So it's possible your applications could be managing the throttling without returning any errors.

No action should be required, if your analysis of the chart determines that 1-5% of the workload requests are generating a 429 exception, and end-to-end latency is acceptable. This small percentage of exceptions is a healthy sign of RU/s utilization.

However, if the percentage of 429 exceptions is higher than 5%, it's possible the exceptions are caused by a hot partition. If a relative small number of logical partition keys consume a much larger amount of the total request units per second, that can create a hot partition. Hot partitions can cause 429 exception by not distributing the throughput across multiple partitions better. 

To determine if we have a hot partition, review the Azure Cosmos DB insight report **Normalized RU Consumption (%) By PartitionKeyRangeID** under the *Throughput* tab. In this report, the *PartitionKeyRangeID* identify each physical partition. Any physical partition that is identified with a significant higher consumption on this chart, could be a hot partition. It's specially true if that physical partition stays at 100% constantly, and while the other physical partitions remain at much lower percentages all most of the time.

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

Some possible solutions to this type of 429 exceptions:
- If it's determined that the 429 exceptions occur because of a hot partition, consider changing the partition key. 
- If the exceptions aren't caused by a hot partition, increasing the RU/s on the container might be the solution.
- If the exceptions occur on query document requests, troubleshoot the queries with high RU charge.

## Rate-limiting on metadata requests

A high volume of metadata operations can cause 429 exceptions. Metadata operations are those operations who list, create, modify, or delete database or containers. They could also be operations like querying the current provisioned throughput.

Review occurrences of this type of 429 exception in the Azure Cosmos DB Insight report **Metadata Requests That Exceeded Capacity (429s)** under the *System* tab. 

If this type of request causes 429 exceptions, increasing the provisioned RU/s isn't recommended. Increasing the provisioned RU/s won't have any impact on the occurrence of the exceptions. There's a system-reserve RU limit for metadata request.

Possible solutions for 429 exceptions caused by metadata request:
- Consider implementing a backoff policy to perform the metadata requests at a lower rate.
- Use a single DocumentClient instance for the lifetime of your application
-  Cache the names of the databases and containers.

## Rate-limiting due to transient service error

If this type of request causes 429 exceptions, increasing the provisioned RU/s isn't recommended. Just increasing the provisioned RU/s won't have any impact on the occurrence of the exceptions. Retrying the request is the only recommended solution, if the exception persists, open a support ticket from the Azure portal. Transient service errors might also be reported around the same time you're getting 429 errors.

