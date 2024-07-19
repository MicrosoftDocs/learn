Each of the consistency models can be used for specific real-world scenarios. Each provides precise availability and performance tradeoffs backed by comprehensive SLAs. The following simple considerations help you make the right choice in many common scenarios.

## Configure the default consistency level

You can configure the default consistency level on your Azure Cosmos DB account at any time. The default consistency level configured on your account applies to all Azure Cosmos DB databases and containers under that account. All reads and queries issued against a container or a database use the specified consistency level by default.

Read consistency applies to a single read operation scoped within a logical partition. The read operation can be issued by a remote client or a stored procedure.

## Guarantees associated with consistency levels

Azure Cosmos DB guarantees that 100 percent of read requests meet the consistency guarantee for the consistency level chosen. The precise definitions of the five consistency levels in Azure Cosmos DB using the TLA+ specification language are provided in the [azure-cosmos-tla](https://github.com/Azure/azure-cosmos-tla) GitHub repo.

### Strong consistency

Strong consistency offers a linearizability guarantee. Linearizability refers to serving requests concurrently. The reads are guaranteed to return the most recent committed version of an item. A client never sees an uncommitted or partial write. Users are always guaranteed to read the latest committed write.

### Bounded staleness consistency

In bounded staleness consistency, the lag of data between any two regions is always less than a specified amount. The amount can be "K" versions (that is, "updates") of an item or by "T" time intervals, whichever is reached first. In other words, when you choose bounded staleness, the maximum "staleness" of the data in any region can be configured in two ways:

*   The number of versions (*K*) of the item
*   The time interval (*T*) reads might lag behind the writes

Bounded Staleness is beneficial primarily to single-region write accounts with two or more regions. If the data lag in a region (determined per physical partition) exceeds the configured staleness value, writes for that partition are throttled until staleness is back within the configured upper bound.

For a single-region account, Bounded Staleness provides the same write consistency guarantees as Session and Eventual Consistency. With Bounded Staleness, data is replicated to a local majority (three replicas in a four replica set) in the single region.

### Session consistency

In session consistency, within a single client session, reads are guaranteed to honor the read-your-writes, and write-follows-reads guarantees. This guarantee assumes a single “writer” session or sharing the session token for multiple writers.

Like all consistency levels weaker than Strong, writes are replicated to a minimum of three replicas (in a four replica set) in the local region, with asynchronous replication to all other regions.

### Consistent prefix consistency

In consistent prefix, updates made as single document writes see eventual consistency. Updates made as a batch within a transaction, are returned consistent to the transaction in which they were committed. Write operations within a transaction of multiple documents are always visible together.

Assume two write operations are performed on documents *Doc 1* and *Doc 2*, within transactions T1 and T2. When client does a read in any replica, the user sees either “*Doc 1* v1 and *Doc 2* v1” or “*Doc 1* v2 and *Doc 2* v2”, but never “*Doc 1* v1 and *Doc 2* v2” or “*Doc 1* v2 and *Doc 2* v1” for the same read or query operation.

### Eventual consistency

In eventual consistency, there's no ordering guarantee for reads. In the absence of any further writes, the replicas eventually converge.

Eventual consistency is the weakest form of consistency because a client might read the values that are older than the ones it read before. Eventual consistency is ideal where the application doesn't require any ordering guarantees. Examples include count of Retweets, Likes, or nonthreaded comments
