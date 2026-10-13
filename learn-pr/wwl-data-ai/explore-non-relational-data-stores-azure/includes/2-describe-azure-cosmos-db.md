::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=b9f3e01c-056b-4c50-86e0-35b10d43ae01]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

In the previous unit, you learned that Azure Cosmos DB is a highly scalable cloud database service for NoSQL data. In this unit, you explore what makes it different from traditional relational databases, how it organizes data internally, and when it's the right choice for your application.

## What is Azure Cosmos DB?

**Azure Cosmos DB** is a fully managed NoSQL database service on Azure—a platform-as-a-service (PaaS) offering. Microsoft handles all of the underlying infrastructure: server provisioning, patching, updates, and backups. You focus on your application logic while Cosmos DB handles the operational overhead.

Cosmos DB is **schema-agnostic**. Items stored in the same container don't need to share the same structure. One item might have five properties; another in the same container could have 15 entirely different ones. This flexibility makes Cosmos DB well suited to applications where data shapes change over time or vary between records.

## How Azure Cosmos DB organizes data

Cosmos DB uses a four-level resource hierarchy to organize your data:

- **Account**: The top-level Azure resource. A single account can manage an unlimited amount of data and provisioned throughput.
- **Database**: A logical namespace that groups related containers together.
- **Container**: The primary unit of storage and scaling. You configure the partition key, throughput, indexing policy, and an optional time-to-live (TTL) at the container level.
- **Items**: Individual data entities stored inside a container. Depending on which API you use, items may be called documents, rows, nodes, or edges.

The **partition key** is a property you choose to distribute data across logical partitions. Each logical partition can hold up to 20 GB of data. A well-chosen partition key—one with many distinct values and an even spread of data across those values—is important for keeping throughput balanced as the database grows.

![Diagram explaining how Azure Cosmos DB organizes data.](../media/cosmos-db-hierarchy.png)

Cosmos DB automatically creates and maintains indexes on all item properties by default. You don't need to define a schema upfront or manage indexes manually; the service handles both.

## Global distribution and performance

Cosmos DB is built for global distribution. Add Azure regions to your account at any time, and the service automatically replicates your data to each one. Users in different locations read from the nearest regional replica, and with multi-region writes enabled, they also write to the nearest region, which keeps latency low no matter where they are.

Accounts with multi-region writes have a 99.999% availability SLA. Reads and writes are guaranteed to complete in less than 10 milliseconds at the 99th percentile. Average latency (at the 50th percentile) is typically 4 milliseconds or less for reads and 5 milliseconds or less for writes.

Because replicas exist in multiple regions, you need to decide how consistent those replicas must be with each other. Cosmos DB offers five **consistency levels** so you can tune that trade-off:

| Consistency level     | Description                                                                                   |
| --------------------- | --------------------------------------------------------------------------------------------- |
| **Strong**            | Every read reflects the most recent write.                                                    |
| **Bounded staleness** | Reads lag behind writes by a configurable interval (time or version count).                   |
| **Session**           | Consistency is guaranteed within a single client session. This is the most widely used level. |
| **Consistent prefix** | Reads never see out-of-order writes but may see stale data.                                   |
| **Eventual**          | Replicas converge over time; the weakest guarantee but the highest availability.              |

Session consistency is the most widely used level for both single-region and globally distributed applications.

![Diagram explaining global distribution and performance.](../media/cosmos-db-global-consistency.png)

## Throughput modes and pricing

Cosmos DB measures capacity in **Request Units per second (RU/s)**. One request unit (RU) is roughly the cost of reading a single 1-KB item by its ID and partition key. Every operation—reads, writes, queries, and deletes—consumes some number of RUs, giving you a single metric to reason about both performance and cost.

You can configure throughput in the following ways:

| Throughput option | Description                                                                                                    |
| ----------------- | -------------------------------------------------------------------------------------------------------------- |
| **Dedicated**     | Provisioned throughput is reserved exclusively for a single container.                                         |
| **Shared**        | Provisioned throughput is set at the database level and shared across up to 25 containers.                     |
| **Serverless**    | No throughput to provision upfront; you pay for the RUs your requests consume. Best for workloads with intermittent, unpredictable traffic. |

> [!NOTE]
> Serverless accounts are limited to a single Azure region. If your application requires global distribution across multiple regions, use a provisioned throughput account instead.

The **autoscale** option lets you set a maximum RU/s, and Cosmos DB adjusts capacity automatically within that range based on actual demand.

## When to use Cosmos DB

Cosmos DB is a strong fit for applications that need flexible schema, global reach, and consistent low latency:

- **IoT and telemetry**: Fast ingestion of high-frequency device data, available for near-real-time processing.
- **Gaming**: Player profiles, leaderboards, and in-game stats that require low-latency reads and writes.
- **Retail and e-commerce**: Product catalogs, shopping carts, and order pipelines at any scale.
- **Web and mobile apps**: Personalized user experiences, social features, and third-party integrations.

Some workloads aren't a good fit. If your application depends on complex multi-table joins, Azure SQL Database is better suited. For large-scale analytical workloads, consider Microsoft Fabric instead.

In the next unit, you look at the different APIs Cosmos DB supports and how each one lets you work with your data using familiar tools and query languages.

::: zone-end
