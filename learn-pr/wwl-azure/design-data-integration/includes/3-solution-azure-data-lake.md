
A data lake is a repository of data that's stored in its natural format, usually as blobs or files. [Azure Data Lake](https://azure.microsoft.com/solutions/data-lake/) Storage is a comprehensive, scalable, and cost-effective data lake solution for big data analytics built into Azure. Azure Data Lake Storage combines a file system with a storage platform to help you quickly identify insights into your data. The solution builds on Azure Blob Storage capabilities to provide optimizations for analytics workloads. This integration enables analytics performance, high-availability, security, and durability capabilities of Azure Storage.

> [!Note] 
> The current implementation of the service is Azure Data Lake Storage Gen2.

### Things to know about Azure Data Lake Storage

To better understand Azure Data Lake Storage, let's examine the following characteristics.

- Azure Data Lake Storage can store any type of data by using the data's native format. With support for any data format and massive data sizes, Azure Data Lake Storage can work with structured, semi-structured, and unstructured data.
- The solution is primarily designed to work with Hadoop and all frameworks that use the Apache Hadoop Distributed File System (HDFS) as their data access layer. Data analysis frameworks that use HDFS as their data access layer can directly access.
- Azure Data Lake Storage supports high throughput for input and output–intensive analytics and data movement.
- The Azure Data Lake Storage access control model supports both Azure role-based access control (RBAC) and Portable Operating System Interface for UNIX (POSIX) access control lists (ACLs).
- Azure Data Lake Storage utilizes Azure Blob replication models. These models provide data redundancy in a single datacenter with locally redundant storage (LRS).
- Azure Data Lake Storage offers massive storage and accepts numerous data types for analytics.
- Azure Data Lake Storage is priced at Azure Blob Storage levels.

#### How Azure Data Lake Storage works

There are three important steps to use Azure Data Lake Storage:

1. **Ingest data**. Azure Data Lake Storage offers many different data ingestion methods:

   - For unplanned data, you can use tools like AzCopy, the Azure CLI, PowerShell, and Azure Storage Explorer.
   - For relational data, the Azure Data Factory service can be used. You can transfer data from any source, such as Azure Cosmos DB, SQL Database, Azure SQL Managed instances, and more.
   - For streaming data, you can use tools like Apache Storm on Azure HDInsight, Azure Stream Analytics, and so on.

   The following diagram shows how unplanned data and streaming data are bulk ingested or unplanned ingested in Azure Data Lake Storage.

   :::image type="content" source="../media/data-lake.png" alt-text="Diagram that shows how unplanned data and streaming data are either bulk ingested or unplanned ingested in Azure Data Lake Storage.":::

2. **Access stored data**. The easiest way to access your data is to use Azure Storage Explorer. Storage Explorer is a standalone application with a graphical user interface (GUI) for accessing your Azure Data Lake Storage data. You can also use PowerShell, the Azure CLI, HDFS CLI, or other programming language SDKs for accessing the data.

3. **Configure access control**. Control who can access the data stored in Azure Data Lake Storage by implementing an authorization mechanism. You can choose Azure RBAC or ACL.

#### Business scenario

Tailwind Traders has multiple sources of data, including websites, Point of Sale (POS) systems, social media sites, and Internet of Things (IoT) devices. The company is interested in using Azure to analyze all their business data. You're tasked with providing guidance on how Azure can enhance their existing BI systems. You need to advise the team about how Azure storage capabilities can add value to the company's BI solution. To fulfill the data requirements, you plan to recommend Azure Data Lake Storage. Data Lake Storage provides a repository where you can upload and store huge amounts of unstructured data with an eye toward high-performance big data analytics.

Let's review how Azure Data Lake Storage can be the right choice for the organization's big data requirements.

| Scenario                                                     | Solution                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| *Provide a data warehouse on the cloud for managing large volumes of data*. | Azure Data Lake Storage runs on virtual hardware on the Azure platform. Storage is scalable, fast, and reliable without incurring massive charges. It separates storage costs from compute costs. As your data volume grows, only your storage requirements change. |
| *Support a diverse collection of data types, such as JSON files, CSV, log files, or other formats*. | Azure Data Lake Storage enables data democratization for your organization by storing all your data formats (including raw data) in a single location. By eliminating data silos, your users can use tools like Azure Data Explorer to access and work with every data item in their storage account. |
| *Enable real-time data ingestion and storage*.               | Azure Data Lake Storage can ingest real-time data directly from an instance of Apache Storm on Azure HDInsight, Azure IoT Hub, Azure Event Hubs, or Azure Stream Analytics. It also works with semi-structured data and lets you ingest all your real-time data into your storage account. |

### Things to consider when choosing Azure Blob Storage or Azure Data Lake

The following table compares storage solution criteria for using Azure Blob Storage versus Azure Data Lake. Review the criteria and consider which solution is optimal for Tailwind Traders.

| Compare                   | Azure Data Lake                                        | Azure Blob Storage                                           |
| ------------------------- | ------------------------------------------------------ | ------------------------------------------------------------ |
| **Data types**            | Good for storing large volumes of text data            | Good for storing unstructured non-text based data like photos, videos, and backups |
| **Geographic redundancy** | Must manually configure data replication               | Provides geo-redundant storage by default                    |
| **Namespaces**            | Supports hierarchical namespaces                       | Supports flat namespaces                                     |
| **Hadoop compatibility**  | Hadoop services can use data stored in Azure Data Lake | By using Azure Blob Filesystem Driver, applications and frameworks can access data in Azure Blob Storage |
| **Security**              | Supports granular access                               | Granular access isn't supported                              |