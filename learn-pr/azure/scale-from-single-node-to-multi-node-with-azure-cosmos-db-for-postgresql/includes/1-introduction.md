You can use Azure Cosmos DB for PostgreSQL for all sizes of data, small and large. You can use it when you first start a PostgreSQL project, with the single-node resources of 64 vCores, 256 GB of RAM, and 2 TB of storage. Azure Cosmos DB for PostgreSQL is powered by [Citus](https://github.com/citusdata/citus). You can use Citus to distribute data storage and query processing over multiple instances of PostgreSQL. If your data scenario outgrows single-node resources or query performance slows because of an increase in data, Azure Cosmos DB for PostgreSQL can scale when you're ready to grow.

## Scenario: Scale sensors data

Wide World Importers is a wholesale novelty goods importer and distributor that operates from the San Francisco Bay area. The company uses sensors throughout its warehouses and delivery trucks to monitor environmental conditions for optimal storage for its products. The company needs to make sure that products like its chilly chocolates are kept chilled so that they don't become melted chocolates. Wide World Importers initially started to track its sensors in an Azure Cosmos DB for PostgreSQL single-node environment.

As a consultant for Wide World Importers, you're helping the technical team address the latest demands on the company's operating environment. As customers purchase more products and require more deliveries, Wide World Importers is planning to expand its warehouses and fleet of delivery trucks. It plans to expand not only in the San Francisco Bay area, but throughout the world. The company must prepare its data for upcoming growth in sales.

Because using sensors to ensure that products are stored in optimal conditions is a newer project for Wide World Importers, the developer team started with a single-node Azure Cosmos DB for PostgreSQL cluster. With the company's growth and its technical needs changing, you can help developers expand the environment to a multi-node environment.

In this module, you look at cases for distributing data. You see how the architecture changes from a nondistributed design to a distributed design. When you're aware of those architecture changes, you update your design for distribution. Finally, you distribute your data.

By the end of this module, you'll be able to go from a small, nondistributed database to a distributed database.
