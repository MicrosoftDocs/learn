Having a partitioning strategy ensures that when your database needs to grow, it can do so and retain efficient queries and transactions. 

Your companies product data grows every day, as does it's user base, but you can't keep adding data to a single server, or single partition, as it will eventually run out of space. To prepare for this, you need a partitioning strategy that takes your most frequent reads, writes, and queries into account.

The partitioning strategy and scale out strategy in Azure Cosmos DB is driven by the partition key, which is a value set when you create a collection. Once the partition key is set, it cannot be changed without recreating the collection, so selecting the right partition key is an important decision to make early in your development process.  

A partition key should represent a value in your database that's frequently queried, and is also an indicator of how your throughput and storage scale. Given your work at an online retailer, queries are frequently either based on a UserID, such as a user querying their shopping cart, quering their orders, and querying their previously viewed items, or based on a ProductID, for checking invetory levels, checking color options, and checking sizing.

In this article, you will learn how to choose a parition key that's right for your scenario, and will take advantage of the autoscaling that Cosmos DB can do for you.

## Partition key basics

A partition key should distribute the overall request + storage volume to avoid hot partitions, so you don't want to send every thing to the same partition key. For example, for your online retailer, the current time would be a poor choice of partition key because all the incoming data would go to a single partition key. UserID or ProductID would be better as all the users on your site would likely be adding and updating their shopping cart or profile information at a about the same frequency, which fans out the reads and writes across all the partitions. Likewise, updates to product data would also likely be fairly evenly fanned out over all the ProductIDs, making them a good bet.

Each partition key has a maximum storage space of 10 GB. So if your single UserID or ProductID record is going to be larger than 10GB, think about using a composite key instead. An example of a composite key would be UserID-date, which would look like RomanPolansky-08072018. That would enable you to create a new partition for each day a user visited the site. 

For read heavy workloads:

* Queries can be intelligently routed via partition key
* Look at your top 3-5 queries and the WHERE clause
* That WHERE clause is a good partition key candidate
* If you omit the partition key from a query, the query will fan-out

For write heavy workloads:

* Understand transactional needs and of your workload because the partition key is the scope of multi-document transactions 

## Best practices

Don’t be afraid of having too many partition keys:

The more partition keys you have, the more scalability you have.

One partition key can be scaled across one physical partition.

Billions of partition key possibilities can start with just one physical partition and grow from there.
