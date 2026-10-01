Consistency levels control both the guarantees a read receives and how writes replicate across regions. These concerns are related but distinct.

Most applications don't need strong consistency simply to let users read their own writes. Session consistency provides read-your-writes and monotonic-read guarantees within a client session. The Cosmos DB SDK carries a session token between operations, and clients can pass that token between requests to ensure they read their own writes. Session reads use one replica and have the same request unit (RU) cost as consistent prefix and eventual reads.

Strong consistency serves a different requirement: every read returns the latest globally committed write, regardless of which client issued it. In a multi-region account, this guarantee increases write latency because a write must commit across regions. Bounded staleness limits cross-region replication lag to a configured number of versions or time interval.

Consistency also affects recovery point objectives during an unrecoverable regional failure. Strong consistency provides a recovery point objective (RPO) of zero. Bounded staleness limits potential data loss to its configured K or T bound. Session, consistent prefix, and eventual consistency replicate asynchronously across regions and don't provide a user-configurable RPO boundary.

Per-request consistency overrides change read behavior and read cost. They don't change how the account replicates writes or the account’s cross-region RPO.

## The five consistency levels

Azure Cosmos DB offers a sliding scale of five well-defined consistency levels, not just the strong-or-eventual choice many databases force. Each level trades read guarantees against latency, availability, and throughput.

:::image type="content" source="../media/consistency-sliding-scale.png" alt-text="Diagram showing five consistency levels from strong to eventual. Strong and bounded staleness reads use twice as many request units.":::

| Consistency level | Guarantee |
| ---: | :--- |
| **Strong** | Reads always return the most recent committed write. In a multi-region account, writes normally aren't acknowledged until all regions acknowledge replication, so distance between regions increases 'write latency.' |
| **Bounded staleness** | Reads lag writes by at most a configured number of versions (*K*) or time interval (*T*). Reads in the write region use a local quorum, the same read mechanism the *strong* level uses. |
| **Session** | Within a client session, clients read their own writes. Reads against a physical partition the session has yet to write to behave as *eventual* reads. This level is the default. |
| **Consistent prefix** | Reads might lag writes. Writes made as a batch within a transaction are always visible together, while individual document writes have *eventual* consistency and can arrive out of order. |
| **Eventual** | Reads eventually match writes and might appear out of order. Reads use a single replica, with the same RU cost as session and consistent prefix. |

The levels form a spectrum of read guarantees, but read cost doesn't decrease at every step. **Strong** and **bounded staleness** reads cost twice as many RUs as **session**, **consistent prefix**, and **eventual** reads. The three weaker levels have the same read RU cost, and session provides latency and availability comparable to eventual. **Session**, the default, is a practical middle ground: users reliably see their own changes within a session, without paying the RU cost of strong reads.

Two constraints narrow the choice before you make it. Accounts configured with multiple write regions can't use *strong* consistency at all. And *bounded staleness* enforces minimum values for *K* and *T* that depend on the account's topology. For a single-region account, the minimums are 10 write operations or 5 seconds. For a multi-region account, the minimums rise to 100,000 write operations or 300 seconds. On a single-region account, *bounded staleness* offers the same write-consistency guarantees as *session* and *eventual* but has a higher read cost, so the level is primarily beneficial across regions.

Start with session consistency for application workflows that need users to read their own writes. Choose strong consistency only when reads from ***any client or region*** must return the latest globally committed value. Choose bounded staleness when the application requires a defined upper bound on cross-region lag or potential data loss. Use consistent prefix or eventual consistency when the application doesn't require session guarantees.

Select consistency from the required guarantee rather than from the business domain. A financial or inventory application doesn't automatically require strong consistency; its transactions, read paths, session boundaries, and regional recovery requirements determine the appropriate level.

## Set the account default

Every account has a default consistency level that applies to all reads and queries against its containers. This level is **session** unless you change it. In the Azure portal, you set it on the account's **Default consistency** pane. Session is the default and is appropriate for most applications. Don't configure strong or bounded staleness only because one workflow must read its own write; session consistency already provides that guarantee.

Configure strong consistency when the account requires global linearizability and an RPO of zero. Configure bounded staleness when the account requires a defined cross-region staleness and RPO boundary. These account-level choices affect write replication even if individual reads request weaker consistency, so per-request overrides aren't a way to avoid their write-latency or durability tradeoffs.

