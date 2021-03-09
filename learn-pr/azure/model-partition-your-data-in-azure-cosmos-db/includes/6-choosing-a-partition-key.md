Azure Cosmos DB is a horizontally scalable database. Storage and throughput are increased by adding more physical servers (or partitions) to access and store data. The maximum storage size of a physical partition is 50 GB and the maximum throughput is 10,000 RU/s.

    :::image type="content" source="../media/physical-partitions.png" alt-text="physical partitions in Cosmos DB":::

However, Cosmos DB abstracts this physical layer and introduces the concept of a logical partition that provides a uniform way to allow data from multiple partitions to be stored on the same physical server, as well as be moved around between servers or to new servers, as data grows. The maximum size for a logical partition is 20 GB.

    :::image type="content" source="../media/logical-partitions.png" alt-text="logical partitions":::

A partition key provides a way to route data for a logical partition and is a property that exists within every document in your container that routes your data. A container is another abstraction and for all data stored with the same partition key. The partition key is defined when you create a container. In this example below the container has a partition key of `/username` so properties with the same value are stored in the same logical partition.

    :::image type="content" source="../media/container-partition-key.png" alt-text="create new container with partition key":::

## Avoiding hot partitions

When modeling data for Azure Cosmos DB it is critically important the partition key chosen results in an even distribution of data and requests across partitions in your container. This is especially true when containers grow very large. If the design for a NoSQL database is not tested under load during development, a poor choice for partition key may not be revealed until the application is in production and significant data has been written. When data is not partitioned correctly, it can result in what is called "hot partitions" and can occur on both storage as well as throughput, preventing your database from being able to scale.

## Storage

Containers in Azure Cosmos DB can have an unlimited number of logical partitions. However, each logical partition in Azure Cosmos DB cannot grow any larger than 20 GB. So it is important that the partition key provides high enough cardinality to avoid this 20 GB limit.

A hot partition on storage occurs when you have a partition key that results in highly asymmetric storage patterns. As an example, consider a multi-tenant application that uses tenantId as it's partition key with three tenants, A, B and B. Tenants A and B are very small. Tenant C is massive and quickly hits the 20 GB limit for it's partition. In this scenario we need a different partition key that will spread the storage across more logical partitions.

    :::image type="content" source="../media/hot-partition-storage.png" alt-text="storage hot partition":::

## Throughput

Throughput also can suffer from hot partitions. This occurs when most or all of the requests go to the same logical partition.

Here as well it is important to understand the access patterns for your application to ensure that requests are spread as evenly as possible across partition key values. When throughput is provisioned in Azure Cosmos DB, it is allocated evenly across all the physical (and thus logical) partitions within a container.

As an example, if you have a container with 30K RU/s, this would be spread across the 3 physical partitions for the same three tenants above. So each tenant gets 10K RU/s. If tenant C consumes all of it’s 10K RU/s it will be rate limited as it cannot consume the throughput allocated to the other partitions. This results in poor performance for tenant C and unused compute capacity for the other tenants. Ultimately, this partition key results in a database design that cannot scale.

    :::image type="content" source="../media/hot-partition-throughput.png" alt-text="throughput hot partition":::

When data and requests are spread evenly, this ensures that as the database grows, it will do so in a way that best utilizes both the storage and throughput fully. This will result in the best possible performance and highest efficiency. In short, the database design will scale.

    :::image type="content" source="../media/partitions-even.png" alt-text="partitions even":::

## Considerations for reads versus writes

There is one additional consideration that needs to be understood when choosing a partition key and that is whether the data is read heavy versus write heavy. For a write heavy data, you should seek to distribute data with a partition key that has high cardinality. For read-heavy workloads you want to ensure queries are answered with one or a bounded number of partitions. In scenarios where the data is both write and read heavy there is a solution. We will explore this in the next module.

In a read heavy workload, the way to ensure you read data from a single partition is to use the partition key property in an equality filter on the WHERE clause for your queries. In this illustration below we have a container that is partitioned by username. With a query like the one below, we are assured this query will only hit a single logical partition so it's performance will always be good.

    :::image type="content" source="../media/in-partition-query.png" alt-text="in partition query":::

However a query that filtered on a different property, such as favoriteColor would "fan out" to all partitions in the container. This is also known as a cross-partition query. Such a query will work fine when the container is small and only occupies a single partition. However, as the container grows larger with more and more physical partitions, this query will become slower and more expensive because it will need to check more and more partitions to get the results.

    :::image type="content" source="../media/cross-partition-query,png.png" alt-text="cross partition query":::

## Choosing partition key for customers

Now that we have all this new knowledge about partitioning in Azure Cosmos DB we can now decide on a partition key for our customer data. As we covered earlier there are three operations we perform on customers: create a customer, update a customer, and retrieve a customer. In this case we will retrieve the customer by it's *id* and since that operation will be called the most, it makes sense to make the customer's id the partition key for the container.

    :::image type="content" source="../media/customer-partition-key.png" alt-text="customer partition key":::

You may worry here that making the id the partition key means that we will have as many logical partitions as there are customers with each logical partition containing only a single document. Millions of customers, would result in millions of logical partitions.

But this is perfectly fine! Logical partitions are a virtual concept and there is no upper limit to have many logical partitions you can have. Azure Cosmos DB will co-locate multiple logical partitions on the same physical partition. As logical partitions grow in size, Cosmos DB will move them to different physical partitions when needed.

    :::image type="content" source="../media/single-document-per-partition.png" alt-text="single document per partition":::