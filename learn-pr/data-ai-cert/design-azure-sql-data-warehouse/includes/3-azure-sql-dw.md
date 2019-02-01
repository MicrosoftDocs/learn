**Azure SQL Data Warehouse** is a cloud-based Enterprise Data Warehouse (EDW) that leverages Massively Parallel Processing (MPP) to run complex queries across petabytes of data quickly. Azure SQL Data Warehouse is the most appropriate solution when you need to keep historical data separate from the source transaction systems for performance reasons. The source data could be coming from other storage mediums such as network shares, Azure Storage Blobs, or a data lake.

Azure SQL Data Warehouse stores the incoming data into relational tables with columnar storage. This format significantly reduces the data storage costs and improves the query performance. Once information is stored in Azure SQL Data Warehouse, you can run analytics at massive scale. Compared to the traditional database systems, analysis queries on Azure SQL Data Warehouse finishes in a fraction of the time.

![Azure SQL Data Warehouse Architecture](../media/3-sql-dw-architecture.png)

Azure SQL Data Warehouse is a key component required for creating end-to-end relational big data solutions in the cloud. It allows data to be ingested from a variety of data sources and leverages a scale-out architecture to distribute computational processing of data across a large cluster of nodes, which can:

- Independently size compute power irrespective of the storage needs.
- Grow or shrink compute power without moving data.
- Pause compute capacity while leaving data intact, so you only pay for storage.
- Resume compute capacity during operational hours.

This is made possible due to the decoupling of computation and storage using the Massively Parallel Processing architecture.
