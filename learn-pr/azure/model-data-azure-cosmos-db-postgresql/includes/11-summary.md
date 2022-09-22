Woodgrove Bank's contactless payment app started in a single, on-premises PostgreSQL database. After going through a successful trial of the app, Woodgrove Bank needed to scale their data to perform efficiently with customers across Europe and the United States. You normalized the trial data model and scaffolded the distributed database to support the growth through multiple steps:

* Identified data usage and storage concerns
* Classified tables as local, reference, or distributed tables
* Created tables in Azure Cosmos DB for PostgreSQL

By switching from a single relational database to a distributed relational database, Woodgrove Bank's app can deliver efficient performance at scale. By keeping the reference data in duplicate with the distributed data, they can take advantage of the relational integrity while reaping the benefits of parallel processing of the query across multiple nodes. The Woodgrove Bank app is set up for growth with the support of Azure Cosmos DB for PostgreSQL.

## References

To learn more information about the topics covered in this module, see:

* [Table types for Azure Cosmos DB for PostgreSQL](https://learn.microsoft.com/azure/postgresql/hyperscale/concepts-nodes#table-types)
* [Classify application workloads in Azure Cosmos DB for PostgreSQL](https://learn.microsoft.com/azure/postgresql/hyperscale/howto-build-scalable-apps-classify)
* [Fundamental concepts for scaling](https://learn.microsoft.com/azure/postgresql/hyperscale/howto-build-scalable-apps-concepts#distribution-column-also-known-as-shard-key)
* [Timeseries partitioning](https://learn.microsoft.com/azure/postgresql/hyperscale/reference-overview#timeseries-partitioning)
