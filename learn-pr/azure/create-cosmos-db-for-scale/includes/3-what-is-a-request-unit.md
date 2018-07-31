In this section, you'll learn about the concept of request units, which is how throughput is handled in Azure Cosmos DB. The number of Request units (RUs) you reserve for your database determines the number of reads and writes you can perform in a single second. By the end of this section, you will be able to:

* Calculate how many request units are used when an item of various sizes is created, read, updated or deleted
* Use the Request unit calculator
* Set your request unit value when you create your database so that your database can scale

## Motivation

Request units are reserved in advance and are one of the ways in which the cost of Azure Cosmos DB is calculated (the size of the data stored is the other component) , so you’ll need to estimate how many request units your application requires, so that you can reserve the correct amount.

## Request unit basics

Performing a single GET using a document ID costs approximately 1 RU for a 1 KB item. Creating, replacing or deleting the same item requires more processing by the service, and therefore requires more request units. The number of request units used for an operation changes depending on the document size, the number of properties in the document, the operation being performed, and some settings we’ll learn about later such as the data consistency setting for the database and whether the properties in the document are indexed.
Note that request units are measured per second, thus the nomenclature used is Request Units per second, or RU/s.
Taken from azure-docs-pr/cosmos-db/request-units.md
For example, here's a table that shows how many request units to provision for items with three different sizes (1 KB, 4 KB, and 64 KB) and at two different performance levels (500 reads/second + 100 writes/second and 500 reads/second + 500 writes/second). In this example, the data consistency is set to **Session**, and the indexing policy is set to **None**.

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

If you don’t reserve enough request units, and you attempt to read or write more data than your provisioned throughput allows, your request will be rate-limited, and the request will have to be retried. If you use the .NET SDK, the request will be retried automatically after waiting the amount of time specified in the retry-after header,

## Creating an account built to scale

You can change the number of request units provisioned to a database at any time. So if you have read or write heavy times, you can scale up to accommodate those high-demand times, and then reduce provisioned throughput during off peak times to reduce costs.

When you create an account, you can provision a minimum of 400 RU/s, or a maximum of 250,000 RU/s in the portal. If you need even more throughput, that can be accommodated, it just requires that you fill out a ticket in the Azure portal. Setting the initial throughput to 1000 RU/s is recommended for almost all accounts, as it is the minimum value in which your database will auto scale should you need more than 10GB of storage. If you set the initial throughput to any value less than 1000 RU/s, your database will not be able to scale to larger than 10GB unless you reprovision the database and provide a partition key. Partition keys enable quick look-up of data in Azure Cosmos DB and enable it to auto-scale your database when needed. Partition keys are discussed in the next unit.