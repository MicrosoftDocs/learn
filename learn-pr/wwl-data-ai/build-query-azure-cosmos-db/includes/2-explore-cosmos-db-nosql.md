Azure Cosmos DB for NoSQL organizes data through a hierarchy of resources that developers must understand to design efficient data architectures. The decisions you make when creating databases and containers directly impact query performance and cost optimization throughout your application's lifecycle. Partition key selection and throughput configuration are among the most important choices. AI applications benefit from understanding these foundational concepts because they determine how data distributes across infrastructure and how efficiently queries execute.

## Understand the resource hierarchy

Azure Cosmos DB uses a hierarchical structure to organize and manage data. The structure flows from accounts at the top level down through databases, containers, and finally to individual items. Each level in the hierarchy serves a distinct purpose and offers configuration options that affect how your AI application stores and accesses data.

An Azure Cosmos DB account serves as the top-level management unit and provides a unique DNS endpoint for all SDK and API connections. The endpoint follows the pattern `https://<account-name>.documents.azure.com:443/`. You configure account-level settings such as default consistency level, geo-replication regions, and network access policies. Each Azure subscription can contain multiple Cosmos DB accounts, allowing teams to separate production, staging, and development environments.

Databases act as logical namespaces that group related containers together. By default, an Azure Cosmos DB account can contain up to 500 databases and containers combined. AI applications typically organize containers by functional area. They separate user data, product catalogs, and inference results into different containers within the same database. Databases also provide the scope for shared throughput allocation, which can reduce costs when you have multiple containers with variable usage patterns.

Containers represent the fundamental unit of scalability and hold your JSON documents. Each container requires a partition key definition that determines how data distributes across physical partitions. Containers are schema-agnostic, meaning items within the same container can have different structures. This flexibility suits AI applications that store polymorphic data such as different event types or varying document formats.

## Configure partition keys for optimal distribution

The partition key is the most critical design decision when creating a container. Azure Cosmos DB uses the partition key value to route operations to the correct physical partition and distribute data evenly across your infrastructure. A well-chosen partition key enables efficient queries, balanced storage, and optimal throughput utilization.

Partition keys must be a property that exists in every document and has high cardinality—many distinct values across your dataset. For AI applications storing user-specific data, `userId` often serves as an effective partition key because each user's data groups together while spreading the overall dataset across many partitions. For product catalogs, `categoryId` might provide good distribution if categories contain similar numbers of items.

Avoid partition keys with low cardinality or skewed distributions. A partition key with only a few possible values creates "hot partitions" that receive disproportionate traffic and storage. For example, using a boolean `isActive` property results in only two partitions, limiting scalability and potentially causing throttling. Similarly, time-based keys like dates can create hot partitions during high-activity periods.

The following example shows how to create a container with a partition key configured for product data:

```python
from azure.cosmos import CosmosClient, PartitionKey

# Code fragment - focus on container creation with partition key
database = client.get_database_client("productcatalog")

container = database.create_container_if_not_exists(
    id="products",
    partition_key=PartitionKey(path="/categoryId"),
    offer_throughput=400
)
```

The `path` parameter specifies the JSON property path that serves as the partition key. You can use nested properties with paths like `/metadata/region`. Once created, you can't change a container's partition key without creating a new container and migrating data.

## Configure throughput for your workload

Azure Cosmos DB measures capacity in request units per second (RU/s), which represents the throughput available for database operations. Every operation consumes RUs based on complexity, size, and consistency level. This includes reads, writes, queries, and stored procedure executions. Understanding throughput configuration helps you balance performance requirements with cost optimization.

You can provision throughput at two levels: the database level or the container level. Database-level throughput shares capacity across all containers within that database, which works well when containers have variable usage patterns. Container-level throughput dedicates capacity to a specific container, ensuring predictable performance for critical workloads.

Azure Cosmos DB offers two throughput modes. Manual throughput provisions a fixed number of RU/s that you specify. Autoscale throughput scales between a minimum (10 percent of the configured maximum) and the maximum RU/s based on demand. For AI applications with unpredictable inference traffic, autoscale helps handle usage spikes without manual intervention while reducing costs during quiet periods.

The minimum throughput depends on the throughput model and the resource scope. With manual throughput, a container with dedicated throughput has a minimum of 400 RU/s. A database with shared throughput also has a minimum of 400 RU/s and can share that throughput across up to 25 containers. With autoscale, you configure a maximum RU/s and the service scales between 10 percent and one hundred percent of that maximum. The minimum autoscale maximum is 1,000 RU/s for a container or a shared-throughput database.

## Work with items and system properties

Items are the individual JSON documents stored within containers. Each item contains user-defined properties that represent your application data, plus system-generated properties that Azure Cosmos DB manages automatically. Understanding these properties helps you work effectively with documents and implement features like optimistic concurrency control.

Every item requires an `id` property within its logical partition. The combination of `id` and partition key value uniquely identifies an item across the entire container. You must provide an `id` value when creating an item because the SDK doesn't generate one automatically. For AI applications, meaningful IDs like `user-12345` or `product-abc` simplify debugging and make point reads more intuitive.

Azure Cosmos DB adds several system properties to each item:

- **`_rid`:** A system-generated resource identifier used internally for navigation and enumeration
- **`_self`:** A unique URI for addressing the resource directly
- **`_etag`:** An entity tag used for optimistic concurrency control, updated whenever the item changes
- **`_ts`:** A Unix timestamp representing the last modification time in seconds
- **`_attachments`:** A path for any attachments associated with the item (legacy feature)

The `_etag` property enables optimistic concurrency patterns. When updating an item, you can include the `_etag` value in a condition. If the item changed since you read it, the update fails with a conflict error, preventing lost updates when multiple processes modify the same document. This pattern is valuable for AI applications that cache model outputs and need to ensure consistent updates.

## Understand request units and cost optimization

Request units (RUs) provide a unified cost model that abstracts CPU, memory, and IOPS consumption into a single metric. Every operation against Azure Cosmos DB returns the RU charge in the response headers, allowing you to monitor and optimize your application's resource consumption. For AI applications with high throughput requirements, understanding RU costs helps control expenses while maintaining performance.

Different operations consume different amounts of RUs. Point reads (retrieving a single 1-KB item by `id` and partition key) typically cost around one RU. Writing a 1-KB item costs approximately 5-10 RUs depending on consistency level and indexing overhead. Queries vary widely based on complexity—a simple filtered query might cost 3-5 RUs while an aggregate query scanning thousands of items could consume hundreds of RUs.

Several factors influence RU consumption:

- **Item size:** Larger documents cost more to read and write
- **Indexing policy:** More indexed properties increase write costs but can reduce query costs
- **Consistency level:** Stronger consistency levels (bounded staleness, strong) consume more RUs
- **Query complexity:** More filters, sorts, and aggregations increase query cost
- **Cross-partition queries:** Queries that span multiple partitions cost more than single-partition queries

Monitor RU consumption by examining response headers from SDK operations. The `x-ms-request-charge` header contains the RU cost for each operation. Aggregate these metrics to understand your application's throughput patterns and identify expensive operations that might benefit from optimization. Azure Monitor and Cosmos DB insights provide dashboards for tracking RU consumption over time.

## Additional resources

- [Azure Cosmos DB resource model](/azure/cosmos-db/resource-model)
- [Partitioning and horizontal scaling in Azure Cosmos DB](/azure/cosmos-db/partitioning-overview)
- [Provision throughput on containers and databases](/azure/cosmos-db/set-throughput)
