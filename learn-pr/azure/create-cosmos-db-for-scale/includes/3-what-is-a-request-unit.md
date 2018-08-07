Database throughput ensures your customers, and your companies employees and partners, can read and write to your database without delays. Throughput determines the number of reads and writes your database can perform in a single second.

You need to set up your database throughput to support everyday usage, and also be prepared to meet increased demand over mega-shopping days like Black Friday.

To support automatic scaling down the road, you need to know the minimum throughput you can set at database creation to enable auto scaling later. You also need to estimate your throughput needs for regular use and high-demand times so that you can keep your users happy when demand goes through the roof.

Azure Cosmos DB measures throughput using Request Units. Request unit usage is measured per second, so the unit of measure is Request Units per second (RU/s), and it must be set in advance. You can modify your throughput at any time, and push your RU/s value up or down to meet the current demand.

## Request unit basics

A single request unit, 1 RU, is equal to the approximate cost of performing a single GET request on a 1KB document, using a document's ID. Using a document's ID to request it is a very efficient means for retrieving a document, and thus the cost is very small. Creating, replacing, or deleting the same item requires additional processing by the service, and therefore requires more request units.

The number of request units used for an operation changes depending on the document size, the number of properties in the document, the operation being performed, and some settings we’ll learn about later such as the data consistency setting for the database and whether the properties in the document are indexed.

The following table shows the request unit charge for items of three different sizes (1 KB, 4 KB, and 64 KB) and at two different performance levels (500 reads/second + 100 writes/second and 500 reads/second + 500 writes/second). In this example, the data consistency is set to **Session**, and the indexing policy is set to **None**, which are concepts discussed in later modules.

| Item size | Reads/second | Writes/second | Request units
| --- | --- | --- | --- |
| 1 KB | 500 | 100 | (500 * 1) + (100 * 5) = 1,000 RU/s
| 1 KB | 500 | 500 | (500 * 1) + (500 * 5) = 3,000 RU/s
| 4 KB | 500 | 100 | (500 * 1.3) + (100 * 7) = 1,350 RU/s
| 4 KB | 500 | 500 | (500 * 1.3) + (500 * 7) = 4,150 RU/s
| 64 KB | 500 | 100 | (500 * 10) + (100 * 48) = 9,800 RU/s
| 64 KB | 500 | 500 | (500 * 10) + (500 * 48) = 29,000 RU/s
 
As you can see, the larger the item is, and the more reads and writes are required, the more request units you need to reserve. If you need to estimate the throughput needs of an application, the Azure Cosmos DB [Capacity Planner](https://www.documentdb.com/capacityplanner) is an online tool that enables you to upload a sample JSON document, set the number of operations you need to complete per second, and then provides an estimated total to reserve.

## Exceeding throughput limits

If you don’t reserve enough request units, and you attempt to read or write more data than your provisioned throughput allows, your request will be rate-limited, and the request will have to be retried. If you use the .NET SDK, the request will be retried automatically after waiting the amount of time specified in the retry-after header.

## Creating an account built to scale

You can change the number of request units provisioned to a database at any time. So if you have read or write heavy times, you can scale up to accommodate those high-demand times, and then reduce provisioned throughput during off peak times to reduce costs.

When you create an account, you can provision a minimum of 400 RU/s, or a maximum of 250,000 RU/s in the portal. If you need even more throughput, that can be accommodated, it just requires that you fill out a ticket in the Azure portal. Setting the initial throughput to 1000 RU/s is recommended for almost all accounts, as it is the minimum value in which your database will auto scale should you need more than 10GB of storage. If you set the initial throughput to any value less than 1000 RU/s, your database will not be able to scale to larger than 10GB unless you reprovision the database and provide a partition key. Partition keys enable quick look-up of data in Azure Cosmos DB and enable it to auto-scale your database when needed. Partition keys are discussed in the next unit.