Next, let's consider the data for your database. Adequate throughput is important to ensure you can handle the volume of transactions for your business needs. Throughput requirements aren't always consistent. For example, you may be building a shopping website that needs to scale during sales or holidays. We'll start by learning about request units and how to estimate throughput requirements.

## What is database throughput? 

Database throughput is the number of reads and writes that your database can perform in a single second.

To scale throughput strategically, you need to estimate your throughput needs by estimating the number of reads and writes you'll have to support at different times and for different document sizes. If you estimate correctly, you'll keep your customers happy when demand spikes. If you estimate incorrectly, your requests can get rate-limited and operations will have to wait and retry, likely causing high latency and unhappy customers.

## What is a request unit?

Azure Cosmos DB measures throughput using something called a **request unit (RU)**. Request unit usage is measured per second, so the unit of measure is **request units per second (RU/s)**. You must reserve the number of RU/s you want Azure Cosmos DB to provision in advance, so it can handle the load you've estimated, and you can scale your RU/s up or down at any time to meet current demand.

## Request unit basics

A single request unit, 1 RU, is equal to the approximate cost of performing a single GET request on a 1-KB document using a document's ID. Performing a GET by using a document's ID is an efficient means for retrieving a document, and thus the cost is small. Creating, replacing, or deleting the same item requires additional processing by the service, and therefore requires more request units.

The number of request units used for an operation changes depending on the document size, the number of properties in the document, the operation being performed, and some additional complex concepts such as consistency and indexing policy.

If you need to estimate the throughput needs of an application, the Azure Cosmos DB [Capacity Planner](https://www.documentdb.com/capacityplanner) is an online tool that enables you to upload a sample JSON document and set the number of operations you need to complete per second. It then provides an estimated total to reserve.

To manage and plan capacity, Azure Cosmos DB ensures that the number of RUs for a given database operation over a given dataset is deterministic. You can examine the response header to track the number of RUs that are consumed by any database operation. When you understand the factors that affect RU charges and your application's throughput requirements, you can run your application cost effectively.

You provision the number of RUs for your application on a per-second basis in increments of 100 RUs per second. To scale the provisioned throughput for your application, you can increase or decrease the number of RUs at any time. You can scale in increments or decrements of 100 RUs. You can make your changes either programmatically or by using the Azure portal. You are billed on an hourly basis.

## Request Unit considerations

While you estimate the number of RUs per second to provision, consider the following factors:

* **Item size**: As the size of an item increases, the number of RUs consumed to read or write the item also increases.

* **Item indexing**: By default, each item is automatically indexed. Fewer RUs are consumed if you choose not to index some of your items in a container.

* **Item property count**: Assuming the default indexing is on all properties, the number of RUs consumed to write an item increases as the item property count increases.

* **Indexed properties**: An index policy on each container determines which properties are indexed by default. To reduce the RU consumption for write operations, limit the number of indexed properties.

* **Data consistency**: The strong and bounded staleness consistency levels consume approximately two times more RUs while performing read operations when compared to that of other relaxed consistency levels.

* **Query patterns**: The complexity of a query affects how many RUs are consumed for an operation. Factors that affect the cost of query operations include: 
    
    - The number of query results
    - The number of predicates
    - The nature of the predicates
    - The number of user-defined functions
    - The size of the source data
    - The size of the result set
    - Projections

  Azure Cosmos DB guarantees that the same query on the same data always costs the same number of RUs on repeated executions.

* **Script usage**: As with queries, stored procedures and triggers consume RUs based on the complexity of the operations that are performed. As you develop your application, inspect the [request charge header](/azure/cosmos-db/optimize-cost-queries#evaluate-request-unit-charge-for-a-query) to better understand how much RU capacity each operation consumes.

## Exceeding throughput limits

If you don’t reserve enough request units, and you attempt to read or write more data than your provisioned throughput allows, your request will be rate-limited. When a request is rate-limited, the request has to be retried again after a specified interval. If you use the .NET SDK, the request will be retried automatically after waiting the amount of time specified in the retry-after header.

## Creating an account built to scale

You can change the number of request units provisioned to a database at any time. So, during heavy volume periods, you can scale up to accommodate those high demands, and then reduce provisioned throughput during off peak times to reduce costs.

When you create an account, you can provision a minimum of 400 RU/s, or a maximum of 250,000 RU/s in the portal. If you need even more throughput, fill out a ticket in the Azure portal. Setting the initial throughput to 1000 RU/s is recommended for almost all accounts, as it is the minimum value in which your database will autoscale should you need more than 10 GB of storage. If you set the initial throughput to any value less than 1000 RU/s, your database will not be able to scale to larger than 10 GB unless you reprovision the database and provide a partition key. Partition keys enable quick lookup of data in Azure Cosmos DB and enable it to autoscale your database when needed. Partition keys are discussed a bit later in the module.

## Summary

You now understand how to estimate and scope throughput for an Azure Cosmos DB using request units, and can make an appropriate selection when creating a new Azure Cosmos DB collection. Request units can be modified at any time, but setting them to 1000 RU/s when you create an account helps ensure your database is ready to scale later.
