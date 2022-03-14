Next, let's consider the data for your database. Adequate throughput is important to ensure you can handle the volume of transactions for your business needs. Throughput requirements aren't always consistent. For example, you may be building a shopping website that needs to scale during sales or holidays. We'll start by learning about request units and how to estimate throughput requirements.

## Provisioning throughput for containers and databases

In Azure Cosmos DB, you provision throughput for your containers to run writes, reads, updates, and deletes. You can provision throughput for an entire database and have it shared among containers within the database. You can also provision throughput dedicated to specific containers.

Setting provisioned throughput at a container is the most frequently used option. Throughput is reserved only for that container and it's evenly distributed among its physical partitions.

Throughput on an Azure Cosmos database is shared across all the containers in the database. An exception is if you specified a provisioned throughput on specific containers in the database. No predictable throughput guarantees for a particular container in that database are provided.

To scale throughput strategically, you need to estimate your throughput needs by estimating the number of operations you'll have to support at different times. If your requests consume all of the provisioned throughput, Azure Cosmos DB will rate-limit your requests. Operations will have to wait and retry, likely causing higher latency.

## What is a request unit?

Azure Cosmos DB measures throughput using something called a **request unit (RU)**. Request unit usage is measured per second, so the unit of measure is **request units per second (RU/s)**. You must reserve the number of RU/s you want Azure Cosmos DB to provision in advance, so it can handle the load you've estimated, and you can scale your RU/s up or down at any time to meet current demand.

## Request unit basics

A single request unit, one RU, is equal to the approximate cost of performing a single GET request on a 1-KB document using a document's ID. Performing a GET by using a document's ID is an efficient means for retrieving a document, and thus the cost is small. Creating, replacing, or deleting the same item requires additional processing by the service, and therefore requires more request units.

The number of request units consumed for an operation changes depending on the document size, the number of properties in the document, the operation being performed, and some additional concepts such as consistency and indexing policy.

When provisioning throughput, you should understand how many RUs your most common operations consume. You can [obtain the request unit charge](/azure/cosmos-db/find-request-unit-charge) for any operation on your Azure Cosmos DB containers. Multiply the number of consumed RUs of each operation by the estimated number of times each operation (write, read, update, and delete) will be executed per second. If you run several different queries on your data, you should understand how many RUs each query will consume. By summing the number of consumed RUs for each operation, you'll be able to accurately estimate how many RUs to provision.

Azure Cosmos DB guarantees that the number of RUs for a given database operation for the same dataset is deterministic. Understanding  your application's throughput requirements and the factors that affect RU charges will allow you run your application cost effectively.

You provision the number of RUs on a per-second basis and you can change the value at any time in increments or decrements of 100 RUs. You can make your changes either programmatically or by using the Azure portal. You're billed on an hourly basis.

## Request Unit considerations

While you estimate the number of RUs per second to provision, consider the following factors:

* **Item size**: As the size of an item increases, the number of RUs consumed to read or write the item also increases.

* **Item indexing**: By default, each item is automatically indexed. Fewer RUs are consumed if you choose not to index some of your items in a container.

* **Item property count**: Assuming the default indexing is on all properties, the number of RUs consumed to write an item increases as the item property count increases.

* **Indexed properties**: An index policy on each container determines which properties are indexed by default. To reduce the RU consumption for write operations, limit the number of indexed properties.

* **Data consistency**: The strong and bounded staleness consistency levels consume approximately two times more RUs on read operations when compared to that of other relaxed consistency levels.

* **Query patterns**: The complexity of a query affects how many RUs are consumed for an operation. Factors that affect the cost of query operations include: 
    
    - The number of query results
    - The number of predicates
    - The nature of the predicates
    - The number of user-defined functions
    - The size of the source data
    - The size of the result set
    - Projections

  Azure Cosmos DB guarantees that the same query on the same data always costs the same number of RUs on repeated executions.

* **Script usage**: As with queries, stored procedures and triggers consume RUs based on the complexity of their operations. As you develop your application, inspect the [request charge header](/azure/cosmos-db/optimize-cost-queries#evaluate-request-unit-charge-for-a-query) to better understand how much RU capacity each operation consumes.

## Exceeding throughput limits

If you attempt to use throughput higher than the one provisioned, your request will be rate-limited. When a request is rate-limited, the request has to be retried again after a specified interval. The .NET SDK will automatically retry your request after waiting the amount of time specified in the *retry-after* header.

## Creating an account built to scale

You can change the number of request units provisioned to a database at any time. So, during heavy volume periods, you can scale up to accommodate those high demands, and then reduce provisioned throughput during off peak times to reduce costs.

When you create an account, you can provision a minimum of 400 RU/s, or a maximum of 250,000 RU/s in the portal. If you need even more throughput, fill out a ticket in the Azure portal. 

## Summary

You now understand how to estimate and scope throughput for an Azure Cosmos DB using request units. Request units can be modified at any time.
