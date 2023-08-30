Azure Cosmos DB for PostgreSQL transforms PostgreSQL into a highly scalable distributed database by clustering PostgreSQL servers. Distributed databases work by spreading table data across nodes in the cluster, horizontally partitioning rows across worker nodes. By dispersing data across [shards](/azure/postgresql/hyperscale/concepts-nodes#shards) on different worker nodes, they can take advantage of cross-machine parallelism, providing the key performance benefits of Azure Cosmos DB for PostgreSQL.

Working with data in distributed tables is much like operating on non-distributed tables, because you typically don't need to know how or where data is stored in a cluster. However, there are some key differences of which you must be aware to ingest and query data effectively.

The distributed architecture of the database means that all queries are sent to the [coordinator node](/azure/postgresql/hyperscale/concepts-nodes#coordinator-and-workers). The coordinator node relays the queries to the relevant workers and accumulates their results. For queries against distributed tables, the coordinator node either routes it to a single worker or parallelizes it across several, depending on where the requested data resides. Behind the scenes, the query executor on the coordinator creates a separate query fragment for each shard, runs them on all worker nodes containing the requested data, and combines the result.

:::image type="complex" source="../media/query-fragments.svg" alt-text="Diagram of a query the coordinator node rewrites into fragments. ":::
   Diagram of a query that is taken by the coordinator node and rewritten into query fragments, which modify the table name in the original query to add an underscore followed by the shard ID. The query fragments are then sent to the worker nodes for execution.
:::image-end:::

Distributing table data across nodes can provide tremendous performance benefits but, if misconfigured, can also negatively affect query performance. When querying distributing data, you must consider how your table data was distributed and the designated [distribution column](/azure/postgresql/hyperscale/howto-choose-distribution-column). You must also consider [table colocation](/azure/postgresql/hyperscale/concepts-colocation), the relationships between tables, and your most common query patterns.

In this module, you'll explore the key differences in how to efficiently work with distributed table data. You'll also learn how the underlying architecture of a distributed database influences how you ingest and query data.

## Scenario: Ingest and query data efficiently across a multi-node distributed database

In this scenario, imagine that you work as the tech lead for Woodgrove Bank. As the tech lead, you've developed, trialed, and deployed a contactless payment app that works from six feet away. Your app relies on a multi-node Azure Cosmos DB for PostgreSQL database containing several distributed tables.

After successfully releasing the payment app across Europe and the United States, you've now been tasked with optimizing data ingestion and improving query performance for the distributed tables in the database. They would like you to provide mechanisms for ingesting their historical data into the database and loading individual transactions as efficiently as possible. Their historical information has been provided as comma-separated value (CSV) files accessible from an on-premises web server. In addition, they perform heavy analytical workloads against the database, primarily focused on user analytics, and want to ensure their users can do this analysis in the most performant manner.

To accommodate Woodgrove Bank's request, you'll look at data ingestion methods for populating distributed tables in the database. In addition, you'll explore how to query distributed tables in the PostgreSQL database effectively. Most importantly, you'll be provided explanations about what you're doing and why.