:::image type="content" source="../media/default-consistency-pane.png" alt-text="Screenshot of the Default consistency pane with the five levels shown as a selector and session selected." lightbox="../media/default-consistency-pane-full.png":::

To recreate SDK clients and pick up the new setting, restart applications after changing the account default.

## Relax consistency per request

The `ConsistencyLevel` override and Python's `consistency_level` setting can *relax* reads below the account default, but they can't *strengthen* it. Reducing strong or bounded staleness reads to session or weaker consistency lowers their RU cost. Reducing session reads to eventual doesn't lower their RU cost. The separate .NET preview API described next provides an exception to the relax-only approach.

Read overrides don't change the account's write replication. An account with strong default consistency still replicates writes synchronously across regions even when a client requests eventual reads.

::: zone pivot="csharp"

Relax a single read by passing an `ItemRequestOptions` with a weaker `ConsistencyLevel`:

```csharp
ItemRequestOptions options = new()
{
    ConsistencyLevel = ConsistencyLevel.Eventual
};

Product item = await container.ReadItemAsync<Product>(
    id: "0A7E57DA-C73F-467F-954F-17B7AFD6227E",
    partitionKey: new PartitionKey("4F34E180-384D-42FC-AC10-FEC30227577F"),
    requestOptions: options);
```

To relax consistency for all read operations from a client, set it once through `CosmosClientOptions`:

```csharp
CosmosClientOptions options = new()
{
    ConsistencyLevel = ConsistencyLevel.Eventual
};

CosmosClient client = new(endpoint, credential, options);
```

> [!NOTE]
> The `ConsistencyLevel` override can only *relax* consistency below the account default. The override never strengthens the consistency. The .NET SDK v3.46+ exposes a `ReadConsistencyStrategy` API for per-request reads at a *stronger* level than the account default. This API supports these reads in direct mode. For example, you can use this API to get the latest committed value during a detected outage. See [Manage consistency levels in Azure Cosmos DB](/azure/cosmos-db/how-to-manage-consistency#use-read-consistency-strategy) for details.
>
> `ReadConsistencyStrategy` is currently in preview. Evaluate it before you take a dependency on it in production.

::: zone-end

::: zone pivot="python"

Set the consistency level for a client when you construct it, using the `consistency_level` argument:

```python
from azure.cosmos import CosmosClient

client = CosmosClient(
    url=endpoint,
    credential=credential,
    consistency_level="Eventual")
```

All read operations from this client use the specified level, which must be the account default or weaker.

The Python SDK sets consistency at the client level rather than on individual point reads. To relax consistency for a specific set of reads without changing the client, use `read_items`, which accepts a `consistency_level` argument:

```python
items = container.read_items(
    items=[("0A7E57DA-C73F-467F-954F-17B7AFD6227E", "4F34E180-384D-42FC-AC10-FEC30227577F")],
    consistency_level="Eventual")
```

> [!NOTE]
> Whichever level you pass, it must match the account default or be weaker. The Python SDK offers no way to read at a *stronger* level than the account default, so set the default to the strongest level your operations require.

::: zone-end

## Session tokens

With session consistency, each write returns a session token that identifies the minimum version subsequent reads must observe for the relevant partition. The SDK caches and sends these tokens automatically when operations use the same Cosmos Client.

If a workflow can move between application nodes or client instances, capture the session token from the write response to the user client. Storing the token in a cookie is a typical pattern. Send the token to the subsequent read. Passing the session token preserves the read-your-writes guarantee across those clients. Session tokens are partition-bound, so use the token produced for the partition containing the item.

Session consistency provides this guarantee without the doubled read RU cost of strong or bounded staleness.

:::image type="content" source="../media/session-token-flow.png" alt-text="Diagram showing a write returning a session token that two clients use to read the same write.":::

> [!div class="alert is-primary"]
> **Synthesis prompt:** For Contoso's workload, a "recently viewed items" read can tolerate stale data, but an "order confirmation" read must show the write that just happened. If the account default is session, which read would you relax to eventual, and which would you leave at the default? Explain how the relax-only rule shapes where you set the default.

With throughput and consistency now configured, the last step manages the data itself over time.
