The online retailer that you work for plans to expand to a new geographical area soon. This move will increase your customer base and transaction volume. Your database should be equipped to handle expansion whenever required.

A partition strategy ensures that your database can grow to efficiently run queries and transactions.

## What is a partition strategy?

If you continue to add new data to a single server or a single partition, it will eventually run out of space. A partitioning strategy enables you to add more partitions to your database when you need them. This scaling strategy is called **scale out** or **horizontal scaling**.

A partition key defines the partition strategy, it's set when you create a container and can't be changed. Selecting the right partition key is an important decision to make early in your development process.  

In this unit, you'll learn how to choose a partition key that's right for your scenario, which will enable you to take advantage of Azure Cosmos DB autoscaling.

## What is a partition key?

A partition key is the value by which Azure organizes your data into logical divisions. It should aim to evenly distribute operations across the database to avoid hot partitions. A hot partition is a single partition that receives many more requests than the others, which can create a throughput bottleneck. 

In our online retail scenario, using the `userID` or `productId` value as the partition key is a good choice because it will be unique and likely used to look up records. `userID` is a good choice, as your application frequently needs to retrieve the personalization settings, shopping cart, order history, and profile information for the user, just to name a few. `productId` is also a good choice, as your application needs to query inventory levels, shipping costs, color options, warehouse locations, and more.

Using the current time would be a poor choice of partition key, because all the incoming data would go to a single partition key. `userID` or `productId` would be better, as all the users on your site would likely be adding and updating their shopping cart or profile information at about the same frequency, which distributes the reads and writes across all the user and product partitions.

The amount of required RU's and storage determines the number of required physical partitions for the container, which are managed by Azure Cosmos DB. When more physical partitions are needed, Cosmos DB automatically creates them by splitting existing ones. There's no downtime or performance impact for the application.

The storage space for the data associated with each partition key can't exceed 20 GB, which is the size of one physical partition in Azure Cosmos DB. So, if your single `userID` or `productId` record is going to be larger than 20 GB, think about using a composite key instead so that each record is smaller. An example of a composite key would be `userID-date`, which would look like **CustomerName-08072018**. This composite key approach would enable you to create a new partition for each day a user visited the site.

## Best practices

When you're trying to determine the right partition key and the solution isn't obvious, here are a few tips to keep in mind.

- Don't be afraid of choosing a partition key that has a large number of values. The more values your partition key has, the more scalability you have.
- To determine the best partition key for a read-heavy workload, review the top three to five queries you plan on using. The value most frequently included in the WHERE clause is a good candidate for the partition key.
- For write-heavy workloads, you'll need to understand the transactional needs of your workload, because the partition key is the scope of multi-document transactions.

## Review: Choosing a Partition Key

For each Azure Cosmos DB container, you should specify a partition key that satisfies the following core properties:

- Have a high cardinality. This option allows data to distribute evenly across all physical partitions.
- Evenly distribute requests. Remember the total number of RU/s is evenly divided across all physical partitions.
- Evenly distribute storage. Each partition can grow up to 20 GB in size.

In the next two exercises, you'll create a database and container. In the first exercise, you'll use the Azure portal to create your database and container. However, if you would prefer to learn how to create a database and container programmatically, you can skip ahead to the next exercise.
