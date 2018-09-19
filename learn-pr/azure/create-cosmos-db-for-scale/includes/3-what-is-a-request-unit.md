Next, let's consider the data for your database. Adequate throughput is important to ensure you can handle the volume of transactions for your business needs. Throughput requirements aren't always consistent. For example, you may be building a shopping website that needs to scale during sales or holidays. We'll start by learning about request units and how to estimate throughput requirements.

## What is database throughput? 

Database throughput is the number of reads and writes that your database can perform in a single second.

To scale throughput strategically, you need to estimate your throughput needs by estimating the number of reads and writes you'll have to support at different times and for different document sizes. If you estimate correctly, you'll keep your users happy when demand spikes. If you estimate incorrectly, your requests can get rate-limited and operations will have to wait and retry, likely causing high latency and unhappy customers.

## What is a request unit?

Azure Cosmos DB measures throughput using something called a **request unit (RU)**. Request unit usage is measured per second, so the unit of measure is **request units per second (RU/s)**. You must reserve the number of RU/s you want Azure Cosmos DB to provision in advance, so it can handle the load you've estimated, and you can scale your RU/s up or down at any time to meet current demand.

## Request unit basics

A single request unit, 1 RU, is equal to the approximate cost of performing a single GET request on a 1-KB document using a document's ID. Performing a GET by using a document's ID is an efficient means for retrieving a document, and thus the cost is small. Creating, replacing, or deleting the same item requires additional processing by the service, and therefore requires more request units.

The number of request units used for an operation changes depending on the document size, the number of properties in the document, the operation being performed, and some additional complex concepts such as consistency and indexing policy.

The following table shows the number of request units required for items of three different sizes (1 KB, 4 KB, and 64 KB) and at two different performance levels (500 reads/second + 100 writes/second and 500 reads/second + 500 writes/second). In this example, the data consistency is set to **Session**, and the indexing policy is set to **None**.

| Item size | Reads/second | Writes/second | Request units
| --- | --- | --- | --- |
| 1 KB | 500 | 100 | (500 * 1) + (100 * 5) = 1,000 RU/s
| 1 KB | 500 | 500 | (500 * 1) + (500 * 5) = 3,000 RU/s
| 4 KB | 500 | 100 | (500 * 1.3) + (100 * 7) = 1,350 RU/s
| 4 KB | 500 | 500 | (500 * 1.3) + (500 * 7) = 4,150 RU/s
| 64 KB | 500 | 100 | (500 * 10) + (100 * 48) = 9,800 RU/s
| 64 KB | 500 | 500 | (500 * 10) + (500 * 48) = 29,000 RU/s
 
As you can see, the larger the item is, and the more reads and writes are required, the more request units you need to reserve. If you need to estimate the throughput needs of an application, the Azure Cosmos DB [Capacity Planner](https://www.documentdb.com/capacityplanner) is an online tool that enables you to upload a sample JSON document and set the number of operations you need to complete per second. It then provides an estimated total to reserve.

## Exceeding throughput limits

If you don’t reserve enough request units, and you attempt to read or write more data than your provisioned throughput allows, your request will be rate-limited. When a request is rate-limited, the request has to be retried again after a specified interval. If you use the .NET SDK, the request will be retried automatically after waiting the amount of time specified in the retry-after header.

## Creating an account built to scale

You can change the number of request units provisioned to a database at any time. So, during heavy volume periods, you can scale up to accommodate those high demands, and then reduce provisioned throughput during off peak times to reduce costs.

When you create an account, you can provision a minimum of 400 RU/s, or a maximum of 250,000 RU/s in the portal. If you need even more throughput, fill out a ticket in the Azure portal. Setting the initial throughput to 1000 RU/s is recommended for almost all accounts, as it is the minimum value in which your database will autoscale should you need more than 10 GB of storage. If you set the initial throughput to any value less than 1000 RU/s, your database will not be able to scale to larger than 10 GB unless you reprovision the database and provide a partition key. Partition keys enable quick lookup of data in Azure Cosmos DB and enable it to autoscale your database when needed. Partition keys are discussed a bit later in the module.

## Summary

You now understand how to estimate and scope throughput for an Azure Cosmos DB using request units, and can make an appropriate selection when creating a new Azure Cosmos DB collection. Request units can be modified at any time, but setting them to 1000 RU/s when you create an account helps ensure your database is ready to scale later.