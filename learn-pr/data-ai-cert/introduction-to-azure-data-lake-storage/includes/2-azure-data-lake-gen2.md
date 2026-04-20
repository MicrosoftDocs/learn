A data lake is a repository of data that is stored in its natural format, usually as blobs or files. Azure Data Lake Storage is a comprehensive, massively scalable, secure, and cost-effective data lake solution for high performance analytics built into Azure. 

![Diagram representing files in Azure data Lake Storage Gen2 being accessed by big data technologies.](../media/azure-data-lake-gen-2.png)

Azure Data Lake Storage combines a file system with a storage platform to help you quickly identify insights into your data. Data Lake Storage builds on Azure Blob storage capabilities to optimize it specifically for analytics workloads. This integration enables analytics performance, the tiering and data lifecycle management capabilities of Blob storage, and the high-availability, security, and durability capabilities of Azure Storage.

## Benefits

Data Lake Storage  is designed to deal with this variety and volume of data at exabyte scale while securely handling hundreds of gigabytes of throughput. With this, you can use Data Lake Storage Gen2 as the basis for both real-time and batch solutions.

### Open analytics platform access

A benefit of Data Lake Storage is that it exposes a hierarchical file system through open APIs, enabling you to store data in one place and access it through modern compute technologies including Azure Databricks and Microsoft Fabric without moving the data between environments. Data engineers can also use open file formats such as Parquet and Delta Lake, which are highly compressed, support schema enforcement, and perform well across multiple analytics platforms.

### Security

Azure Data Lake Storage uses a layered access control model. Azure role-based access control (Azure RBAC) lets you grant coarse-grained access—such as read or write access to all data in a container—to users, groups, and service principals. Azure Attribute-based access control (Azure ABAC) refines those role assignments by adding conditions, such as restricting access to data with a specific tag. For precise, file-level control, access control lists (ACLs) with Portable Operating System Interface (POSIX) permissions let you set permissions at the directory or file level.

Permissions aren't automatically inherited from parent directories after a child item is created. However, you can configure default permissions on a parent directory, which are then applied to new child items at the time they're created. You can manage these settings using utilities such as Azure Storage Explorer, which runs on Windows, macOS, and Linux. All data that is stored is encrypted at rest by using either Microsoft-managed or customer-managed keys.

### Performance

Azure Data Lake Storage organizes the stored data into a hierarchy of directories and subdirectories, much like a file system, for easier navigation. As a result, data processing requires less computational resources, reducing both the time and cost.

### Data redundancy

Data Lake Storage inherits all Azure Blob Storage replication models. Locally redundant storage (LRS) keeps multiple copies within a single data center, while zone-redundant storage (ZRS) replicates data across availability zones in the same region. For broader geographic protection, geo-redundant storage (GRS) or read-access geo-redundant storage (RA-GRS) replicates data to a secondary region. For the highest level of resilience, geo-zone-redundant storage (GZRS or RA-GZRS) combines zone and geographic redundancy. This range of options ensures your data is always available and protected regardless of the scale of disruption.

> [!TIP]
> Whenever planning for a data lake, a data engineer should give thoughtful consideration to structure, data governance, and security. This should include consideration of factors that can influence lake structure and organization, such as:
>
> - Types of data to be stored
> - How the data will be transformed
> - Who should access the data
> - What are the typical access patterns
>
> This approach will help determine how to plan for access control governance across your lake. Data engineers should be proactive in ensuring that the lake doesn't become the proverbial data swamp which becomes inaccessible and non-useful to users due to the lack of data governance and data quality measures. Establishing a baseline and following best practices for Azure Data Lake will help ensure a proper and robust implementation that will allow the organization to grow and gain insight to achieve more.
