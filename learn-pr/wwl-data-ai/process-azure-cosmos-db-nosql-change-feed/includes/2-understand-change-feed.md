Contoso's catalog stores a copy of each category's name on every product document, a denormalization that makes the storefront's read path a single lookup. The cost of that decision is a synchronization job: when a category is renamed, something has to find the affected products and update them. The change feed is where that job gets its input.

In this unit, you learn what the change feed records, how the two read models differ, and how to tell whether a consumer is keeping up.

## What the change feed records

The change feed is a durable record of changes to a container, ordered by modification time within each partition key value. Its default mode is enabled on every container, with nothing to configure and no way to turn it off, and the feed exists whether or not anything reads it. A later unit covers the second mode, which takes account-level configuration before you can read it.

Four properties of the feed shape how you design around it:

- **Order is guaranteed per partition key value, not across the container.** Two changes to the same product arrive in the order they happened. A change to a product in one category and a change to a product in another arrive in no defined relative order.
- **Items written in one scope share a timestamp.** Changes made inside a transactional batch, a stored procedure, or a bulk request carry the same modification time, and the feed can deliver them in any order relative to each other.
- **Changes are available in parallel across feed ranges.** A large container's feed splits into feed ranges so that multiple consumers can process it concurrently.
- **Multiple independent consumers can read the same feed.** One application updating a search index and another archiving records don't interfere with each other, and each tracks its own position.

Reading the feed consumes request units from the monitored container. The change feed processor also consumes storage and request units in its lease container. The pull model doesn’t require a lease container, but the application must persist its continuation tokens if it needs to resume reliably.

## Two ways to read the feed

Azure Cosmos DB offers two ways to read the change feed: the change feed processor and the pull model. In latest-version mode, both can process the same available changes, but they differ in how they manage progress, polling, and parallelism. Mode, language, and SDK support can further limit which read model is available.

The **change feed processor** is a library that runs inside your application. You give it a container to monitor, a container to store its position, and a delegate that receives batches of changes. It polls on its own schedule, distributes work across instances, and records progress after each successful batch.

The **pull model** hands you the feed directly. You ask for the next page of changes, decide what to do with the response, and persist a continuation token when you want to resume later.

| Concern | Change feed processor | Pull model |
|:--------|:----------------------|:-----------|
| Position tracking | Lease documents in a lease container | A continuation token you store yourself |
| Polling | Automatic, on a configurable interval | Manual, every read is your call |
| No new changes | Waits and rechecks | Returns HTTP 304 `NotModified` for you to handle |
| Parallelism | Automatic across instances sharing a lease container | Manual, by distributing feed ranges |
| Reading 1 partition key | Not supported | Supported |
| Replaying past changes | Supported | Supported |

:::image type="content" source="../media/change-feed-read-models.png" alt-text="Diagram comparing the change feed processor and the pull model, and which one stores the read position." lightbox="../media/change-feed-read-models.png":::

Continuation tokens and leases aren't interchangeable. A consumer that starts on one model can't hand its position to the other.

Reach for the pull model when you need something the processor deliberately doesn't give you: changes for a single partition key value, direct control over the pace of consumption, or a one-time read of a container's history for a migration. For anything that runs continuously, the processor is the simpler choice, because everything it automates is something you'd otherwise write and test yourself.

### Language support narrows the choice

The change feed processor ships only in the .NET V3 SDK and the Java V4 SDK. The Python SDK and the Node.js SDK don't include it.

That constraint matters more than it first appears. A Python consumer has two viable paths: you can use the pull model or an Azure Functions trigger. With the pull model, you write the polling loop and store continuation tokens. With the *Azure Functions* trigger, the platform runs the processor and invokes your function for each batch. The Functions trigger is available for .NET, Java, Python, and Node.js, which makes it the shortest path to a reliable continuous consumer in a language the processor doesn't support.

> **Guiding question:** Think about a background job in a system you work on that reacts to database writes. Does it need changes for one specific entity, or for everything in a container? Does it need to run continuously, or once? Your answers point at one read model over the other.

## Measuring how far behind a consumer is

A consumer processes changes at whatever rate its CPU, memory, and network allow. When writes arrive faster than that rate, the consumer falls behind, and the symptom, stale data downstream, looks identical whether the lag is 2 seconds or 2 hours.

The change feed estimator reports that gap. It compares the last processed position recorded in the lease container against the latest change in the monitored container, and returns the number of changes still pending. It runs in two shapes: a push model that calls a delegate on an interval, and an on-demand call that returns per-lease detail, including the estimated lag for each lease and which instance currently owns it. The per-lease view is what tells you whether the whole deployment is undersized or one instance is stuck.

Run the estimator on its own instance rather than inside a processor host. A single estimator can track every lease in a deployment, and each measurement spends request units on both the monitored and lease containers, so a check every minute is a reasonable starting point.

## Changes in multi-region accounts

In an account replicated across regions, changes made in one region appear in the feed in all of them. The feed is contiguous across a manual failover of the write region.

Accounts configured for writes in multiple regions behave differently in one respect worth knowing before you design around them. Items arrive in the order recorded by the conflict-resolution timestamp rather than the local write timestamp, and there's no guarantee of when a change becomes available. In the default mode, a change to an item can be dropped from the feed if a more recent change to the same item arrives from another region.
