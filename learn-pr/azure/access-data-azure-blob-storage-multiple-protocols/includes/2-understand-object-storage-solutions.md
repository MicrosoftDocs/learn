Azure Blob Storage allows you to store and access unstructured data at scale. You can use Blob Storage features to access the library of video clips in your organization.

## Understand Azure Blob Storage

Azure Blob Storage is a service that stores unstructured data in the cloud as blobs, also known as *objects*. *Unstructured data* is data that doesn’t adhere to a particular data model or definition, such as text or binary data. Blob Storage can store any type of text or binary data, such as documents, media files, or application installers. Blob Storage is also referred to as *object storage*.

Common Blob Storage uses include:

- Providing images or documents directly to a browser

- Storing files for distributed access

- Streaming video and audio

- Storing data for backup and restore, disaster recovery, and archiving

- Storing data for analysis by an on-premises or Azure-hosted service

### Understand hierarchical namespace support in Azure Blob Storage

You can organize objects from Blob Storage into a hierarchy of directories and nested subdirectories known as a hierarchical namespace. Blob Storage that's enabled for a hierarchical namespace provides file system semantics similar to the computer system, and you can use this storage with analytics engines and frameworks.

With a hierarchical namespace enabled on a storage account, you can achieve the following benefits:

- **Scalable and cost-effective object storage**: Hierarchical namespace scales linearly and doesn't degrade either the data capacity or performance. Even in cases where enabling a hierarchical namespace increases storage costs, the total cost to ownership is still lowered due to reduced compute costs.

- **Atomic directory manipulation**: Hierarchical namespace stores objects in a directory hierarchy using a convention of embedding slashes (/) in the object name to denote path segments. You can improve the latency due to atomic directory manipulation, which a hierarchical namespace enables.

- **Familiar interface style**: File systems with a hierarchical namespace are widely accepted by the developer community and are suitable for storage workloads designed for file systems that manipulate directories.

## Understand Azure Data Lake Storage Gen2

A *data lake* is a repository of data that’s stored in its natural format, usually as blobs or files. Azure Data Lake Storage (Data Lake Storage) is a comprehensive, scalable, and cost-effective data-lake solution for big-data analytics built into Azure Blob Storage. A fundamental part of Data Lake Storage Gen2 is the addition of a hierarchical namespace to Blob Storage.

Data Lake Storage combines a file system with a storage platform to help you quickly identify insights into your data. Data Lake Storage Gen2 builds on Azure Blob Storage capabilities to optimize it specifically for analytics workloads. This integration enables analytics performance and Blob Storage tiering and data lifecycle management capabilities. It also enables the Azure Storage high-availability, security, and durability capabilities.

### Hadoop-compatible access

Data Lake Storage Gen2 allows you to treat the data as if it's stored in an HDFS. Data Lake Storage Gen2 allows Azure Blob Storage users access to a new driver, the Azure Blob File System (ABFS). ABFS is part of Apache Hadoop and is included in many of the commercial distributions of Hadoop. With this feature, you can store the data in one place and access it without moving the data between environments by using compute technologies such as Azure Databricks, Azure HDInsight, and Azure Synapse Analytics.

### Security

Data Lake Storage Gen2 supports following authorization mechanisms:

- Access control lists (ACLs), similar to Portable Operating System Interface for UNIX (POSIX) permissions

- Role-based access control (Azure RBAC)

- Shared Key Authorization

- Shared access signature (SAS) authorization

You can set permissions at the directory level or at the file level for the data stored within the data lake. You can also configure this security by using utilities such as Azure Storage Explorer or technologies such as Apache Hive and Apache Spark. Azure encrypts all stored data at rest by using either Microsoft-managed keys or customer-managed keys.

### Performance

Data Lake Storage Gen2 organizes the stored data into a hierarchy of directories and subdirectories—similar to a file system—for easier navigation. As a result, data processing requires less computational resources, reducing both the time and costs involved.

### Data redundancy

Data Lake Storage Gen2 uses Azure Blob replication models to provide data redundancy in a single region with locally redundant storage (LRS) or zone-redundant storage (ZRS) and redundancy to a secondary region by using the geo-redundant storage (GRS) option. This feature ensures that your data is always available and more protected in the event of a disaster.
