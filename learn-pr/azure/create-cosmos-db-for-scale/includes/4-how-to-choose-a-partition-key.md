The online retailer that you work for plans to expand to a new geographical area soon. This move will increase your customer base and transaction volume. You must ensure that your database is equipped to handle expansion whenever required.

Having a partition strategy ensures that when your database needs to grow, it can do so easily and continue to perform efficient queries and transactions.

## What is a partition strategy?

If you continue to add new data to a single server or a single partition, it will eventually run out of space. To prepare for this, you need a partitioning strategy to **scale out** instead of up. Scaling out is also called horizontal scaling, and it enables you to add more partitions to your database as your application needs them.

The partition and scale-out strategy in Azure Cosmos DB is driven by the partition key, which is a value set when you create a collection. Once the partition key is set, it cannot be changed without recreating the collection, so selecting the right partition key is an important decision to make early in your development process.  

In this unit, you will learn how to choose a partition key that's right for your scenario and will take advantage of the autoscaling that Azure Cosmos DB can do for you.

## What is a partition key?

A partition key is the value by which Azure organizes your data into logical divisions. In our online retail scenario, using the `userID` or `productId` value as the partition key is a good choice because it will be unique and likely used to lookup records. `userID` is a good choice, as your application frequently needs to retrieve the personalization settings, shopping cart, order history, and profile information for the user, just to name a few. `productId` is also a good choice, as your application needs to query inventory levels, shipping costs, color options, warehouse locations, and more.

A partition key should aim to distribute operations across the database. You want to distribute requests to avoid hot partitions. A hot partition is a single partition that receives many more requests than the others, which can create a throughput bottleneck. For example, for your e-commerce application, the current time would be a poor choice of partition key, because all the incoming data would go to a single partition key. `userID` or `productId` would be better, as all the users on your site would likely be adding and updating their shopping cart or profile information at about the same frequency, which distributes the reads and writes across all the user and product partitions.

The storage space for the data associated with each partition key cannot exceed 10 GB, which is the size of one physical partition in Azure Cosmos DB. So, if your single `userID` or `productId` record is going to be larger than 10 GB, think about using a composite key instead so that each record is smaller. An example of a composite key would be `userID-date`, which would look like **CustomerName-08072018**. This composite key approach would enable you to create a new partition for each day a user visited the site.

## Best practices

When you're trying to determine the right partition key and the solution isn't obvious, here are a few tips to keep in mind.

- Don’t be afraid of choosing a partition key that has a large number of values. The more values your partition key has, the more scalability you have.
- To determine the best partition key for a read-heavy workload, review the top three to five queries you plan on using. The value most frequently included in the WHERE clause is a good candidate for the partition key.
- For write-heavy workloads, you'll need to understand the transactional needs of your workload, because the partition key is the scope of multi-document transactions.
