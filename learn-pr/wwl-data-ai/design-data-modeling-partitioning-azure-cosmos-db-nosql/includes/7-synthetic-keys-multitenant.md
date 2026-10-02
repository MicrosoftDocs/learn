Hierarchical keys work when the first level has enough distinct values to spread across physical partitions. Some workloads have no such property. A telemetry stream keyed by date concentrates every write on today. A container of audit events keyed by tenant has 12 tenants. In both cases, no single property in the data satisfies the cardinality criterion, so you construct one.

In this unit, you build synthetic partition keys and apply the container-level patterns that keep multiple tenants sharing one account without one of them starving the others.

## A synthetic key is a property you compute

A synthetic key is an ordinary property whose value the application calculates before writing the item. Azure Cosmos DB treats it like any other partition key path. The work lives entirely in your code, and there are three techniques.

**Concatenate two properties.** The simplest form joins values into one string, giving the key the combined cardinality of both. A device telemetry item keyed by `deviceId` alone spreads well but can't isolate a time range; keyed by `date` alone it hot-spots on the current day. Concatenating gives `abc-123-2026-08`, which distributes writes and still allows an exact lookup when the application knows both values.

**Append a random suffix.** When the goal is purely write distribution, append a random number in a fixed range to the value. Writes for a single day spread across as many logical partitions as the range allows. The suffix is stored in the item's synthetic key, but a reader that knows only the item identifier can't reconstruct it. Unless the application retains the full key separately, locating the item requires searching across the possible suffixes.

**Append a precalculated suffix.** This variant keeps the write distribution and restores the read. Instead of a random number, derive the suffix by hashing a property the application already knows at read time. Writes spread as evenly as with a random suffix, and a reader that knows the source property recomputes the same suffix and performs a point read.

### Build the key value

The precalculated suffix is the one worth writing carefully, because a subtle bug makes items unreadable. The hash has to be stable across processes and deployments. This requirement rules out the language's built-in string hash in both C# and Python. Both are randomized per process for security reasons, so the same input produces different values in different runs.

::: zone pivot="csharp"

```csharp
// SHA256.HashData requires .NET 5 or later.
static int Bucket(string value, int buckets)
{
    byte[] hash = SHA256.HashData(Encoding.UTF8.GetBytes(value));
    return ((hash[0] << 8) | hash[1]) % buckets;
}

string partitionKey = $"{order.orderDate:yyyy-MM-dd}-{Bucket(order.customerId, 100)}";
order.partitionKey = partitionKey;

await container.CreateItemAsync(order, new PartitionKey(partitionKey));
```

Avoid `string.GetHashCode` here. Its value isn't stable across runs, .NET versions, or platforms, and the documentation states that hash codes should never be persisted. An item written by one instance becomes unreachable from another.

::: zone-end

::: zone pivot="python"

```python
import hashlib

def bucket(value: str, buckets: int) -> int:
    digest = hashlib.sha256(value.encode("utf-8")).digest()
    return int.from_bytes(digest[:2], "big") % buckets

partition_key = f"{order['orderDate'][:10]}-{bucket(order['customerId'], 100)}"
order["partitionKey"] = partition_key

container.create_item(body=order)
```

Avoid the built-in `hash` function. Python salts string hashing per process by default, so the suffix changes between runs and previously written items can't be located.

::: zone-end

Reading the item back reverses the calculation: recompute the suffix from the same source property, rebuild the key string, and issue a point read. The reconstruction logic belongs in one place in the codebase, because every reader has to produce byte-identical values. Byte order counts as much as the algorithm: both samples read the most significant byte of the digest first. A service that starts with the least significant byte assigns the same input to different buckets. As a result, the service can't find the items that the samples wrote.

## Choose between synthetic and hierarchical keys

Both solve distribution problems, and they suit different shapes of workload.

| Choose | When |
|:-------|:-----|
| Hierarchical key | The first-level property has high cardinality, queries filter on it, and you need prefix routing plus unlimited growth per value. |
| Synthetic key | No property has both high cardinality and query alignment, or the workload is write-dominated and you need writes spread across as many partitions as possible. |
| Item identifier alone | Writes dominate, reads are point reads, and no query filters on anything else. |

The comparison to keep in mind is what each does to queries. A hierarchical key keeps prefix queries efficient by design. A synthetic key doesn't: a query filtering on only one of the concatenated components can't identify the composite value, so it fans out. You buy distribution and pay in query flexibility.

## To share a container, partition by tenant

Multitenancy at the container level means one container holds every tenant's data, partitioned by the tenant identifier, with all tenants sharing the container's throughput. This model has clear strengths:

- **One billable resource.** A single throughput setting covers the whole workload, and small tenants cost almost nothing to host.
- **Immediate onboarding.** A new tenant is a new partition key value, which requires no provisioning.
- **The container is the query boundary.** Cross-tenant reporting is one query rather than a fan-out across accounts.

It also has limits you accept:

- **The isolation is logical, not physical.** Tenants share physical partitions and throughput, so a tenant with a traffic spike consumes capacity the others expected to have.
- **Per-tenant configuration isn't possible.** Regions, backup settings, and encryption keys are account-level properties, so every tenant in the container gets identical treatment.
- **Query scoping is your responsibility.** A partition key alone doesn't prevent a query from reading another tenant's items. When the application has access to the shared container, it must authorize tenant access and scope each tenant-specific query to the correct tenant. Service permissions can restrict access to a complete logical partition, but not to a partial hierarchical-key prefix.

Where tenant sizes vary, the techniques from this module compose. Use a hierarchical key rooted at the tenant identifier when tenants are numerous, read-heavy, and individually large. Use a synthetic key when the tenant count is low enough that the tenant identifier alone can't spread writes.

### Handle the tenant that doesn't fit

Contoso's largest brand sends more traffic than all other tenants combined. A more granular key can spread its requests across physical partitions, but it doesn't reserve throughput for other tenants in the shared container. If its spikes exhaust shared capacity, they can increase latency for other tenants.

The usual answer is to stop treating it like the others. Move the outlier tenant to its own database account with dedicated throughput, and leave the remaining tenants in the shared, tenant-partitioned container. The application routes by tenant identifier at connection time. Giving that tenant its own container looks like the smaller step, but it isn't the recommended one: metadata operations don't scale with container count, so the account is the isolation boundary that holds up. Account-level isolation introduces different management and cost tradeoffs. This decision is separate from the container-level design covered in this module. However, you should recognize when a shared container no longer meets the needs of a workload.

:::image type="content" source="../media/multitenant-isolation.png" alt-text="Diagram showing an application routing most tenants to a shared tenant-partitioned container and one outlier tenant to a dedicated account." lightbox="../media/multitenant-isolation.png":::

> **Synthesis prompt:** Contoso onboards two new tenants. One is a marketplace with 40,000 sellers and steady, evenly spread traffic. The other is a flash-sale retailer with a small catalog whose traffic arrives in 10-minute bursts that dwarf everything else on the platform. Decide the partitioning approach for each, and say what evidence would change your mind. Consider first-level cardinality, how each tenant's traffic distributes over time, and which of the two is a candidate for isolation rather than a better key.
