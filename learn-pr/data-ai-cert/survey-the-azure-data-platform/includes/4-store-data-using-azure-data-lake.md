Azure Data Lake Storage is a Hadoop-compatible data repository that can store any size or type of data. This storage service is available as Generation 1 (Gen1) or Generation 2 (Gen2). Data Lake Storage Gen1 users don't have to upgrade to Gen2, but they forgo some benefits. 

Data Lake Storage Gen2 users take advantage of Azure Blob storage, a hierarchical file system, and performance tuning that helps them process big-data analytics solutions. In Gen2, developers can access data through either the Blob API or the Data Lake file API. Gen2 can also act as a storage layer for a wide range of compute platforms, including Azure Databricks, Hadoop, and Azure HDInsight, but data doesn't need to be loaded into the platforms.

## Where to use Data Lake Storage Gen2

Data Lake Storage is designed to store massive amounts of data for big-data analytics. For example, Contoso Life Sciences is a cancer research center that analyzes petabytes of genetic data, patient data, and records of related sample data. Data Lake Storage Gen2 reduces computation times, making the research faster and less expensive. 

The compute aspect that sits above this storage can vary. The aspect can include platforms like HDInsight, Hadoop, Cloudera, Azure Databricks, and Hortonworks.

## Key features

Here are the key features of Data Lake Storage: 

* Unlimited scalability
* Hadoop compatibility
* Security support for both access control lists (ACLs)
* POSIX compliance
* An optimized Azure Blob File System (ABFS) driver that's designed for big-data analytics
* Zone-redundant storage
* Geo-redundant storage

## Data ingestion

To ingest data into your system, use Azure Data Factory, Apache Sqoop, Azure Storage Explorer, the AzCopy tool, PowerShell, or Visual Studio. To use the File Upload feature to import file sizes above 2 GB, use PowerShell or Visual Studio. AzCopy supports a maximum file size of 1 TB and automatically splits data files that exceed 200 GB.

## Queries

In Data Lake Storage Gen1, data engineers query data by using the U-SQL language. In Gen 2, use the Azure Blob Storage API or the Azure Data Lake System (ADLS) API.

## Data security

Because Data Lake Storage supports Azure Active Directory ACLs, security administrators can control data access by using the familiar Active Directory Security Groups. Role-based access control (RBAC) is available in Gen1. Built-in security groups include ReadOnlyUsers, WriteAccessUsers, and FullAccessUsers. 

Enable the firewall to limit traffic to only Azure services. Data Lake Storage automatically encrypts data at rest, protecting data privacy.