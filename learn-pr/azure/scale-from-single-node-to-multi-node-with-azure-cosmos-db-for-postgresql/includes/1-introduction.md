Azure Cosmos DB for PostgreSQL can be used for all sizes of data, small and large. It can be used when starting a PostgreSQL project, offering the resources of 64 vCores, 256GB RAM, and 2TB storage. Azure Cosmos DB for PostgreSQL is powered by [Citus](https://github.com/citusdata/citus), which enables data storage and query processing to be distributed over multiple instances of Postgres. Whether your situation outgrows the single-node resources or query performance slows because of data growth, Azure Cosmos DB for PostgreSQL can scale when you are ready to grow.

## Scenario: Scaling sensors data

Wide World Importers is a wholesale novelty goods importer and distributor operating from the San Francisco bay area. They have sensors throughout their warehouses and delivery trucks to monitor environmental conditions to ensure that their goods are in optimal storage environments. They need to make sure things like chilly chocolates are kept chilled and not converted to melted chocolates. They initially started tracking their sensors in an Azure Cosmos DB for PostgreSQL single-node environment.

As a consultant for Wide World Importers, you are helping them with the latest demands of their environment - preparing their data for upcoming growth. As their customers purchase more and require more deliveries, Wide World Importers is planning to expand their warehouses and fleet of delivery trucks not just in the San Francisco bay area but throughout the world. As these sensors are a newer project, the Wide World Importers developers started with a single-node Azure Cosmos DB for PostgreSQL cluster. However, with their needs changing, you'll help them expand their environment to a multi-node environment.

In this module, you'll look at cases for distributing data. You'll see how the architecture changes from a non-distributed design to a distributed design. Once you are aware of those architecture changes, you'll update your design for distribution. Finally, you'll distribute your data.

By the end of this module, you'll be able to go from a small non-distributed database to a distributed database.
