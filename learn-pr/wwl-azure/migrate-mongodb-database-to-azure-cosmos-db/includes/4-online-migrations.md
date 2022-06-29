Not every migration will have the luxury of allowing much downtime. For those migrations that require minimal downtime, you will need to do an online migration.  Azure Cosmos DB API for MongoDB has two options to perform online migrations, Azure Data Migration Service (DMS) or MongoDB Spark on Azure Databricks.

We can perform online MongoDB to Azure Cosmos DB migrations for MongoDB on-premise clusters, MongoDB on IaaS VM clusters and MongoDB Atlas clusters. If the data size is smaller than 1 TB, we should perform this migration using Azure DMS. If the data size is larger than 1 TB, we should perform this migration using MongoDB Spark on Databricks + MongoDB Change stream.

[![Diagram showing the MongoDB online migration options](../media/4-online-migration.png)](../media/4-online-migration.png#lightbox)

We need to point out some considerations for each of these migration options.

| Migration type | Solution | Considerations |
| :--- | :---: | :--- |
| Online | Azure Database Migration Service	| • Makes use of the Azure Cosmos DB bulk executor library </br>• Suitable for large datasets and takes care of replicating live changes </br>•  Works only with other MongoDB sources |
| Online | Azure Databricks and Spark | • Full control of migration rate and data transformation </br> • Requires custom coding |

> [!NOTE]
> For further information on Azure DMS online migrations, see the *[Tutorial: Migrate MongoDB to Azure Cosmos DB's API for MongoDB online using DMS][/azure/dms/tutorial-mongodb-cosmos-db-online]* tutorial. For further information on Azure Databricks online migrations, see the *[Migrate data from MongoDB to an Azure Cosmos DB API for MongoDB account by using Azure Databricks][/azure/cosmos-db/mongodb/migrate-databricks]* article.

Now that we looked at online migration options, on the next unit we will introduce offline migration options.

[/azure/dms/tutorial-mongodb-cosmos-db-online]: https://docs.microsoft.com/azure/dms/tutorial-mongodb-cosmos-db-online
[/azure/cosmos-db/mongodb/migrate-databricks]: https://docs.microsoft.com/azure/cosmos-db/mongodb/migrate-databricks