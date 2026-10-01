Once a throughput model is chosen, you decide *where* to provision the throughput: at the database level, shared across all its containers, or at the container level, dedicated to one. In the Contoso scenario, this choice determines whether the new container gets guaranteed, predictable capacity or shares a pool with its neighbors. The trade-off is cost against isolation, and it applies whenever you add a container to an account.

## Shared versus dedicated throughput

**Container-level (dedicated) throughput** reserves request units per second (RU/s) exclusively for a single container. That capacity is always available to the container, and other containers don't affect it. A service-level agreement (SLA) backs the container's performance. Dedicated throughput gives you predictable performance and isolation, at the cost of provisioning each container separately.

**Database-level (shared) throughput** provisions a pool of RU/s at the database that all its containers draw from. Sharing lowers cost when you have many containers that individually see light traffic, because they split one reservation instead of each paying a minimum. The catch: the shared pool offers no per-container guarantee. If one container gets busy, it can consume the shared RU/s and starve the others. A shared-throughput database also holds at most 25 containers. The minimum is 400 RU/s for standard throughput. The minimum autoscale setting has a maximum of 1,000 RU/s and scales between 100 and 1,000 RU/s. Any container beyond that limit needs its own dedicated throughput.

:::image type="content" source="../media/shared-versus-dedicated-throughput.png" alt-text="Diagram comparing a shared 400 RU/s database pool with dedicated throughput for three containers." lightbox="../media/shared-versus-dedicated-throughput.png":::

> [!IMPORTANT]
> Shared database throughput isn't recommended for most workloads. Containers in the same database share partitions, so scaling database throughput to serve a large or growing container can repartition the smaller containers beside it and spread them too thin. Configure throughput at the container level as your starting point, and treat shared throughput as an advanced option for teams that understand and accept these trade-offs.
>
> When those trade-offs are acceptable, a database can mix both models: shared throughput for a group of small containers with similar data volumes and request rates, and dedicated throughput for any high-traffic or latency-sensitive container whose performance can't depend on its neighbors' behavior.

## Configure throughput in the portal

In the Azure portal's **Data Explorer**, you set throughput when you create a database or container. Selecting **Provision database throughput** when you create the database enables shared throughput. When you create a container, you choose **Autoscale** or **Manual** and enter the RU/s (a maximum for autoscale, a fixed value for manual). You can change the value later from the container's **Scale and Settings** page or the database's **Scale** page.

Raising the RU/s is subject to service quotas. The default maximum is 1,000,000 RU/s per container or shared-throughput database; a higher quota requires a support request. Large increases can require asynchronous scaling that takes minutes to hours.

The minimum you can set rises with the data you store and with the highest rate you ever provisioned. For a container using standard throughput, it's the largest of 400 RU/s, 1 RU/s per GB of storage, or 1% of your highest provisioned rate. For an autoscale container, calculate the largest of 1,000 RU/s, 10 RU/s per GB, or 10% of the highest maximum you ever set, then round up to the next 1,000 RU/s. Shared-throughput databases also have container-count terms for legacy databases allowed to exceed 25 shared containers. Check the resource's reported minimum and the [throughput limits](/azure/cosmos-db/concepts-limits#minimum-throughput-limits) before reducing throughput.

> [!NOTE]
> The RU/s value changes at any time within those limits, but the throughput *scope* is fixed when you create the container. A container with dedicated throughput can't be converted to draw from shared database throughput, and a shared container can't be given dedicated throughput. Changing scope means to create a new container and moving the data, which a container copy job can do for you.

:::image type="content" source="../media/container-creation-scope-model.png" alt-text="Diagram of a container creation form showing database throughput scope and autoscale or manual throughput settings.":::

## Configure throughput programmatically

You set throughput scope and model in code by choosing which resource you provision it on and which `ThroughputProperties` you pass.

::: zone pivot="csharp"

Provision **shared** throughput on the database by passing a throughput value when you create it:

```csharp
Database database = await client.CreateDatabaseIfNotExistsAsync(
    id: "cosmicworks",
    throughputProperties: ThroughputProperties.CreateManualThroughput(400));
```

Provision **dedicated** throughput on the container instead, here using autoscale with a 1,000 RU/s maximum:

```csharp
ContainerProperties properties = new(
    id: "product",
    partitionKeyPath: "/categoryId");

Container container = await database.CreateContainerIfNotExistsAsync(
    containerProperties: properties,
    throughputProperties: ThroughputProperties.CreateAutoscaleThroughput(autoscaleMaxThroughput: 1000));
```

Use `CreateManualThroughput` for standard throughput and `CreateAutoscaleThroughput` for autoscale on whichever resource you provision.

::: zone-end

::: zone pivot="python"

Provision **shared** throughput on the database by passing `offer_throughput` when you create it:

```python
database = client.create_database_if_not_exists(
    id="cosmicworks",
    offer_throughput=400)
```

Provision **dedicated** throughput on the container instead, here using autoscale with a 1,000 RU/s maximum:

```python
from azure.cosmos import PartitionKey, ThroughputProperties

container = database.create_container_if_not_exists(
    id="product",
    partition_key=PartitionKey(path="/categoryId"),
    offer_throughput=ThroughputProperties(auto_scale_max_throughput=1000))
```

Pass an integer to `offer_throughput` for standard throughput, or a `ThroughputProperties` with `auto_scale_max_throughput` for autoscale, on whichever resource you provision.

::: zone-end

You can also script these settings with the Azure CLI. For example, `az cosmosdb sql container create` with `--throughput` for standard or `--max-throughput` for autoscale.

> [!div class="alert is-primary"]
> **Try it yourself:** Sketch a database with five containers. One serves a high-traffic product catalog; the other four hold small, rarely accessed reference data. Which containers would you give dedicated throughput, and would shared database throughput be worth its trade-offs for any of them? Tie your answer back to the cost-versus-isolation decision.

After you set throughput, the next decision is consistency: how current the data must be when someone reads it.
