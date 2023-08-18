[Azure Cosmos DB for PostgreSQL](/azure/postgresql/hyperscale/overview) is a fully managed database-as-a-service hosted on Azure that delivers the full functionality of PostgreSQL combined with the ability to distribute data across multiple servers in a cluster. It's a robust database with a wide range of built-in features. However, sometimes you need more capabilities to solve complex real-world problems.

You can extend the functionality of databases using [PostgreSQL extensions](/azure/postgresql/hyperscale/reference-extensions). PostgreSQL extensions are packages of related SQL objects that function like built-in native features, allowing you to add new capabilities to your database.

In fact, the distributed capabilities of Azure Cosmos DB for PostgreSQL are made possible through the [Citus extension](https://github.com/citusdata/citus). Other examples of extensions are [`pg_cron`](https://github.com/citusdata/pg_cron), a cron-based job scheduler that allows you to schedule PostgreSQL commands directly from the database; and [PostGIS](https://postgis.net/), which adds support for geographic objects, allowing location queries to be run in SQL.

:::image type="complex" source="../media/cosmos-db-postgresql-extensions.svg" alt-text="Diagram showing three of the extensions you'll use in this learning module.":::
   These extensions include Citus, PostGIS, and pg_cron. These extensions are added to Azure Cosmos DB for PostgreSQL and used to extend the functionality of the database.
:::image-end:::

In this module, you'll explore how you can use extensions to improve the productivity of Azure Cosmos DB for PostgreSQL. You'll examine the Citus extension and how it enables data distribution. You'll also investigate other supported extensions and the capabilities they can provide to improve the overall effectiveness of a database.

## Scenario: Scale and extend Azure Cosmos DB for PostgreSQL using extensions

Suppose you work as the tech lead for Woodgrove Bank and have developed, trialed, and deployed a contactless-payment app that works from six feet away. Your app is currently using a single on-premises PostgreSQL server.

Your team has noticed that the current on-premises PostgreSQL server is struggling under the bank's heavy analytical workload after successfully releasing the payment app to customers. To address this issue, you need the ability to scale the database solution for capacity and performance.

Azure Cosmos DB for PostgreSQL allows you to scale your database across multiple PostgreSQL servers, seamlessly distributing and managing your data by using the Citus extension. Transactions are spread across the servers in your cluster, resulting in better transaction times, lower latency, and more room for analytical workloads.

In addition to introducing a more performant and scalable database platform, Woodgrove Bank has also requested the ability to extend the database's capabilities. They're interested in collecting details about the locations for which their payment transactions are occurring and need a way to store geospatial data in the database. They've also asked about being able to run scheduled jobs in the database to handle computing rollups for an analytical dashboard.

Finally, the bank would like to securely store CSV files containing its historical user data in an Azure Storage account. The bank will then perform a bulk load of the data from the files into the database.

With this scenario in mind, the rest of the module is focused on using Azure Cosmos DB for PostgreSQL to accommodate Woodgrove Bank's requests. You'll create an Azure Cosmos DB for PostgreSQL cluster and look at how to install and use PostgreSQL extensions to extend the capabilities of the database.
