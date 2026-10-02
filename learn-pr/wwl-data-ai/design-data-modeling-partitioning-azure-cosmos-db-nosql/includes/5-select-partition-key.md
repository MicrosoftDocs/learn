Three containers now hold the Contoso data, and each one needs a partition key. That key is the decision the module builds toward, and it's the one with the least room for error: the partition key is set when the container is created and can't be changed in place. In this unit, you evaluate candidate keys against the criteria that determine whether a container scales, and apply them to the Contoso model.

## What the partition key controls

A partition key has two parts. The **path** is declared on the container, such as `/categoryId`. The **value** is whatever each item carries at that path.

Azure Cosmos DB hashes the value to place the item. All items sharing a value form a **logical partition**, and a logical partition is the boundary for two concerns: transactional guarantees, and scale limits.

- A logical partition holds up to 20 gigabytes (GB) of data and can serve up to 10,000 request units per second (RU/s). A container can have any number of logical partitions, but no single one exceeds those ceilings.
- **Physical partitions** hold the logical partitions. Each stores up to 50 GB and serves up to 10,000 RU/s, and the service splits them automatically as data or throughput grows. Provisioned throughput divides evenly across them.

:::image type="content" source="../media/logical-physical-partition-limits.png" alt-text="Diagram showing logical partitions limited to 20 GB and 10,000 RU/s, mapped onto physical partitions limited to 50 GB and 10,000 RU/s." lightbox="../media/logical-physical-partition-limits.png":::

The second point is the one that turns a modeling mistake into a production incident. If a container is provisioned for 30,000 RU/s across three physical partitions, each partition gets 10,000 RU/s. A workload that sends most of its traffic to one of them is rate limited at a third of the throughput it's paying for, while the other two sit idle.

## Keep the modeling and storage boundaries distinct

Aggregate, item, logical-partition, and container boundaries answer different design questions:

| Boundary | What it defines |
|:---------|:----------------|
| Aggregate | Business ownership, lifecycle, and consistency rules. |
| Item | One JSON document and the scope of a single-item atomic operation. |
| Logical partition | Items sharing a complete partition-key value; the routing, scale, and multi-item transaction boundary. |
| Container | The partition-key definition and operational configuration, including throughput, indexing, time to live, and change feed. |

These boundaries can align, but they don’t have to. One aggregate commonly maps to one item, while separate aggregate types can share a container or logical partition.

In the Contoso model, Customer and SalesOrder are separate aggregate roots and separate items. They share a container and /customerId logical partition because customer-scoped queries need efficient routing and order creation can require a transactional update to the Customer projection.

## The criteria a good key meets

Evaluate every candidate against all six criteria. Few partition keys optimize every dimension equally, so choose based on the workload’s highest-frequency operations and known growth requirements. A compromise in cardinality or distribution can be acceptable for a container whose data volume and traffic are deliberately bounded, but the exception should be explicit and monitored.

**High cardinality.** The property should have a wide range of possible values. Cardinality sets the upper bound on how far the container can spread.

**Even distribution of storage.** No single value should accumulate disproportionate data. The 20-GB ceiling applies per value, and writes for a value that reaches it stop.

**Even distribution of requests.** Traffic should spread across values roughly as evenly as storage does. High cardinality doesn't guarantee even distribution: a key with a million values is still a hot partition if 90 percent of requests target one of them.

**Presence in your hottest filters.** A query that includes the partition key value in an equality filter routes to one logical partition. A query that omits it fans out to every physical partition in the container, paying an overhead of two to three request units per partition on top of the query's own cost. On a small container, that's noise. On a container past roughly 30,000 RU/s or 100 GB, it's the difference between a viable query and an unaffordable one.

**Immutability.** Partition key values can't be updated in place. Changing one means creating a new item with the new value and deleting the original, and those two operations aren't atomic across logical partitions.

**Workable type and size.** Partition key values are strings or numbers, and a number too large for double-precision floating point to represent exactly has to be stored as a string to survive the round trip. Values are capped at 2,048 bytes, or 101 bytes on a container that doesn't have large partition keys enabled.

### Read-heavy and write-heavy pull in different directions

For write-heavy workloads, spreading matters most. The highest-cardinality property available distributes inserts across the widest set of logical partitions, which is why the item identifier is often the right choice.

For read-heavy workloads, routing matters most. The property that appears as an equality filter in the dominant query keeps that query on one partition, even if a different property would spread the data more evenly.

Most workloads are both, and the resolution is frequency. Optimize for the operation that runs most often, then check that the operation you didn't optimize for stays acceptable.

### Apply the criteria to Contoso

**The `product` container gets `/categoryId`.** Category browsing is the highest-frequency read in the inventory and filters on exactly this property, so it becomes a single-partition query. Cardinality is a few hundred categories with no single one large enough to approach 20 GB. The product identifier would spread writes better, but writes to a catalog are rare and every category page would fan out.

The customer container gets /customerId. Customer-specific operations filter by customer and route to one logical partition. Ranking all customers by order count remains a cross-partition query. Cardinality equals the number of customers, and the value doesn’t change.

Customer and SalesOrder remain separate aggregate roots and separate items. Giving both item types the same customerId value colocates a customer and its orders in one logical partition. This placement supports efficient customer-scoped queries and allows an order insert and Customer counter update to run in one transactional batch.

**The `productMeta` container gets `/type`.** This choice deliberately violates the cardinality criterion: the property has two values. This design works because the container stores only a few hundred small reference items. It remains well below the container limits. The main operation lists all items of one type. A low-cardinality partition key lets this operation use a single-partition query. Cardinality matters in proportion to size, and a container that stays small can trade it away.

## The item identifier as a partition key

Using `/id` deserves its own consideration, because it's both the best and the worst choice depending on the workload.

It gives one partition key value per item and generally distributes writes well. It doesn't guarantee equal storage or traffic across partitions: item sizes and access frequencies can differ. It also supports efficient point reads, since knowing the identifier means to know the partition. It's a natural key for write-heavy containers and for containers the application only ever reads by identifier.

The cost is that every query filtering on anything else fans out. It also makes the identifier unique across the whole container rather than per partition, so an application that reuses identifiers across logical partitions can't use it.

## Changing a key later means to move the data

There's no in-place change. Moving to a different partition key means to create a new container with the key you want and copying the data into it. A container copy job does that work in either of two modes. In offline mode, you pause the application for the duration. In online mode, the job also replicates the writes still arriving during the copy. Online mode requires continuous backup on the account. The Azure portal wraps the whole process in a guided workflow: open the container in Data Explorer, go to **Scale & Settings**, select the **Partition Keys** tab, and choose **Change**. Whichever route you take, the application is updated to point at the new container once the copy is verified.

> [!NOTE]
> Container copy jobs are currently in preview.

The change is manageable, but it requires a project rather than a configuration update. Complete the review in the final unit of this module before you create the container.

> **Synthesis prompt:** Contoso adds a customer service tool that looks up orders by order number, with no customer context. Against the `/customerId` key, that lookup fans out across every partition. Decide how you'd handle it, and defend the choice: change the container's partition key, keep the fan-out and accept the cost, or store a second copy of the data keyed differently. Consider how often the tool runs compared to the storefront operations, what a second copy costs to keep synchronized, and what you learned about the cost of fan-out on a large container.
