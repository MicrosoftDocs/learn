With writes accepted in Europe and in West US 2, two customers can change the same catalog item inside the replication window. Azure Cosmos DB doesn't reject either write. It commits both locally and then reconciles them, and a container-level policy decides how. In this unit, you choose that policy, write the resolution logic when the default isn't enough, and read the feed of conflicts the service couldn't settle on its own.

Conflicts apply only to accounts with multiple write regions. A single-write-region account has one place where writes are ordered, so the resolution policies in this unit don't apply to it.

## Know which conflicts can occur

The service recognizes three kinds of update conflict:

| Type | Cause |
| :--- | :--- |
| Insert | Two or more regions insert items with the same unique index value, most often the same `id`, at the same time |
| Replace | Two or more regions update the same item at the same time |
| Delete | One region deletes an item while another updates it |

All three arise from the same condition: concurrent changes in different regions to an item before it finishes replicating. Reducing the conflict rate is a matter of traffic design, which the previous unit covered. Resolving the conflicts that still happen is a matter of policy.

## Let the service pick a winner

The default policy is **last writer wins**, and every container gets it without any configuration. It compares the system timestamp `_ts` across the conflicting versions and keeps the highest one. A delete always wins over an insert or a replace, no matter what the timestamps say. Every region converges on the same winner, and conflicts resolved this way never reach the conflict feed.

For accounts using the API for NoSQL, you can point the policy at a numeric property of your own instead of `_ts`. That property is the **conflict resolution path**, and the highest value wins:

> [!IMPORTANT]
> The SDK creation examples in this unit require a new container and authorization for the creation operations. They don't change the policy of an existing container, including the lab's `product` container. The Microsoft Entra ID clients in this module can't create containers through these data-plane methods. With Microsoft Entra ID, use the Azure CLI or another management-plane tool to create the container and register its merge stored procedure. See [nondata operation restrictions](/azure/cosmos-db/troubleshoot-forbidden#nondata-operations-arent-allowed).

::: zone pivot="csharp"

```csharp
Database database = client.GetDatabase("cosmicworks");

ContainerProperties properties = new("product", "/categoryId")
{
    ConflictResolutionPolicy = new ConflictResolutionPolicy()
    {
        Mode = ConflictResolutionMode.LastWriterWins,
        ResolutionPath = "/updateSequence"
    }
};

Container container = await database.CreateContainerIfNotExistsAsync(properties);
```

::: zone-end

::: zone pivot="python"

```python
from azure.cosmos import PartitionKey

database = client.get_database_client("cosmicworks")

container = database.create_container_if_not_exists(
    id="product",
    partition_key=PartitionKey(path="/categoryId"),
    conflict_resolution_policy={
        "mode": "LastWriterWins",
        "conflictResolutionPath": "/updateSequence",
    },
)
```

::: zone-end

A custom path is worth the effort when your application already has a better notion of ordering than wall-clock time, such as a monotonically increasing version number issued by an upstream system. It carries an obligation: the application has to write that property on every item. **If the path is missing or holds a value that isn't numeric, the policy falls back to `_ts`,** silently, so a half-applied version number degrades to timestamp ordering without an error.

> [!IMPORTANT]
> A conflict resolution policy can only be set when a container is created. There's no operation that changes it afterward, so a container that needs a non-default policy needs it planned before the data lands.

## Resolve conflicts with your own logic

When the winner depends on the contents of the items rather than on one property, use the **custom** policy with a merge stored procedure. The service invokes it inside a database transaction when it detects a conflict, and guarantees exactly-once execution.

Every merge procedure implements the same signature:

```javascript
function resolveConflict(incomingItem, existingItem, isTombstone, conflictingItems) {
```

| Parameter | Value |
| :--- | :--- |
| `incomingItem` | The item being inserted or updated that caused the conflict. Null for a delete |
| `existingItem` | The currently committed item. Null for an insert or a delete |
| `isTombstone` | True when the incoming item conflicts with an item that was already deleted. `existingItem` is also null in that case |
| `conflictingItems` | Every committed item conflicting with `incomingItem` on `id` or another unique index |

