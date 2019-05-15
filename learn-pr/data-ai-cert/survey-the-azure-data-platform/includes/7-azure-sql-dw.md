Azure SQL Data Warehouse is a cloud-based enterprise data warehouse. It can process massive amounts of data and answer complex business questions.

## When to use SQL Data Warehouse

Data loads can increase the processing time for on-premises data warehousing solutions. Organizations that face this issue might look to a cloud-based alternative to reduce processing time and release business intelligence reports faster. But many organizations first consider scaling up on-premises servers. As this approach reaches its physical limits, they look for a solution on a petabyte scale that doesn't involve complex installations and configurations.

## Key features

SQL Data Warehouse uses massively parallel processing (MPP) to quickly run queries across petabytes of data. Because the storage is separated from the compute nodes, you can scale the compute nodes independently to meet any demand at any time.  

In SQL Data Warehouse, Data Movement Service (DMS) coordinates and transports data between compute nodes as necessary. But you can use a replicated table to reduce data movement and improve performance. SQL Data Warehouse supports two types of distributed tables: hash and round-robin. Use these tables to tune performance. 

Importantly, SQL Data Warehouse can also pause and resume the compute layer. This means you pay only for the computation you use. This capability is useful in data warehousing.

## Ingesting and processing data

SQL Data Warehouse uses the extract, load, and transform (ELT) approach for bulk data. SQL professionals are already familiar with bulk-copy tools such as bcp and the SQLBulkCopy API. Data engineers who work with SQL Data Warehouse will soon learn how quickly PolyBase can load data. 

PolyBase is a technology that removes complexity for data engineers. They take advantage of techniques for big-data ingestion and processing by offloading complex calculations to the cloud. Developers use PolyBase to apply stored procedures, labels, views, and SQL to their applications. You can also use Azure Data Factory to ingest and process data.

## Queries

As a data engineer, you can use the familiar Transact-SQL to query the contents of SQL Data Warehouse. This method takes advantage of a wide range of features, including the WHERE, ORDER BY, and GROUP BY clauses. Load data fast by using PolyBase with additional Transact-SQL constructs such as CREATE TABLE and AS SELECT.

## Data security

SQL Data Warehouse supports both SQL Server authentication and Azure Active Directory. For high-security environments, set up multifactor authentication. From a data perspective, SQL Data Warehouse supports security at the level of both columns and rows.