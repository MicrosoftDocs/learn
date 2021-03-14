Remember that data in an Azure Cosmos DB is stored in _collections_. Collections are distributed across _partitions_ based on the value of a collection's _partition key_.

The partition key is a _document_ property. Documents with the same partition key value are always located on the same logical partition. A partition supports a fixed maximum amount of storage and Request Units (RUs). When the capacity of a logical partition gets close to the maximum storage, Azure Cosmos DB allocates another physical partition. Azure Cosmos DB seamlessly splits the logical partitions, the groups of documents with the same partition key value, among the physical partitions.

## Avoid hot partitions

The Azure Cosmos DB throughput you've configured is divided evenly among partitions. A partition key design that doesn't evenly distribute throughput requests can create _hot_ partitions. A hot partition is accessed more than the other partitions. The result is an inefficient use of the total configured throughput. If the demand on the hot partition is high enough, the partition becomes overloaded, and traffic to the database is rate-limited.

A good partition design avoids hot partitions.

## Partition design considerations

Designing a partitioning strategy requires you to understand your data and its operational workloads. As you consider your design, we recommend that you consider the following requirements.

### Estimate the scale of your data needs

Consider these requirements:

- What's the approximate size of your documents, or range of sizes?
- What's the required throughput in number of reads per second and writes per second?
- What's the volume of documents being queried?

### Understand the workload

Consider these requirements:

- Do you have a read-heavy or write-heavy workload, or both?
- If it's read-heavy, what are the top five queries?
- If it's write-heavy, do you need transactions?

### Propose some partition key options

Consider these options:

- Does the key choice have a large number of possible values or large cardinality?
- Do the values have a consistent spread across the data?
- Are some values accessed more than others?
- For read-heavy workloads, can the query be within a single partition?
- For write-heavy transactional workloads, can the transaction be within a single partition?

## Scenario: Identify a partition strategy

The Orders collection has many properties that you can use as the partition key. The following example shows a typical order document that's 1 KB of data. This size allows you to do RU estimates easily.

[!code-json[](../code/Order2.json)]

### Understand the workload for the collection

Imagine that the collection is used to store a record of orders. When an order is placed for a specific item, the inventory system checks the latest orders to get an accurate value for that item's inventory.

At peak times, like during holiday sales, you anticipate more than 100 million orders to be placed over a 24-hour period.

When each order document is added to the collection, the collection is queried for other orders for the same item. Because there can be multiple orders for each item, more documents are read than written.

More frequent, less expensive reads balance the less frequent, more expensive writes. So the Orders collection has close to a balanced read/write-intensive workload.

### Propose partition key values for the collection

By using the information from the previous sections, let's propose some different values for the partition key, and examine whether they meet your design criteria:

- `OrderTime` as a partition key:

    - If you include time with a resolution of seconds, then `OrderTime` has a large cardinality.
    - Assuming that orders are placed at a consistent pace, the values of `OrderTime` are evenly distributed across the collection storage.
    - Orders aren't evenly distributed across time, though. Many orders are being placed simultaneously.
    - Also, the inventory query likely crosses partitions, which means that the demand of the most common query isn't minimized.

    `OrderTime` is *not* a good choice for the partition key.

- `Item/Category` as a partition key:

    - The Orders database has these categories:

        [!code-csharp[](../code/OrderItem.cs?range=19-28)]

        If you use the `Item/Category` property as a partition key, it has a small cardinality. Even if the documents are evenly distributed across the collection, for large collections, any category might outgrow a single partition.

    - If the categories aren't evenly distributed across the documents in the collection, the problem is even worse. The dominant category restricts the ability of Azure Cosmos DB to scale.

    `Item/Category` is *not* a good choice for the partition key.

- `Item/id` as a partition key:

    - Each item has a unique identifier. You expect the items ordered to be evenly distributed across orders.
    - There are many different items, so the cardinality is large.
    - When you query the orders, all orders of the same item are in the same partition.

    `Item/id` *is* a workable solution for this scenario.

In the next unit, you'll monitor the collections to see how you'd confirm this design choice.
