Remember that data in an Azure Cosmos DB is stored in containers. Containers are distributed across partitions based on the value of a partition key.

The partition key is a document property. Documents with the same partition key value are always located on the same logical partition. A partition supports a fixed maximum amount of storage and Request Units. When the capacity of a logical partition gets close to the maximum storage, Azure Cosmos DB allocates another physical partition. Azure Cosmos DB seamlessly splits the logical partitions among the physical partitions.

In this unit, you'll learn more about logical partitions and how to avoid hot partitions. This information will help us choose the appropriate partition key for the customer data in our scenario.

## Logical partitions in Azure Cosmos DB

In Azure Cosmos DB, you increase storage and throughput by adding more physical servers (or partitions) to access and store data. The maximum storage size of a physical partition is 50 GB, and the maximum throughput is 10,000 RU/s.

:::image type="content" source="../media/6-physical-partitions.png" alt-text="Diagram that illustrates the physical partitions in Azure Cosmos D B." border="false":::

However, Azure Cosmos DB abstracts this physical layer and introduces the concept of a logical partition. A logical partition provides a uniform way to allow data from multiple partitions to be stored on the same physical server, and be moved around between servers or to new servers, as data grows. The maximum size for a logical partition is 20 GB.

:::image type="content" source="../media/6-logical-partitions.png" alt-text="Diagram that shows examples of logical partitions." border="false":::

A partition key provides a way to route data for a logical partition. It's a property that exists within every document in your container that routes your data. A container is another abstraction and is for all data stored with the same partition key. The partition key is defined when you create a container. 

In the following example, the container has a partition key of `/username`.

:::image type="content" source="../media/6-container-partition-key.png" alt-text="Diagram that shows an example where the partition key is username." border="false":::

## Avoid hot partitions

When you're modeling data for Azure Cosmos DB, it's critically important that the partition key that you choose results in an even distribution of data and requests across partitions in your container. This is especially true when containers grow very large. 

If you don't test the design for a NoSQL database under load during development, a poor choice for partition key might not be revealed until the application is in production, and significant data has been written. When data isn't partitioned correctly, it can result in *hot partitions*. Hot partitions prevent your database from being able to scale, and they can occur on both storage and throughput.

### Storage hot partitions

Containers in Azure Cosmos DB can have an unlimited number of logical partitions. However, each logical partition in Azure Cosmos DB can't grow any larger than 20 GB. The partition key must provide high-enough cardinality to avoid this 20-GB limit.

A hot partition on storage occurs when you have a partition key that results in highly asymmetric storage patterns. As an example, consider a multitenant application that uses `tenantId` as its partition key with three tenants: A, B, and C. Tenants A and B are very small. Tenant C is massive and quickly hits the 20-GB limit for its partition. In this scenario, we need a different partition key that will spread the storage across more logical partitions.

:::image type="content" source="../media/6-hot-partition-storage.png" alt-text="Diagram that shows a hot partition with a highly asymmetric storage pattern." border="false":::

### Throughput hot partitions

Throughput can suffer from hot partitions when most or all of the requests go to the same logical partition.

It's important to understand the access patterns for your application to ensure that requests are spread as evenly as possible across partition key values. When throughput is provisioned in Azure Cosmos DB, it's allocated evenly across all the physical (and thus logical) partitions within a container.

As an example, if you have a container with 30,000 RU/s, this workload is spread across the three physical partitions for the same three tenants mentioned earlier. So each tenant gets 10,000 RU/s. If tenant C consumes all of its 10,000 RU/s, it will be rate limited because it can't consume the throughput allocated to the other partitions. This design results in poor performance for tenant C and unused compute capacity for the other tenants. Ultimately, this partition key results in a database design that can't scale.

:::image type="content" source="../media/6-hot-partition-throughput.png" alt-text="Diagram that shows a throughput hot partition." border="false":::

When data and requests are spread evenly, the database can grow in a way that fully utilizes both the storage and throughput. The result will be the best possible performance and highest efficiency. In short, the database design will scale.

:::image type="content" source="../media/6-partitions-even.png" alt-text="Diagram that shows the data and requests spread evenly across partitions." border="false":::

## Consider reads versus writes

When you're choosing a partition key, you also need to consider whether the data is read heavy or write heavy. You should seek to distribute write-heavy data with a partition key that has high cardinality. For read-heavy workloads, ensure that queries are answered with one or a bounded number of partitions. In scenarios where the data is both write heavy and read heavy, there's a solution. We'll explore that in the next module.

In a read-heavy workload, the way to ensure that you read data from a single partition is to use the partition key property in an equality filter on the `WHERE` clause for your queries. The following illustration shows a container that's partitioned by username. This query will hit only a single logical partition, so its performance will always be good.

:::image type="content" source="../media/6-in-partition-query.png" alt-text="Diagram that shows a partition query for username." border="false":::

A query that filters on a different property, such as `favoriteColor`, would "fan out" to all partitions in the container. This is also known as a *cross-partition query*. Such a query will work fine when the container is small and occupies only a single partition. However, as the container grows larger with more physical partitions, this query will become slower and more expensive because it will need to check more partitions to get the results.

:::image type="content" source="../media/6-cross-partition-query.png" alt-text="Diagram that shows a cross-partition query for favorite color." border="false":::

## Choose a partition key for customers

Now that you understand partitioning in Azure Cosmos DB, we can decide on a partition key for our customer data. As we covered earlier, we perform three operations on customers: create a customer, update a customer, and retrieve a customer. In this case, we'll retrieve the customer by their *ID*. Because that operation will be called the most, it makes sense to make the customer's ID the partition key for the container.

:::image type="content" source="../media/6-customer-partition-key.png" alt-text="Diagram that shows the customer partition key as I D." border="false":::

You might worry here that making the ID the partition key means that we'll have as many logical partitions as there are customers, with each logical partition containing only a single document. Millions of customers would result in millions of logical partitions.

But this is perfectly fine! Logical partitions are a virtual concept, and there's no limit to how many logical partitions you can have. Azure Cosmos DB will colocate multiple logical partitions on the same physical partition. As logical partitions grow in size, Cosmos DB will move them to different physical partitions when needed.

:::image type="content" source="../media/6-single-document-per-partition.png" alt-text="Diagram that shows a single document per partition for the partition key I D." border="false":::
