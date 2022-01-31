The project architect has asked you to determine the advantages of moving data from an existing Azure Table Storage data set. The project architect found an existing 10 TB database that one of the project teams uses to store data from a legacy Internet of Things (IoT) application, and the data is seldom updated. Moving your database from Azure Table Storage into Azure Cosmos DB with a low throughput might have considerable cost savings, since Table Storage is charged on the size of data rather than how often it's accessed.

## Problem analysis

The IoT data consists of key-value pairs with no relationship information, and the existing dataset is currently deployed in Azure Table Storage.

## Recommended API: Azure Table

The best practice is to use Core (SQL) for new projects, as it has more features than the Azure Table API. However, to reduce downtime during your migration to Azure Cosmos DB, you might want to consider using the Table API for now, and switch to Core (SQL) in the near future.

## Why not any of the other APIs?

Using the decision matrix from earlier in this learning module, you can see why the other APIs aren't a good solution for this scenario:

| API | Description |
|---|---|
| **Cassandra** | This API isn't a good choice because of the existing Azure Table Storage database, and because of the requirements to import and reuse application code. |
| **Core (SQL)** | This API would be the best choice if you were designing a new system; however, since this scenario consists of a legacy application with a large existing Azure Table Storage dataset, the Azure Table API is the correct choice. |
| **Gremlin** | This API isn't a good choice because this scenario doesn't need to process graph-based data, and because of the requirements to import and reuse application code. |
| **MongoDB** | This API isn't a good choice because of the existing Azure Table Storage database, and because of the requirements to import and reuse application code. |
