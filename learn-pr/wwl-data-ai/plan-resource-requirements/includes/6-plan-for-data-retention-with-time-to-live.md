Azure Cosmos DB only charges for storage you directly consume in real time, and you don't have to prereserve storage in advance. In high-write scenarios, TTL (Time to Live) values can be used to save on data storage costs in Azure Cosmos DB. Data that already shipped out to data warehouses or aggregated and stored in other forms or elsewhere can be immediately purged. This purge ensures that you only keep fresh and relevant data in local SSD storage.

Consider solutions such to aggregate and migrate data such as:

- Change feed
- Azure Fabric
- Azure Blob Storage

When you are designing your solution, to minimize storage costs, game plan how long your data will need to be retained in Azure Cosmos DB before the data is migrated across your entire Azure solution space.
