To create an Azure AI Search solution, you need to create an **Azure AI Search** resource in your Azure subscription. Depending on the specific solution you intend to build, you may also need Azure resources for data storage and other application services.

## Service tiers and capacity management

When you create an Azure AI Search resource, you specify a *pricing tier*. The pricing tier you select determines the capacity limitations of your search service and the configuration options available to you, as well as the cost of the service. The available pricing tiers are:

- **Free (F)**. Use this tier to explore the service or try the tutorials in the product documentation.
- **Basic (B)**: Use this tier for small-scale search solutions that include a maximum of 15 indexes and 5 GB of index data.
- **Standard (S)**: Use this tier for enterprise-scale solutions. There are multiple variants of this tier, including **S1**, **S2**, **S3** and **S3HD**; which offer increasing capacity in terms of indexes and storage, and **S3HD**, which is optimized for fast read performance on smaller numbers of indexes.
- **Storage Optimized (L)**: Use a storage optimized tier (**L1** or **L2**) when you need to create large indexes, at the cost of higher query latency.

> [!NOTE]
> The Azure portal supports changes between pricing tiers. You can upgrade or downgrade tiers within the limits of the target tier. You can refer to docs on how to [change your pricing tier](/azure/search/search-capacity-planning?azure-portal=true).

### Replicas and partitions

Depending on the pricing tier you select, you can optimize your solution for scalability and availability by creating *replicas* and *partitions*.

- *Replicas* are instances of the search service - you can think of them as nodes in a cluster. Increasing the number of replicas can help ensure there is sufficient capacity to service multiple concurrent query requests while managing ongoing indexing operations.

- *Partitions* are used to divide an index into multiple storage locations, enabling you to split I/O operations such as querying or rebuilding an index.

The combination of replicas and partitions you configure determines the *search units* used by your solution. Put simply, the number of search units is the number of replicas multiplied by the number of partitions (R x P = SU). For example, a resource with four replicas and three partitions is using 12 search units.

> [!TIP]
> You can learn more about pricing tiers and capacity management in the [Azure AI Search documentation](/azure/search/search-sku-tier).
