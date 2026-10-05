Tuning an indexing policy is a workload question, not a database question. The same container can be over-indexed for its writes and under-indexed for its reads at the same time, which is exactly the position the Contoso catalog is in. This unit walks through fitting the policy to the read and write mix, then applying the change safely.

## Choose an include or exclude strategy

Start by deciding which list carries the root path, because that decision sets the default for every property you don't yet consider.

An **opt-out** policy includes `/*` and excludes the paths you don't query. It's the recommended starting point, and it's the right choice for the catalog: the storefront's queries change often, and a new filter on a newly added property keeps working without a policy change.

:::image type="content" source="../media/index-cost-comparison.png" alt-text="Diagram of two panels comparing an opt-out policy for a read-heavy workload with an opt-in policy for a write-heavy workload." lightbox="../media/index-cost-comparison.png":::

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    { "path": "/*" }
  ],
  "excludedPaths": [
    { "path": "/description/?" },
    { "path": "/tags/*" },
    { "path": "/\"_etag\"/?" }
  ]
}
```

An **opt-in** policy excludes `/*` and includes only the paths you query. It produces the smallest index and the cheapest writes, and it suits a container whose access patterns are fixed and well understood, such as an append-heavy telemetry store queried on two properties. Remember that an opt-in policy doesn't index the partition key path for you, so include it explicitly.

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    { "path": "/categoryId/?" },
    { "path": "/price/?" },
    { "path": "/name/?" }
  ],
  "excludedPaths": [
    { "path": "/*" }
  ]
}
```

## Tune for a read-heavy workload

On a read-heavy container, indexing lets a query avoid a full scan, so the goal is coverage of the properties your queries touch.

Work from the query list, not from the schema. For each query, note the properties in the `WHERE` clause, the `ORDER BY` clause, and any `JOIN`. Those paths need an index. Properties that appear only in the `SELECT` projection don't, because the engine loads the whole item once it identifies a match, and projecting a property costs nothing extra in index terms.

Two habits help here. Keep the root path included so a new filter doesn't silently fall back to a scan. And where a query uses two or more properties together, check whether it needs a composite index rather than more single-path indexes, which the next unit covers.

## Tune for a write-heavy workload

On a write-heavy container, every indexed path is a cost on every create, replace, and delete. Total consumed storage is the sum of the data size and the index size, and a policy that indexes everything can produce an index larger than the data it describes.

Look for three shapes:

- **Large scalar values nobody filters on.** A product `description` is the classic case. Excluding `/description/?` removes a long string from the index without affecting any query that only projects it.
- **Subtrees you never reach into.** Excluding `/tags/*` drops every path under the array. If one property inside the array is queried, exclude the subtree and include the single path back, and precedence resolves the overlap in your favor.
- **Properties that change on every write.** A rewritten timestamp or counter costs an index update every time even when no query sorts on it.

The measurement to trust is the request charge on a representative write, before and after. Run a create or a replace, read the charge, apply the policy change, and run the identical operation again. That number is the payoff, and it's specific to your item shape.

## Apply the change and track the transformation

Updating a policy triggers an **index transformation**. The transformation runs online and in place, so it consumes no extra storage and doesn't affect the container's write availability, read availability, or provisioned throughput. It does consume request units, at a lower priority than your own reads and writes.

Adding and removing paths behave differently, and the asymmetry matters:

- **Removing** an index path takes effect immediately. The engine stops using that path at once. Filters can fall back to a scan, but queries that require the removed index, such as an `ORDER BY` without another suitable index, fail.
- **Adding** an index path takes time. Queries keep using the existing indexes and see the benefit only once the transformation completes.

Two rules follow. Group multiple removals into a single policy update, because the engine returns consistent and complete results throughout one transformation but not across several overlapping ones. And when you replace one index with another, such as swapping a single-path index for a composite index, add the new one first, wait for the transformation to finish, and only then remove the old one.

> [!IMPORTANT]
> The following SDK container-replacement methods don't support Microsoft Entra authentication through the data-plane endpoint. For a keyless account, apply the policy through the Azure CLI example at the end of this unit, the Azure portal, or a management-plane API. The SDK reads used to check transformation progress support Microsoft Entra authentication.

::: zone pivot="csharp"

Read the container's properties, edit the policy, and replace the container:

```csharp
Container container = client.GetDatabase("cosmicworks").GetContainer("product");

ContainerResponse response = await container.ReadContainerAsync();
ContainerProperties properties = response.Resource;

properties.IndexingPolicy.ExcludedPaths.Add(new ExcludedPath { Path = "/description/?" });
properties.IndexingPolicy.ExcludedPaths.Add(new ExcludedPath { Path = "/tags/*" });

await container.ReplaceContainerAsync(properties);
```

Track the transformation by requesting quota information and reading the progress header, which reports a percentage:

```csharp
ContainerResponse progress = await container.ReadContainerAsync(
    new ContainerRequestOptions { PopulateQuotaInfo = true });

long percent = long.Parse(progress.Headers["x-ms-documentdb-collection-index-transformation-progress"]);
Console.WriteLine($"Index transformation: {percent}%");
```

::: zone-end

::: zone pivot="python"

Build the policy as a dictionary and pass it to `replace_container`:

```python
database = client.get_database_client("cosmicworks")
container = database.get_container_client("product")

indexing_policy = {
    "indexingMode": "consistent",
    "automatic": True,
    "includedPaths": [{"path": "/*"}],
    "excludedPaths": [
        {"path": "/description/?"},
        {"path": "/tags/*"},
        {"path": '/"_etag"/?'},
    ],
}

database.replace_container(
    container=container,
    partition_key=PartitionKey(path="/categoryId"),
    indexing_policy=indexing_policy,
)
```

Track the transformation with a response hook that reads the progress header:

```python
container.read(
    populate_quota_info=True,
    response_hook=lambda headers, properties: print(
        headers["x-ms-documentdb-collection-index-transformation-progress"]
    ),
)
```

::: zone-end

You can also apply a policy from a JSON file with the Azure CLI, which is convenient when the policy is checked into source control alongside the application:

```azurecli
az cosmosdb sql container update `
    --resource-group $resourceGroup `
    --account-name $accountName `
    --database-name cosmicworks `
    --name product `
    --idx @index-policy.json
```

Learn more about [managing indexing policies](/azure/cosmos-db/how-to-manage-indexing-policy) and [modifying an indexing policy](/azure/cosmos-db/index-policy#modifying-the-indexing-policy).
