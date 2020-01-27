The first task before migration is to verify that you are migrating from a supported version of MongoDB. You can verify the latest version support at the following site:

[Azure Cosmos DB's API for MongoDB: supported features and syntax](https://aka.ms/AA56wz6)

You need to create a Cosmos DB account with MongoDB as the API. You then need to create a database in Cosmos DB for each database that you will create.

You need to create an Azure Virtual Network (VNet) for the Azure Database Migration Service that should use the Azure Resource Manager deployment model. You must configure your VNET Network Security Group to open ports 53, 443, 445, 9354, and 10000-20000. You must configure your on-premises firewalls to allow access to your MongoDB server.

You should now configure throughput. Typically, a migration involves a large amount of data transfer and you can temporarily increase throughput for the duration of the migration. If you specify database-level throughput, you should consider that each collection requires at least 100 RU/Sec. Therefore, the minimum RU/Sec for the database is the number of collections multiplied by 100. Database-level throughput often seems more appropriate than collection-level throughput for migration scenarios, but you should consider that this setting cannot be modified after creation and, therefore, you should choose the most appropriate setting for the expected use of the database.

## Offline or online migration

In an offline migration, you stop connections to the database, perform the migration, and then establish connections to the new migrated database. It is imported to prevent connections during migration, because these transactions will be lost.

An online migration applies any transactions that occur during migration to the new migrated database. No transactions are lost.

An offline migration is faster, but an online migration has less downtime. Downtime begins when the migration starts for offline, but downtime only starts at the end of migration when the cutover to the new database occurs for online. You should run a test offline migration on a copy of the live system to investigate whether the downtime is acceptable. It might be possible to run the migration at a time when activity is typically low. If the downtime for offline migration is not acceptable, then choose online migration.

For more information on online migrations, see [Migrate MongoDB to Azure Cosmos DB Mongo API online](https://aka.ms/AA56f96)

For more information on offline migrations, see [Migrate MongoDB to Azure Cosmos DB Mongo API offline](https://aka.ms/AA56f98)
