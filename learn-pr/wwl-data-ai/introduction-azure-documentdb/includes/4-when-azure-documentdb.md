Choosing the right database service depends on your workload characteristics, team expertise, and operational requirements. Azure DocumentDB is well-suited for specific scenarios, and understanding these scenarios helps you make an informed decision.

## Ideal workloads

Azure DocumentDB is optimized for the following types of applications:

- **Transactional and operational workloads**: Applications that perform frequent reads and writes on document data, such as order processing, inventory management, and user session tracking.
- **Web and mobile backends**: High-scale applications that need flexible schemas and low-latency data access. Product catalogs, content management systems, and social platforms are common examples.
- **Real-time analytics**: Workloads that combine operational data processing with analytical queries, such as dashboards and reporting systems that query live data.
- **Generative AI applications**: Applications that use vector search for retrieval-augmented generation (RAG), semantic search, or recommendation engines. The integrated vector database eliminates the need for a separate vector store.

## Migration scenarios

Azure DocumentDB is a natural target when you're migrating from an existing MongoDB deployment. Common migration sources include:

- **Self-managed MongoDB** on virtual machines or on-premises servers
- **MongoDB Atlas** cloud-hosted clusters
- **AWS DocumentDB** instances

Because Azure DocumentDB supports the MongoDB wire protocol, your application code, drivers, and queries continue to work with minimal changes. Migration tools include the Azure DocumentDB Migration Extension for Visual Studio Code, a web-based migration utility for online and offline migrations, and native MongoDB tools like `mongodump` and `mongorestore`.

> [!TIP]
> Before migrating, run a premigration assessment using the Azure DocumentDB Migration Extension. The assessment identifies unsupported features, compatibility gaps, and potential issues before you move data.

## When Azure DocumentDB is a good fit

Consider Azure DocumentDB when your scenario matches several of these criteria:

- Your application uses or plans to use the MongoDB query language and ecosystem tools.
- You need a fully managed database service that handles patching, backups, and high availability.
- Your data model benefits from flexible, schema-agnostic document storage.
- You want predictable, vCore-based pricing rather than consumption-based billing for database operations.
- Your team has existing MongoDB expertise and wants to preserve that investment.
- You need integrated vector search for AI features without maintaining a separate system.
- Your compliance or licensing requirements favor an open-source, MIT-licensed database engine.

## Factors to evaluate

When comparing Azure DocumentDB with other database options, consider these factors:

- **Pricing model**: Azure DocumentDB uses vCore-based pricing with independent compute and storage scaling. Compare vCore-based pricing with Request Unit (RU) based pricing in Azure Cosmos DB for MongoDB or per-instance pricing in other managed MongoDB services.
- **Scaling approach**: Azure DocumentDB supports both vertical and horizontal scaling, with no shard key required until the database reaches terabytes. Evaluate whether your workload benefits more from this approach or from automatic horizontal partitioning in other services.
- **Global distribution**: If your application requires multi-region writes with automatic conflict resolution over the MongoDB protocol, evaluate whether Azure Cosmos DB for MongoDB (RU-based) or another service better fits that need. Azure DocumentDB supports multicloud replication, but its distribution model differs from RU-based Cosmos DB.
- **Feature compatibility**: Review the [Azure DocumentDB feature compatibility documentation](/azure/documentdb/compatibility-features) to confirm that your specific MongoDB features, aggregation stages, and administrative commands are supported.

## Example scenario

Consider how Azure DocumentDB applies to the retail company scenario from the introduction. The company runs a product catalog and order-processing system on self-managed MongoDB. Here's how Azure DocumentDB addresses their needs:

- Their existing MongoDB drivers and queries work because of over 99% MongoDB Query Language (MQL) compatibility.
- The operations team no longer manages server patching, replica sets, or backup schedules because the service is fully managed.
- They start with an M40 tier for their current workload and can scale up to M60 or add shards as the catalog grows.
- When they later add a product recommendation feature using AI embeddings, they store vectors in the same database without provisioning a separate vector store.
- Network security uses Azure Private Link, and authentication moves to Microsoft Entra ID for centralized access control.

Azure DocumentDB combines MongoDB compatibility, managed operations, integrated AI, and flexible scaling. Azure DocumentDB is a great choice for teams that want to reduce operational complexity while preserving their MongoDB investment.
