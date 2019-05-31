The operations team has been using an app that uses an existing MongoDB database to process purchase orders. The database captures data throughout the order process, including failed and partial orders, fulfillment data, and shipping status. MongoDB was chosen because each supplier wanted their orders in different formats. In addition, each supplier returns different meta-data. The volume of these suppliers has increased exponentially as your company has rolled out drop shipping. The operations team wants to keep access to this data, and continue to use their current purchase order system with as few code changes and as little downtime as possible.

## Problem analysis

The operations team has semi-structured data that needs the flexibility to store many different supplier order formats. Based on your research, you have determined that both Core (SQL) and MongoDB are good options. However, your operations team wants to reduce downtime during their app migration, so your best bet would be to find a way to allow your operations team to continue to use the MongoDB wire protocol.

## Recommended API: MongoDB

To allow the operations team to continue to use their existing app that uses MongoDB queries, your best option is to use the MongoDB API. Choosing this API means that MongoDB tools like `mongodump` and `mongorestore` are available to natively move the data into Azure Cosmos DB.

## Why not any of the other APIs?

Using the decision matrix from earlier in this learning module, you can see why the other APIs are not a good solution for this scenario:

| API | Description |
|---|---|
| **Azure Table** | This API isn't a good choice for this scenario, and should only be used to allow existing apps that are based on the Table API access to Azure Cosmos DB. |
| **Cassandra** | This API isn't a good choice due to the existing MongoDB database, and the requirement to import and reuse application code. |
| **Core (SQL)** | This API would be a good choice if there wasn't a requirement to reuse existing code and import an existing MongoDB database. |
| **Gremlin** | This API isn't a good choice because the data isn't graph based. |
