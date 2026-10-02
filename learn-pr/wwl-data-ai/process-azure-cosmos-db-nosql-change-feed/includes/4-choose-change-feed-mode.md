The category-sync consumer works because it needs the latest category name after an update, not every intermediate version. Contoso's next requirement doesn't share that property. Compliance asks for an audit trail of deleted products, and the consumer built so far can't produce one, because in its default configuration the feed never reports a deletion.

In this unit, you learn what each change feed mode captures. You also examine the cost of the more detailed mode. Then, you choose the mode that meets your workload requirements.

## Latest version mode

Latest version mode is the default. Every container has it, no account configuration is involved, and it's the mode every read model supports.

It records inserts and updates, and it records only the current state of each item. If an item is created and updated twice before you read the feed, you receive one entry holding the final version. Deletions aren't recorded at all; a deleted item disappears from the feed entirely, including entries that were already there.

What you get in exchange is retention and flexibility. There's no retention window, so changes stay readable for the life of the container. A consumer can start at the beginning of the container or at the current time. It can also start from a saved position or a specific time. The time has a precision of about five seconds.

Workloads that don't care about deletes usually fit this mode without compromise: replicating a container to a secondary store, building or rebuilding a search index, keeping a denormalized copy in sync, or reacting to new records in real time.

When a workload needs deletes but the other tradeoffs favor latest version mode, a soft delete works. Rather than deleting the item, set a flag on it, `deleted: true`, and set a Time to Live (TTL) value. The flag change reaches the feed as an update, and the service removes the item when the TTL expires. Consumers have to process the change before the TTL fires, so the expiration period sets the deadline for the whole pipeline.

## All versions and deletes mode

All versions and deletes mode records every change in the order it occurred: creates, updates, deletes, and removals caused by TTL expiration. Nothing is collapsed. Two updates between reads arrive as two entries.

Each entry also carries metadata identifying the operation, which lets a consumer branch on the change type instead of inferring it. A delete entry for a removed category looks like this example:

```json
{
  "metadata": {
    "operationType": "delete",
    "lsn": 17,
    "crts": 1735689600,
    "previousImageLSN": 16,
    "timeToLiveExpired": false,
    "id": "3E4CEACD-D007-46EB-82D7-31F6141752B2",
    "partitionKey": {
      "type": "category"
    }
  }
}
```

Create and replace entries carry a `current` property holding the full item, alongside a metadata block with `operationType`, `lsn`, and `crts`; replace entries also include `previousImageLSN`. Note what's absent: there's no `previous` image, so a consumer that needs to know what an item looked like before an update still has to keep that state itself.

This mode is what enables a small set of scenarios that latest version mode can't cover: alerting on deletions for auditing, moving data between two locations without introducing soft deletes, and triggering distinct logic per operation type.

All-versions-and-deletes mode isn’t itself a permanent audit archive. Changes remain available only within the continuous-backup retention period. A compliance workload that must retain events longer must process them within that window and persist them to an appropriate audit store.

## What the richer mode requires

The capability isn't free, and most of its cost is account-level rather than code-level.

| Requirement | Detail |
|:------------|:-------|
| Account API | Azure Cosmos DB for NoSQL only |
| Continuous backups | Required. Turning them on creates the all-versions-and-deletes feed |
| Account feature | Enabled on the **Features** page of the account. Enablement takes up to 30 minutes, and no other account changes are allowed while it runs |
| Partition merge | Incompatible. Accounts with merged partitions, or with merge enabled, aren't supported |
| Connection mode | All reads use gateway mode, regardless of the client's configured connection mode |

Two behavioral limits follow from the design. The retention period is the account’s continuous backup window. If a container is eight days old and the retention period is seven days, you can access only the last seven days of changes. A request for older changes returns an error. And a consumer can start only from now or from a saved lease or continuation token; starting from the beginning of the container or from an arbitrary timestamp isn't available.

SDK support is narrower than for latest version mode:

| Read method | .NET | Java | Python | Node.js |
|:------------|:-----|:-----|:-------|:--------|
| Pull model | 3.60.0 or later | 4.81.0 or later | 4.9.1b1 or later | 4.1.0 or later |
| Change feed processor | 3.60.0 or later | 4.81.0 or later | Not supported | Not supported |
| Azure Functions trigger | Isolated worker extension 4.16.1 or later | Not supported | Not supported | Not supported |

In .NET, the mode is a different entry point rather than a flag: `GetChangeFeedProcessorBuilderWithAllVersionsAndDeletes` instead of `GetChangeFeedProcessorBuilder`, and the delegate receives `ChangeFeedItem<T>` rather than `T`, with `Current` and `Metadata` properties. The .NET pull model also requires a mode when you create an iterator, including when you resume from a continuation token. In Python, set `mode` on the initial read. A Python continuation token carries the mode, so a resumed read uses the token's mode and ignores a separate `mode` argument.

## Deciding

The question that settles most cases is a single one: does the consumer need to act on deletions or on intermediate versions?

| The consumer needs | Mode |
|:-------------------|:-----|
| Current state of changed items, replay from any point | Latest version |
| A record of deletions, including TTL expirations | All versions and deletes |
| Every intermediate version between reads | All versions and deletes |
| To distinguish creates from updates from deletes | All versions and deletes |
| The latest available version of existing items from before the backup retention window | Latest version |
| Every historical version or deletion beyond the backup retention window | Neither mode; persist those events in another store before they expire |
| A Python or Node.js consumer using the Functions trigger | Latest version |

If the answer is no, latest version mode is the simpler default. If the answer is yes, weigh the account-level requirements before committing, continuous backups and the incompatibility with partition merge, because both are account properties that other workloads on the same account inherit.

A single container supports both. Different applications can read the same container's feed in different modes at the same time, so an audit consumer on all versions and deletes and an indexer on latest version mode coexist without conflict. What isn't allowed is one consumer switching modes, because each consumer is fixed to the mode it was configured with.

> **Synthesis prompt:** Contoso needs three consumers on the catalog: a search indexer, a compliance log of product deletions, and a cache invalidator that only needs to know an item changed. Decide the mode for each. Then, check whether your account-level choices, continuous backups in particular, are compatible with all three running together.
