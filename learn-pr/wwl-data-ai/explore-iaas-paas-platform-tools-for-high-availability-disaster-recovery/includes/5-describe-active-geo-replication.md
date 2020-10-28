Another method to increase availability for Azure SQL Database is to use active geo-replication. Active geo-replication creates a replica of the database in another region that is asynchronously kept up to date. That replica is also readable, similar to an AG in IaaS. Underneath the surface, Azure is using the same methods as an AG, which is why some of the terminology and functionality is similar(primary and secondary logical servers, read-only databases, etc.).

:::image type="content" source="../media/module-77-high-availability-final-13.png" alt-text="Active Geo-Replication for Azure SQL Database":::

More details can be found in the [official documentation](https://docs.microsoft.com/azure/sql-database/sql-database-active-geo-replication).
