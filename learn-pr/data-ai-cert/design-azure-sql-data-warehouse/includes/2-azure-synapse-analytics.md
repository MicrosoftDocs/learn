# What are Azure Synapse Analytics

**Azure Synapse Analytics** provides a unified environment by combining the enterprise data warehouse of SQL, the Big Data analytics capabilities of Spark, and data integration technologies to ease the movement of data between both, and from external data sources. Using Azure Synapse Analytics, you are able to ingest, prepare, manage, and serve data for immediate BI and machine learning needs more easily.

Using SQL Analytics and SQL Pools in Azure Synapse Analytics, you will be able to work with modern data warehouse use cases to create database and tables, load data using PolyBase and query a data warehouse using the Massively Parallel Processing architecture. In fact, you can use any existing code that you have created for Azure SQL Data Warehouse with Azure Synapse Analytics seamlessly.


Azure Synapse Analytics stores the incoming data into relational tables with columnar storage. This format significantly reduces the data storage costs and improves the query performance. Once information is stored in Azure Synapse Analytics, you can run analytics at massive scale. Compared to the traditional database systems, analysis queries on Azure Synapse Analytics finishes in a fraction of the time. Within this, SQL Analytics offers T-SQL for batch, streaming and interactive processing of data


![Azure SQL Data Warehouse architecture](../media/3-sql-dw-architecture.png)

## Data Warehousing with Azure Synapse Analytics

### SQL Pools using Data Warehouse Units

With Azure Synapse Analytics. CPU, memory, and IO are bundled into units of compute scale called SQL pool. It is a normalized measure of compute resources and performance, and the size of SQL pool is determined by Data Warehousing Units (DWU). By changing your service level, you alter the number of DWUs that are allocated to the system, which in turn adjusts the performance, and the cost, of your system.  To pay for higher performance, you can increase the number of data warehouse units. To pay for less performance, reduce data warehouse units. Storage and compute costs are billed separately, so changing data warehouse units does not affect storage costs.

### Benefits of data warehousing with Azure Synapse Analytics

Azure Synapse Analytics is a key component required for creating end-to-end relational big data solutions in the cloud today. It allows data to be ingested from a variety of data sources and leverages a scale-out architecture to distribute computational processing of data across a large cluster of nodes, which can:

- Independently size compute power irrespective of the storage needs.
- Grow or shrink compute power without moving data.
- Pause compute capacity while leaving data intact, so you only pay for storage.
- Resume compute capacity during operational hours.

This is made possible due to the decoupling of computation and storage using the Massively Parallel Processing architecture.

In future releases, Azure Synapse Analytics will be able to provide the following additional services, including:

- Tight integration with **Apache Spark**
- **Data integration** capabilities to make it easier to ingest and process data
- **Azure Synapse Analytics Studio** to provide a unified experience for management

