Azure Data Lake storage is a Hadoop-compatible data repository that can store any size or type of data.  Azure Data Lake is available in two offerings; Generation 1 (Gen1) or Generation 2 (Gen2).  Gen1 users do not have to upgrade to Gen2., but Gen2 combines the storage services from Gen1 with the benefits of Azure Blob Storage and is performance tuned for processing big data analytics solutions.

Gen2 includes new features like a hierarchical file system, and developers can access the data either through the Blob API or the Azure Data Lake File API (ADLS). An additional benefit to Gen 2 is that it can act a storage layer for a wide range of compute platforms including Azure Databricks, Hadoop or Azure HDInsight without the need to load the data into those systems.

## When to Use It

Azure Data Lake is designed for customers who require the ability to store massive amounts of data for big data analytics use cases.  For example, Contoso Life Sciences, a cancer research center, analyzes Petabyte scale of genetic data, patient data, and billions of records of related sample data as part of their research.  Azure Data Lake Gen2's ability to reduce computation times will make Contoso's Life Sciences research faster and less expensive.  Additionally, the compute aspect that sits above this storage can vary and include platforms including HDInsight, Hadoop, Cloudera, Azure Databricks, and Hortonworks.

## Key Features

Key features of Azure Data Lake include unlimited scalability, Hadoop compatibility, security support for both Access Control Lists (ACLs), POSIX-compliance and an optimized ABFS driver designed for big data analytics, zone redundant storage and geo-redundant storage.

## Ingesting Data

To ingest data, a Data Engineer can use either the Azure Data Factory, Apache Sqoop, Azure Storage Explorer or the AzCopy Tool, PowerShell, or Visual Studio.  To import file sizes above 2Gb using the File Upload feature, Data Engineers must use PowerShell or Visual Studio.  The AzCopy Tool supports a maximum file size of 1Tb and will automatically split into multiple files if the data file exceeds 200Gb.

## Querying Data

In the past, Data Engineers can query data in Azure Data Lake Store using U-SQL for Gen1. With the introduction of Gen 2, you can use the Azure Blob Storage API or the Azure Data Lake System (ADLS) API.

## Securing Data

Since Azure Data Lake supports Azure Active Directory Access Control Lists (ACL), security administrators can use familiar Active Directory Security Groups to control data access.  Role Based Access Control (RBAC) is available in Gen1.  Built-in Security Groups include ReadOnlyUsers, WriteAccessUsers, and FullAccessUsers.  Enabling the firewall option will limit traffic to only Azure services.  Azure Data Lake automatically encrypts data at rest, protecting data privacy.