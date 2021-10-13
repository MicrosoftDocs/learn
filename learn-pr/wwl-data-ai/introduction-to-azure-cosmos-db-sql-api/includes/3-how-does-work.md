Now that we know the basics of Azure Cosmos DB, let's see what resources and information is required to start working with an account. This information should help you decide whether Azure Cosmos DB SQL API will work for your data set and how much, if any, extra configuration is necessary.

## What are the components of Azure Cosmos DB SQL API?

To begin using Azure Cosmos DB, you will need to create various resources in Azure such as accounts, databases, containers, and items.

:::image type="content" source="../media/3-resource-hierarchy.svg" alt-text="Diagram showing how an Azure Cosmos DB SQL API account is the parent resource to a database, which is itself a parent resource to a container." border="false":::

### Accounts

**Accounts** are the fundamental units of distribution and high availability. At the account level, you can configure the region\[s\] for your data in Azure Cosmos DB SQL API. Accounts also contain the globally unique DNS name used for API requests. You can also set the default consistency level for requests at the account. You can manage or create accounts using the Azure portal, Azure Resource Manager templates, the Azure CLI, or Azure PowerShell.

### Databases

Each account can contain one or more **Databases**. A database is a logical unit of management for containers in Azure Cosmos DB SQL API.

### Containers

**Containers** are the fundamental unit of scalability in Azure Cosmos DB SQL API. With Azure Cosmos DB, you provision throughput at the container level. You can also optionally configure an indexing policy or a default time-to-live value at the container level. Azure Cosmos DB SQL API will automatically and transparently partition the data in a container.

### Items

The SQL API for Azure Cosmos DB stores individual documents in JSON format as *items* within the container. Azure Cosmos DB SQL API natively supports JSON files and can provide fast and predictable performance because write operations on JSON documents are atomic.

:::image type="content" source="../media/3-item-hierarchy.svg" alt-text="Diagram showing various items stored in a container." border="false":::

## Partitioning & Partition Keys

> [!VIDEO <https://www.microsoft.com/en-us/videoplayer/embed/RE4OAlA>]

Every Azure Cosmos DB SQL API container is required to specify a **partition key path**. Behind the scenes, Azure Cosmos DB SQL API uses this path to logically partition data using **partition key values**. For example, consider the following JSON document:

:::code language="json" source="../media/3-document.json" range="1-29" highlight="5-6,10":::

If your container specifies a partition key **path** of ``/department/name``, then the partition key **value** of this document would be ``information-technology``. Behind the scenes, Azure Cosmos DB SQL API automatically manages the physical resources necessary to support your data workload.

Selecting a partition key path for a container can be one of the most important design decisions for a new workload. Review the [choosing a partition key][azure/cosmos-db/partitioning-overview#choose-partitionkey] documentation for a deeper technical explanation and best practices.

[azure/cosmos-db/partitioning-overview#choose-partitionkey]: /azure/cosmos-db/partitioning-overview#choose-partitionkey