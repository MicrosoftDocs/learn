Azure Cosmos DB only bills for storage you directly consume in real time, and you don't have to pre-reserve storage in advance. In high-write scenarios, TTL values can be used to save on data storage costs in Azure Cosmos DB. Data that has already been shipped out to data warehouses or aggregated and stored in other forms or elsewhere can be immediately purged to ensure that you only keep fresh and relevant data in local SSD storage.

Consider solutions such to aggregate and migrate data such as:

- Change feed
- Azure Data Warehouse
- Azure Blob Storage

When designing your solution, game plan how long your data will need to be retained in Azure Cosmos DB before being migrated across your entire Azure solution space to minimize storage costs.
