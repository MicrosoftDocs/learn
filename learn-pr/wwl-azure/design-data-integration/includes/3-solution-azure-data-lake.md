Suppose you are a data engineering consultant doing work for Tailwind Traders. They have multiple sources of data, from websites to Point of Sale (POS) systems, and more recently from social media sites to Internet of Things (IoT) devices. They are interested in using Azure to analyze all their business data. In this role, you will provide guidance on how Azure can enhance their existing BI systems. You will also offer advice about using Azure's storage capabilities to add value to their BI solution. Because of their needs, you plan to recommend Azure Data Lake Storage. Data Lake Storage provides a repository where you can upload and store huge amounts of unstructured data with an eye toward high-performance big data analytics.

## Understand Azure Data Lake Storage

A data lake is a repository of data that is stored in its natural format, usually as blobs or files. [Azure Data Lake](https://azure.microsoft.com/solutions/data-lake/) Storage is a comprehensive, scalable, and cost-effective data lake solution for big data analytics built into Azure. Azure Data Lake Storage combines a file system with a storage platform to help you quickly identify insights into your data. Data Lake Storage Gen2 builds on Azure Blob storage capabilities to optimize it specifically for analytics workloads. This integration enables analytics performance, high-availability, security, and durability capabilities of Azure Storage.

> [!Note]
> The current implementation of Azure's data lake storage service is Azure Data Lake Storage Gen2.

### What are the features of Azure Data Lake Storage?

To better understand Azure Data Lake Storage, you can examine its following characteristics:

| **Feature**| **Description** |
| - | - |
| Data storage| Azure Data Lake Storage can store any type of data by using the data's native format. With support for any data format and massive data sizes, Azure Data Lake Storage can work with structured, semi-structured, and unstructured data. |
| Data access| Azure Data Lake Storage is primarily designed to work with Hadoop and all frameworks that use the Apache Hadoop Distributed File System (HDFS) as their data access layer. |
| Data costs| Azure Data Lake Storage is priced at Azure Blob Storage levels. |
| Data performance| Azure Data Lake Storage supports high throughput for input/output–intensive analytics and data movement. |
| Data security| The Azure Data Lake Storage access control model supports both Azure role-based access control (RBAC) and Portable Operating System Interface for UNIX (POSIX) access control lists (ACLs). |
| Data redundancy| Azure Data Lake Storage utilizes Azure Blob replication models. These models provide data redundancy in a single datacenter with locally redundant storage (LRS). |
| Data scalability| Azure Data Lake Storage offers massive storage and accepts numerous data types for analytics. |
| Data analysis| Data analysis frameworks that use HDFS as their data access layer can directly access. |



## How Azure Data Lake Storage works

There are three important steps to use Azure Data Lake Storage. These are:

**Ingesting data -** Azure Data Lake Storage offers many different data ingestion methods. 

- For ad hoc data -Use tools like AzCopy, CLI, PowerShell, Storage Explorer etc.

- For relational data-Use the Azure Data Factory service. It enables you to transfer data from any of the sources including Cosmos DB, SQL Database, Managed instances etc.

- For steaming data-Use tools such as Apache Storm on Azure HDInsight, Azure Stream Analytics etc.

Following diagram shows how ad hoc data and streaming data are bulk ingested or ad hoc ingested in Azure Data Lake Storage.

 

:::image type="content" source="../media/data-lake.png" alt-text="Diagram showing ad hoc data and streaming data are either bulk ingested or ad hoc ingested in Azure Data Lake Storage.":::



**Accessing stored data**

The easiest way to access your data is to use Azure Storage Explorer. Storage Explorer is a standalone application with a graphical user interface (GUI) for accessing your Azure Data Lake Storage data. You can also use PowerShell, Azure CLI, HDFS CLI or other programming language SDKs for accessing the data.

**Setting access control**

To control who can access the data stored in Azure Data Lake Storage, you can implement one or both of the following authorization mechanisms:

- Azure RBAC

- ACL

## When to use Azure Data Lake Storage

Now we will consider whether Azure Data Lake Storage is the right choice for your organization's big data requirements.

| **Requirement**| **Description** |
| - | - |
| When you need a Data warehouse on the cloud for managing large volumes of data| Azure Data Lake Storage runs on virtual hardware on the Azure platform, making storage scalable, fast, and reliable without incurring massive charges. It separates storage costs from compute costs. As your data volume grows, only your storage requirements change. |
| When you need to manage a diverse collection of data types such as JSON files, CSV, log files or other diverse formats| Azure Data Lake Storage enables data democratization for your organization by storing all your data formats (including raw data) in a single location. Eliminating data silos enables users to use a tool such as Azure Data Explorer to access and work with every data item in their storage account. |
| When you need real time data ingestion and storage| Azure Data Lake Storage can ingest real-time data directly from an instance of Apache Storm on Azure HDInsight, Azure IoT Hub, Azure Event Hubs, or Azure Stream Analytics. It also works with semi-structured data and lets you ingest all your real-time data into your storage account. |


### When to choose Azure Blob Storage over Azure Data Lake

Here are some criteria that will help you decide when to pick one storage solution over the other. In the following table, the two storage solutions are compared against a set of criteria.

| **Criteria**| **Azure Data Lake**| **Azure Blob Storage** |
| - | -| - |
| Data type| Good for storing large volumes of text data| Good for storing unstructured non-text based data such as photos, videos, backup etc. |
| Geographic redundancy| Need to set up replication of data| By default, provides geo redundant storage |
| Namespaces support| Supports hierarchical namespaces| Supports flat namespaces |
| Hadoop compatibility| Hadoop services can use data stored in Data Lake| Is not Hadoop compatible |
| Security| Allows for more granular access| Granular access not supported |