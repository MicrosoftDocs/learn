Here, we'll discuss how Azure Data Lake Storage works, including getting data into storage, accessing your data, and controlling who has access to the data. This knowledge will help you evaluate whether Azure Data Lake Storage is the right solution for your company's big data storage needs.

In this unit, you'll learn about

- Ingesting data
- Accessing stored data
- Setting access control features

## Ingesting data into Azure Data Lake Storage

Before you can do anything useful with Azure Data Lake Storage, you need to move data into your storage account. This process is called *ingesting* the data. Azure Data Lake Storage offers many different data ingestion methods, and the method you use depends on the type of data and where the data is stored or generated.

:::image type="content" source="../media/3-how-azure-data-lake-storage-works-ingestion.png" alt-text="Diagram depicting ad hoc data and streaming data being ingested in Azure Data Lake Storage.":::

### Ingesting ad hoc data

*Ad hoc* data refers primarily to smaller datasets that you ingest as needed. Most ad hoc data is used to prototype or test big data applications. How you ingest ad hoc data depends on the source of that data.

> [!NOTE]
> Ad hoc data can also refer to larger datasets such as web server logs and social sentiment data (that is, social media posts and comments that you can analyze to learn how users feel about your organization or brand).

For data that resides on a local computer, you can use any of the following tools to send data from your computer to Azure Data Lake Storage:

- AzCopy
- Azure CLI
- Azure PowerShell
- Azure Storage Explorer

> [!NOTE]
> Azure Storage Explorer is a standalone app for connecting to and managing Azure storage accounts, including uploading files. Storage Explorer is available for Windows, macOS, and Linux.

> [!IMPORTANT]
> For most of these ingestion methods to work, your storage account must be using the hierarchical namespace.

For Azure Blob Storage data, you can use any of the following tools to copy blobs to Azure Data Lake Storage:

- AzCopy
- Azure Data Factory
- DistCp

### Ingesting relational data

If you have data stored in a relational database management system, you might want to transfer that data to Azure Data Lake Storage for analysis. To ingest relational data, you use the Azure Data Factory service, which includes a Copy activity that enables you to transfer data to Azure Data Lake Storage from any of the following Azure sources:

- Azure Cosmos DB (MongoDB API)
- Azure Cosmos DB (SQL API)
- Azure Database for MariaDB
- Azure Database for MySQL
- Azure Database for PostgreSQL
- Azure SQL Database
- Azure SQL Managed Instance

If your relational data is on-premises, Azure Data Factory can also work with most relational database systems as sources, including MongoDB, MySQL, and Microsoft SQL Server.

### Ingesting streamed data

Does your organization generate real-time streamed data from devices, sensors, or applications? If so, then you'll want to capture that data on an event-by-event basis as the data is generated and then ingest that data into Azure Data Lake Storage for processing and analysis. You can use the following tools to ingest streamed data:

- Azure HDInsight Storm
- Azure Stream Analytics

## Accessing stored data

Assuming you have a storage account with the hierarchical namespace enabled, how do you access the data that you have ingested into Azure Data Lake Storage? The following sections describe the most common access methods.

### Azure Storage Explorer

The easiest way to access your data is to use Azure Storage Explorer. Storage Explorer is a standalone application that offers a graphical front end to your Azure Data Lake Storage data. Storage Explorer enables you to upload and download Azure Data Lake Storage entities such as blobs and files, create and manage Azure Data Lake Storage directories, and perform many other data management tasks from your Windows, macOS, or Linux computer.

### PowerShell

The PowerShell utility offers many cmdlets that are specific to Azure Data Lake Storage. (If you're new to PowerShell, a *cmdlet*—it's pronounced "command-let"—is a special command that you invoke in the PowerShell environment to implement a specific task or function.)

### Other access methods

Besides Azure Storage Explorer and PowerShell, you can also use any of the following tools to access your Azure Data Lake Storage data:

- Azure CLI
- Hadoop Distributed File System CLI
- Java
- JavaScript (Node.js)
- .NET
- Python

## Setting access controls on stored data

To control who can access the data stored in Azure Data Lake Storage, you can implement one or both of the following authorization mechanisms:

- Azure role-based access control (RBAC)
- Access control list (ACL)

As described in the following two sections, you use RBAC for "coarse-grained" access to data, and you use ACL for "fine-grained" access. In both cases, you apply the access permissions to one or more of the following types of security principals (each of which must be defined in Azure Active Directory):

- User
- Group
- Service principal
- Managed identity

### Role-based access control (RBAC)

Azure RBAC uses role assignments to apply a collection of permissions to a security principal. When assigning a role to a security principal, you specify a *role definition*. A role definition is a set of permissions that lists the operations the security principal can perform, such as read, write, and delete. A role definition gives a security principal coarse-grained access. For example, a role assignment might give a security principal read or write access to all of the data in a storage account or to all of the data in a container.

### Access control list (ACL)

You can associate a security principal with an access level for files and directories. These associations are captured in an access control list (ACL). Each file and directory in your storage account has an access control list. When a security principal attempts an operation on a file or directory, an ACL check determines whether that security principal has the correct permission level to perform the operation.

### How Azure Data Lake Storage evaluates permissions

When an operation occurs that requires security principal-based authorization, Azure Data Lake Storage evaluates permissions using the following procedure:

1. Has the required RBAC role been assigned to the security principal?
    - If yes, grant access to the resource.
    - If no, continue with Step 2.
1. Has the required ACL permission been assigned to the security principal?
    - If yes, grant access to the resource.
    - If no, continue with Step 3.
1. Deny the security principal access to the resource.

:::image type="content" source="../media/3-how-azure-data-lake-storage-works-access-control.png" alt-text="Flowchart depicting how Azure Data Lake Storage evaluates permissions.":::
