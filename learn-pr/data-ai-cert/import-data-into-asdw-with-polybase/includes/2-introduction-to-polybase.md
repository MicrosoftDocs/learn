Azure SQL Data Warehouse is a relational big data store that uses a massively parallel processing (MPP) architecture. It takes advantage of the on-demand elastic scale of Azure compute and storage resources to load and process Petabytes of data - giving you quicker access to the critical information needed to make good business decisions.

> [!NOTE]
> There are two versions of compute nodes that are available at the time of writing. Both SQL Data Warehouse Generation 1 (Gen1) and Generation 2 (Gen2) can have **60 compute nodes** assigned to process data when the maximum Data Warehouse Unit (DWU) is selected. Gen2 is a newer architecture that has five times the compute capacity and four times the concurrent queries of Gen1.

A key feature of Azure SQL Data Warehouse is that you only pay for the processing you need. You can decide how much parallelism is needed for your work and you can pause the compute nodes when it's not in use, so you only pay for the CPU time you use.

Azure SQL Data Warehouse supports many loading methods including non-PolyBase options such as BCP and the SQL Bulk Copy API. However, the fastest and most scalable way to load date is through PolyBase. PolyBase is a technology that accesses external data stored in Azure Blob storage, Hadoop, or Azure Data Lake Store via the Transact-SQL language.

The following architecture diagram shows how this is achieved with each HDFS bridge of the Data Movement Service (DMS) service on every Compute node connecting to an external resource such as Azure Blob Storage. PolyBase then bidirectionally transfers data between SQL Data Warehouse and the external resource providing the fast load performance.

![Screenshot of Loading Azure SQL Date Warehouse Via PolyBase](../media/2-load-azure-dw-via-polybase.png)

## Using PolyBase to extract, load and transform data

The steps for implementing a PolyBase ELT for SQL Data Warehouse are:

1. Extract the source data into text files.
2. Load the data into Azure Blob storage, Hadoop, or Azure Data Lake Store.
3. Import the data into SQL Data Warehouse staging tables using PolyBase.
4. Transform the data (optional).
5. Insert the data into production tables.

Let's look more closely at the import process defined by steps 1-3.
