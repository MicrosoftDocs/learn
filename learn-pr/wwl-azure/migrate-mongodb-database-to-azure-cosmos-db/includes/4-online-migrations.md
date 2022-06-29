Not every migration will have the luxury of allowing much downtime. For those migrations that require minimal downtime, you will need to do an online migration.  Azure Cosmos DB API for MongoDB has two options to perform online migrations, Azure Data Migration Service (DMS) or MongoDB Spark on Azure Databricks.

[![Diagram showing the MongoDB online migration options](../media/4-online-migration.png)](../media/4-online-migration.png#lightbox)


Each of those options have some considerations

| Migration type | Solution | Considerations |
| :--- | :---: | :--- |
| Online | Azure Database Migration Service	| - Makes use of the Azure Cosmos DB bulk executor library <br> - Suitable for large datasets and takes care of replicating live changes <br> -  Works only with other MongoDB sources |