Register the procedure and name it in the policy:

::: zone pivot="csharp"

```csharp
ContainerProperties properties = new("product", "/categoryId")
{
    ConflictResolutionPolicy = new ConflictResolutionPolicy()
    {
        Mode = ConflictResolutionMode.Custom,
        ResolutionProcedure = "dbs/cosmicworks/colls/product/sprocs/resolveConflict"
    }
};

Container container = await database.CreateContainerIfNotExistsAsync(properties);

await container.Scripts.CreateStoredProcedureAsync(
    new StoredProcedureProperties("resolveConflict", File.ReadAllText("resolveConflict.js")));
```

::: zone-end

::: zone pivot="python"

```python
container = database.create_container_if_not_exists(
    id="product",
    partition_key=PartitionKey(path="/categoryId"),
    conflict_resolution_policy={
        "mode": "Custom",
        "conflictResolutionProcedure": "dbs/cosmicworks/colls/product/sprocs/resolveConflict",
    },
)

with open("resolveConflict.js") as script:
    container.scripts.create_stored_procedure(
        {"id": "resolveConflict", "body": script.read()}
    )
```

::: zone-end

The procedure runs on the server with the same reach as any other stored procedure: it can read and write items sharing the conflicting item's partition key, so it can delete the losers and replace the survivor. Like the custom policy itself, a merge procedure is available for the API for NoSQL only.

## Read the conflict feed

Set the policy to custom and register no procedure, and the service resolves nothing automatically. Every conflict lands in the container's **conflict feed** for the application to settle. The feed also collects conflicts whose registered procedure threw an error, which means a container with a merge procedure still needs feed-reading code as a fallback.

::: zone pivot="csharp"

```csharp
FeedIterator<ConflictProperties> conflictFeed =
    container.Conflicts.GetConflictQueryIterator<ConflictProperties>();

while (conflictFeed.HasMoreResults)
{
    FeedResponse<ConflictProperties> conflicts =
        await conflictFeed.ReadNextAsync();

    foreach (ConflictProperties conflict in conflicts)
    {
        if (conflict.OperationKind == OperationKind.Delete)
        {
            // Apply application-specific delete-conflict handling.
            continue;
        }

        Product attempted =
            container.Conflicts.ReadConflictContent<Product>(conflict);

        ItemResponse<Product> currentResponse =
            await container.Conflicts.ReadCurrentAsync<Product>(
                conflict,
                new PartitionKey(attempted.CategoryId));

        Product committed = currentResponse.Resource;
        Product merged = Reconcile(committed, attempted);

        await container.ReplaceItemAsync(
            merged,
            merged.Id,
            new PartitionKey(merged.CategoryId));

        await container.Conflicts.DeleteAsync(
            conflict,
            new PartitionKey(merged.CategoryId));
    }
}

```

`ReadConflictContent` returns the conflicting version stored in the conflict feed; it isn’t necessarily a "loser" until the application applies its resolution policy. `ReadCurrentAsync` returns an `ItemResponse<T>` containing the currently committed item. Inspect `OperationKind` and handle delete conflicts separately because their content and reconciliation requirements differ from insert and replace conflicts. After the application resolves a conflict, call `DeleteAsync` to remove its conflict record from the feed.

::: zone-end

::: zone pivot="python"

```python
for conflict in container.list_conflicts():
    print(f"Unresolved conflict on item {conflict['resourceId']}")
    # Reconcile against the committed item, write the result, and remove the conflict.
```

::: zone-end

The conflict feed carries one more behavior worth knowing about, and it isn't a conflict at all. When a region that held unreplicated writes comes back online after an outage, those writes are surfaced through the same feed. Code that drains this feed is therefore also the code that recovers data after a failover, which the next unit sets up.

Learn more about [conflict types and resolution policies](/azure/cosmos-db/conflict-resolution-policies) and [managing conflict resolution policies](/azure/cosmos-db/how-to-manage-conflicts).
