Now that we know the basics of Azure Cosmos DB, let's see what resources and information is required to start working with an account. This information should help you decide whether Azure Cosmos DB will work for your data set and how much, if any, extra configuration is necessary.

## What are the components of Azure Cosmos DB?

To begin using Azure Cosmos DB, you will need to create various resources in Azure such as accounts, databases, containers, and items.

:::image type="content" source="../media/3-resource-hierarchy.svg" alt-text="Hierarchial diagram illustrating how an Azure Cosmos DB account is the parent resource to a database, which is itself a parent resource to a container" border="false":::

### Accounts

**Accounts** are the fundamental units of global distribution and high availability. At the account level, you can configure Azure Cosmos DB to globally distribute your data across multiple regions. You can add or remove a region from your account at any time. In addition, you can configure an account to support either single-region or [multi-region writes](/azure/cosmos-db/how-to-multi-master).

Accounts contain the globally unique DNS name used for API requests. You can manage or create accounts using the Azure portal, Azure Resource Manager templates, the Azure CLI, or Azure PowerShell.

## Databases

Each account can contain one or more **Databases**. A database is a logical unit of management for containers in Azure Cosmos DB.

## Containers

**Containers** are the fundamental unit of scalability in Azure Cosmos DB. With Azure Cosmos DB, you provision throughput at the container level. Azure Cosmos DB will automatically and transparently partition the data in a container along with replicating the data across multiple regions.

### Items

The SQL API for Azure Cosmos DB stores individual documents in JSON format as *items* within the container. Azure Cosmos DB natively supports JSON files and can provide fast and predictable performance because write operations on JSON documents are atomic.

:::image type="content" source="../media/3-item-hierarchy.svg" alt-text="Diagram showing the various types of items that can be stored in a container such as stored procedures, user-defined functions, triggers, documents (items), merge procedures, and conflicts" border="false":::

## Partitioning

> [!Warning]
> TODO: Embed RedTiger video here

### Partition Keys

Every Azure Cosmos DB SQL API container is required to specify a **partition key path**. Behind the scenes, Azure Cosmos DB uses this path to logically partition data using **partition key values**. For example, consider the following JSON document:

:::code language="json" source="../samples/3-document.json" range="1-6" highlight="5":::

If your container specifies a partition key **path** of ``/department``, then the partition key **value** of this document would be ``information-technology``. All documents with the same partition key value are logically partitioned together. Behind the scenes, Azure Cosmos DB automatically manages the physical partitions required to support your data workload while maintaining provisioned throughput and availability.

> [!IMPORTANT]
> Selecting a partition key path for a container can be one of the most important design decisions for a new workload. Review the [choosing a partition key](/azure/cosmos-db/partitioning-overview#choose-partitionkey) documentation for a deeper technical explanation and best practices.
