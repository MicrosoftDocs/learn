Azure Database for PostgreSQL is a fully managed database service for PostgreSQL workloads on Azure. Understanding the service architecture, compute tiers, and managed capabilities helps you make informed decisions about configuration and capacity planning for your AI applications.

## What is Azure Database for PostgreSQL?

Azure Database for PostgreSQL is a fully managed relational database service based on the open-source PostgreSQL database engine. The service runs the community edition of PostgreSQL, providing full compatibility with existing PostgreSQL applications and tools. Microsoft manages the underlying infrastructure, including hardware provisioning, software patching, backup management, and high availability configuration.

The service provides granular control over database configuration while maintaining the benefits of a managed platform. You can customize maintenance windows, configure high availability options, and adjust compute resources to match your workload requirements.

For AI applications that need relational data storage alongside vector operations, PostgreSQL offers a compelling combination of transactional reliability, flexible data modeling with JSONB, and an extension ecosystem that includes vector similarity search capabilities.

## Architecture and deployment options

Azure Database for PostgreSQL separates compute and storage into independent components. The database engine runs on a Linux virtual machine, while data files reside on Azure managed storage. This separation enables independent scaling of compute and storage resources and provides built-in data durability through locally redundant storage replicas.

The service offers three compute tiers to match different workload characteristics. Each provides different CPU and memory configurations:

- **Burstable:** Provides baseline CPU performance with the ability to burst above the baseline when needed. Best suited for development environments, small applications, and workloads that don't need continuous full CPU capacity. The B-series virtual machines offer a cost-effective option for intermittent workloads.

- **General Purpose:** Delivers balanced compute and memory resources for production workloads. The D-series virtual machines provide consistent performance for applications requiring predictable response times. Choose General Purpose for typical web applications and backend services.

- **Memory Optimized:** Offers high memory-to-vCPU ratios for workloads that benefit from large in-memory datasets. The E-series virtual machines excel at caching-heavy workloads, complex analytical queries, and applications that need to keep large working sets in memory. AI applications performing in-memory computations often benefit from this tier.

You can change compute tiers after deployment with a brief restart, allowing you to adjust resources as your workload evolves.

## Managed service capabilities

Azure Database for PostgreSQL handles operational tasks that would otherwise require dedicated database administration effort.

The service automatically creates backups of your database and stores them on zone-redundant storage in regions that support availability zones, or locally redundant storage in regions that don't. Default backup retention is seven days, which you can extend up to 35 days based on your recovery requirements. Backups include both full snapshots and transaction logs, enabling point-in-time restore to any second within the retention period. Azure encrypts all backups using AES 256-bit encryption, with platform-managed keys by default or customer-managed keys for additional control.

Point-in-time restore lets you recover your database to any moment within the backup retention period. The restore operation creates a new server instance with data recovered to the specified timestamp, which is useful for recovering from accidental data modifications or testing against a historical database state.

Azure Database for PostgreSQL includes built-in PgBouncer, a lightweight connection pooler that reduces the overhead of establishing new database connections by maintaining a pool of reusable connections. You can enable PgBouncer through server configuration and connect on port 6432 instead of the standard PostgreSQL port 5432. Connection pooling is valuable for AI applications that make many short-lived database calls, such as storing individual messages or retrieving context for each inference request.

> [!IMPORTANT]
> PgBouncer is only available on General Purpose and Memory Optimized compute tiers. The Burstable tier doesn't support the built-in PgBouncer feature.

Connection optimization strategies are covered in depth in the "Optimize performance, indexing, and scaling" module.

## Supported PostgreSQL versions and extensions

Azure Database for PostgreSQL supports multiple major PostgreSQL versions concurrently. The service typically supports the current major version and several previous versions, following PostgreSQL's community support timeline. You can check available versions when creating a new server or query the `server_version` setting on an existing server.

PostgreSQL's extension mechanism allows you to add functionality beyond the core database engine. Extensions can add new data types, functions, operators, and index types without modifying the core PostgreSQL code. Several extensions are relevant for AI applications:

- **pgvector:** Enables vector data types and similarity search operations. You can store embeddings alongside relational data and perform approximate nearest neighbor searches. The "Implement vector search with Azure PostgreSQL" module covers pgvector in detail.

- **pg_trgm:** Provides trigram-based text similarity functions. Useful for fuzzy text matching, autocomplete features, and finding similar strings without exact matches.

- **hstore:** Adds a key-value data type for storing sets of key-value pairs within a single PostgreSQL value. Useful for semi-structured data that doesn't require the full flexibility of JSONB.

You can enable extensions using the `CREATE EXTENSION` command after confirming the extension is available on your server instance.

## Developer decision points

When configuring Azure Database for PostgreSQL for your application, consider these key decisions:

- **Choosing a compute tier:** Select based on your workload's CPU and memory requirements. Start with Burstable for development, testing, and proof-of-concept work where cost optimization matters more than consistent performance. Use General Purpose for production workloads with steady, predictable resource requirements. Choose Memory Optimized when your application benefits from large in-memory caches or performs complex analytical queries. You can monitor CPU and memory utilization after deployment and adjust the tier if needed.

- **Evaluating extensions:** Review available extensions early in your application design. Determine whether your application needs vector similarity search (pgvector), full-text search, or geospatial capabilities (PostGIS). Verify that required extensions are available on Azure Database for PostgreSQL before committing to a design. Plan for extension upgrades as part of your database maintenance strategy.

## Additional resources

- [Azure Database for PostgreSQL documentation](/azure/postgresql/)
- [Service overview](/azure/postgresql/flexible-server/service-overview)
- [Compute and storage options](/azure/postgresql/flexible-server/concepts-compute-storage)
- [High availability concepts](/azure/postgresql/flexible-server/concepts-high-availability)
