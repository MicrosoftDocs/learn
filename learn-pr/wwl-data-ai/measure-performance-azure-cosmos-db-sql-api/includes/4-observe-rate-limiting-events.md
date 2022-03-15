In this unit, we'll discuss methods of how to identify rate-limiting events. 

While using the Azure Cosmos DB *SQL API*, Azure Cosmos DB might return a **429** *status code error*. This error code, indicates that a **Request rate too large** exception has occurred. This exception means that Azure Cosmos DB requests are being rate limited.

When provisioned throughput is used, the request units per second (RU/s) is set for the workload.  Operations (read, writes, queries) against the service consume request units(RUs). If in any given second, the operations consume more RUs than the provisioned RU/s, Azure Cosmos DB will return a 429 exception.

There are three main reasons why we get a 429 exception:
- Request rate is large.
- The request did not complete due to a high rate of metadata requests.
- The request did not complete due to a transient service error.

We'll look at each of these reasons and how to identify them.

## Request rate is large

Out of the three reasons for this exception, this reason is the most common one. Azure Cosmos DB returns this exception when the RUs by operations on data exceed the provisioned RU/s.

The first step to research a **429** exception, is that in the Azure portal under the Azure Cosmos DB account, under  **Insights->Request**, review the **Total Request by Status Code** charts for occurrences of the exception. Further filter the charts by *Time Range* and *Database* to your desired time span and database. For most applications, it's normal to have less than 5% of the request with 429 exceptions.

:::image type="content" source="../media/4-monitor-429-exception.png" alt-text="Diagram that shows the charts by Status code and Throttled Request (429 exceptions).":::

If the percentage of 429 exceptions is higher than 5%, it's possible that the exceptions are caused by a hot partition. 

To verify if the database access is coming across a hot partition, in the Azure portal under the Azure Cosmos DB account, under  **Insights->Throughput**, review the **Normalized RU Consumption (%) By PartitionKeyRangeID** charts.

:::image type="content" source="../media/4-monitor-hot-partition.png" alt-text="Diagram that shows the charts by throughput of a hot partition.":::

## Rate limiting on metadata requests

A 429 exception can occur when doing a high volume of the following metadata operations:

- Create, read, update, or delete a container or database
- List databases or containers in a Cosmos account
- Query the current provisioned throughput

To investigate if 429 exceptions are caused by Metadata requests,  in the Azure portal under the Azure Cosmos DB account, under **Insights->System**, review the **Metadata Requests That Exceeded Capacity (429s)** charts.

:::image type="content" source="../media/4-monitor-metadata.png" alt-text="Diagram that shows the charts for metadata access.":::

## Rate limiting due to transient service error

Around the time, you're noticing 429 exceptions happening, you might also notice 503 errors being reported in the **Insights->Request**  **Total Request by Status Code** charts. These exceptions could indicate that the 429 exceptions are happening because of transient service errors.
