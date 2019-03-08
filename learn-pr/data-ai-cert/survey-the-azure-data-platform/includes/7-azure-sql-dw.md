Azure SQL Data Warehouse is an enterprise-class cloud-based enterprise data warehouse designed to process massive amounts of data and answer complex business questions.

## When to Use It

As data loads increase the processing time of on-premises data warehousing solutions, an organization may have to look at a cloud-based alternative to reduce the processing time so that business intelligence reports are made available in a timely manner. Many organizations will look to scale up on-premises servers first, but as the scale out approach reaches its physical limits, it is more pragmatic to use a solution that has Petabyte scale without the complexity of installing and configuring it.

## Key Features

SQL Data Warehouse uses Massive Parallel Processing (MPP) to run queries across petabytes of data quickly.  Since the storage is separated from the compute nodes, the compute nodes can be scaled independently to meet any demand, at any time.  There is a Data Movement Service (DMS) that coordinates and transports data between compute nodes as required; however, a replicated table feature within the product can be used to reduce data movement and therefore improve performance. Furthermore, there are two types of distributed tables supported, Hash and Round-robin, that provide the Data Engineer performance tuning capability. The service also has the important capability of pausing and resuming the compute layer. Meaning that you only pay for the compute that you use. This is very useful in Data Warehousing solutions.

## Ingesting and Processing Data

SQL Data Warehouse uses the Extract, Loads, and Transform (ELT) approach.  SQL Professionals will already be familiar with tools such as BCP and the SQL Bulk Copy API, but Data Engineers working with SQL Data Warehouse will learn the power of PolyBase that can load data very quickly. PolyBase is a technology that removes the complexity for Data Engineers to leverage big data ingestion and processing techniques by offloading complex calculations to the cloud.  Developers can use stored procedures, labels, views, and SQL to develop applications to make use of PolyBase. You can also use Azure Data Factory to perform the ingestion and processing of data.

## Querying Data

Data Engineers can use the familiar Transact-SQL to query the contents of a SQL Data Warehouse, taking advantage of a wide range of features including WHERE, ORDER BY and GROUP BY clauses when querying the data. There are additional Transact SQL constructs that may be new, such as CREATE TABLE …. AS SELECT …. that is used with PolyBase to perform the fast loading of data.

## Securing Data

SQL Data Warehouse supports both SQL Server authentication as well as Azure Active Directory.  For higher security environments, the Data Engineer can configure multi-factor authentication.  From a data perspective, SQL Data Warehouse supports both column-level and row-level security.