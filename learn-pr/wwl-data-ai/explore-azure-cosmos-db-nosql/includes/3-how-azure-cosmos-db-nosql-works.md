Knowing the resource model tells you how Azure Cosmos DB for NoSQL organizes data. To evaluate whether it fits the Contoso application, you also need to understand how it delivers performance and reach. In this unit, you build a mental model of three ideas that the rest of the course relies on: request units, partitioning, and global distribution.

## Request units: the currency of throughput

Every operation in Azure Cosmos DB for NoSQL (a read, a write, a query) consumes resources such as CPU, memory, and I/O. Instead of asking you to reason about each of these resources separately, the service expresses the cost of an operation in a single normalized unit called a **request unit (RU)**.

The baseline is a *point read*, which is a lookup of a single item by its ID and partition key value. Read a 1-KB item that way, and it costs '1' RU. Every other operation is priced relative to that. Reading a larger item costs more, writing an item costs more than reading the same item, and a query that scans many items can cost far more than either. You provision throughput as **request units per second (RU/s)**, which sets how much work the service performs for you each second.

This model has two practical consequences:

- **Predictability**: Because every operation has a known RU cost, you can estimate capacity from your expected mix of reads, writes, and queries.
- **Elasticity**: You raise or lower RU/s as demand changes, so you pay for the throughput a workload needs rather than for peak capacity always.

> [!NOTE]
> This unit introduces RU/s as a concept. You learn how to provision and tune throughput, including autoscale and serverless options, in a later module.

## Partitioning: logical organization and physical scale

Azure Cosmos DB for NoSQL scales horizontally by separating how your application organizes data from how the service stores and serves that data.

A *logical partition* contains all items that share one partition key value. When you create a container, you select a partition key path, a property in each item that determines its logical group. For example, if an orders container uses /customerId, all orders for one customer belong to the same *logical partition*. Your application works with this logical model by supplying the partition key value when it reads or writes data.

A *physical partition* is a service-managed unit of compute and storage. A *physical partition* can provide up to 10,000 RU/s and store up to 50 GB of data. One *physical partition* can host many *logical partitions*, but all items in a single *logical partition* are stored together on one *physical partition*. You don't create, provision, or manage *physical partitions* directly.

Think of *logical partitions* as labeled folders and *physical partitions* as filing cabinets. Your application determines which folder an item belongs in. Azure Cosmos DB decides which cabinet holds each folder. As the workload grows, the service can add cabinets and redistribute folders without changing the labels your application uses.

To map *logical partitions* to *physical partitions*, Azure Cosmos DB hashes partition key values. As storage or throughput requirements increase, the service automatically splits *physical partitions* and remaps *logical partitions* across them. This process is transparent to your application.

:::image type="content" source="../media/logical-physical-partitions.png" alt-text="Diagram showing items grouped into logical partitions by partition key value, mapped onto physical partitions." lightbox="../media/logical-physical-partitions.png":::

The partition key determines how evenly data and requests are distributed. A partition key that spreads storage and request volume across many values allows the container to scale efficiently. A key that concentrates activity on a few values can create hot partitions and limit usable throughput.

The partition key also affects query cost. A query scoped to one partition key value reaches a single *logical partition*. A query that doesn't specify a partition key value might need to contact every *physical partition*. Indexes reduce the work performed within each partition, but they don't eliminate the cost of coordinating a cross-partition query.

A good partition key has many distinct values, distributes storage and requests evenly, and aligns with common query patterns. You explore partition key design in depth in a later module.

> [!NOTE]
> Each logical partition holds up to 20 GB of data. A good partition key keeps any single key value from growing near that limit. Some workloads need more than 20 GB for a single key value, for example a large tenant in a multitenant system. Azure Cosmos DB handles this workload with hierarchical partition keys (subpartitioning), using up to three levels of keys to spread data further. You explore both limits and hierarchical partition keys when you design data models in a later module.

## Global distribution: putting data close to users

An Azure Cosmos DB account that uses provisioned throughput can replicate its data across any number of Azure regions. Adding a region continuously replicates a full copy of the data close to users in that region, which reduces read latency. It also increases availability should another region become unavailable.

:::image type="content" source="../media/global-distribution.png" alt-text="Diagram showing an Azure Cosmos DB account replicated across global regions." lightbox="../media/global-distribution.png":::

Global distribution supports different configurations. An account configured with *single-region writes* can serve reads from many regions while accepting writes in one region. An account configured with *multi-region writes* can accept writes to any added region. The service keeps replicas synchronized based upon the *consistency model* configured for that account. This provides flexibility that balances how up-to-date reads against latency and availability.

For the Contoso application, which serves users across several regions, this capability means one account can back the entire application while keeping data near each user.

Together, request units, partitioning, and global distribution form the model you use to reason about Azure Cosmos DB for NoSQL. With that model in place, you can now evaluate whether the service fits a specific workload.
