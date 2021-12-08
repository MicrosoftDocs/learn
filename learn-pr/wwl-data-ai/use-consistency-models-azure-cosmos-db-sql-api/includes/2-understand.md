In a distributed database system, tradeoffs are often made between highly consistent data with extended latency and speedy data operations that may not be consistent immediately.

Azure Cosmos DB offers a sliding scale of consistency with many options between the traditional strong and weak options provided by other data storage solutions.

![Sliding scale of consistency with five options](../media/2-sliding-scale.png)

Each of the five consistency levels is well-defined with clear tradeoffs when compared with each other:

| **Consistency Level** | **Description** |
| ---: | --- |
| **Strong** | Linear consistency. When an operation completes, it's replicated to all regions and is visible to all clients. |
| **Bounded Staleness** | Reads lag behind writes by a configured threshold in time or items. |
| **Session** | Within a specific session, all reads and writes are of linear consistency. |
| **Consistent Prefix** | Reads may lag behind writes, but reads will never appear out of order. |
| **Eventual** | Reads will eventually be consistent with writes. |

## Strong consistency

Strong consistency guarantees that all read operations will return the most recent version of the item. Client applications will never read an outdated item due to so form of latency. Write operations are not fully committed until they are ready in all other regions.

This characteristic causes strong consistency to have the highest latency as it must wait for commits to replicate across large geographical distances.

## Bounded Staleness consistency

Bounded staleness is similar to Strong consistency except that reads are allowed to lag behind writes up to a defined threshold. That threshold could be defined as:

- **K** versions of an item lag behind the writes
- **T** time interval lag behind the writes

Bounded staleness is a good compromise for applications that want low write latency but need to enforce consistency up to a reasonable threshold.

## Session consistency

Session consistency guarantees strong consistency within a single client session. Outside of that client session, the consistency guarantee is relaxed to either Consistent Prefix or Eventual consistency.

Session consistency is a great option for applications where the end users may be confused if they cannot immediately see any transaction they just made.

## Consistent Prefix consistency

Consistent Prefix consistency allows for looser consistency and higher performance while guaranteeing that reads, which lag behind the writes, will appear in their linear order.

Consistent Prefix consistency is ideal for applications where the order of read operations matters more than the latency.

## Eventual consistency

Eventual consistency is the weakest form of consistency where reads lag behind writes and reads may appear out of order. However, eventual consistency will have the lowest write latency, highest availability, and potential for most read scalability compared to other options.

Eventual consistency is a good option for applications that don't require any linear or consistency guarantees.
