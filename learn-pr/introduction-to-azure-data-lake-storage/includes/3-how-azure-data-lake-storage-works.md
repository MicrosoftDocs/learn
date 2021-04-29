<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'describe' learning objective.

    Pattern:
        One paragraph of 2-3 sentences:
            Sentence 1: State that this unit addresses ("how it works").
            Sentence 2: State that this unit targets this learning objective: "Describe how <features> of <product> work to <solve problem>."
            Sentence 3-4 (optional): Give the rationale ("helps you decide if it will meet your needs").
        Table-of-contents as a bulleted list (do not simply list every heading you'll have on the page, group them into about 3 high-level areas).

    Heading: none

    Example: "Here, we'll discuss how Logic Apps works behind the scenes. You'll learn about all the pieces of Logic apps and see how they fit together into an app. This knowledge will help you decide whether Logic Apps will work for you without any customization. In cases where you do need to create custom components, you'll be able to determine how difficult it will be.
        * Connectors, triggers, actions
        * Control actions
        * Logic Apps Designer"
-->
Here, we'll discuss how Azure Data Lake Storage works, including getting data into storage, accessing your data, and controlling who has access to the data. This knowledge will help you evaluate whether Azure Data Lake Storage is the right solution for your company's big data storage needs.

In this unit, you'll learn about

* Ingesting data
* Accessing stored data
* Setting access control features

<!-- 2. Chunked content-------------------------------------------------------------------------------------

    Goal:
        Cover the components of <product> and how they work.
        Repeat this pattern multiple times as needed.

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

## Ingesting data into Azure Data Lake Storage

Before you can do anything useful with Azure Data Lake Storage, you need to move data into your storage account. This process is called *ingesting* the data. Azure Data Lake Storage offers many different data ingestion methods, and the method you use depends on the type of data and where the data is stored or generated.

:::image type="content" source="../media/3-how-azure-data-lake-storage-works-ingestion.png" alt-text="Diagram showing ad hoc data and streaming data being ingested in Azure Data Lake Storage.":::

### Ingesting ad hoc data

*Ad hoc* data refers primarily to smaller data sets that you ingest as needed. Most ad hoc data is used to prototype or test big data applications. How you ingest ad hoc data depends on the source of that data.

> [!NOTE]
> Ad hoc data can also refer to larger data sets such as web server logs and social sentiment data (that is, social media posts and comments that you can analyze to learn how users feel about your organization or brand).

For data that resides on a local computer, you can use any of the tools shown in the following table to send data from your computer to Azure Data Lake Storage:

| | |
| --- | --- |
|**Tool**  | **Description**  |
|**AzCopy**     | A local command-line tool that you can use to transfer files (for example, `azcopy copy`*`local_path`* *`ADLS_uri`*). |
|**Azure CLI**    | An Azure command-line tool for managing and working with Azure services, including uploading files (for example, `az storage fs file upload`*`local_path`* *`ADLS_path`*).  |
|**Azure PowerShell**    | An Azure command-line utility that includes the `New-AzDataLakeGen2Item` cmdlet for uploading files to Azure Data Lake Storage (for example, `New-AzDataLakeGen2Item -Context`*`context`*`-FileSystem`*`filesystemName`*`-Path`*`$destPath`*`-Source`*`localPath`*`-Force`).  |
|**Azure Storage Explorer**    | A standalone app for connecting to and managing Azure storage accounts, including uploading files. Storage Explorer is available for Windows, macOS, and Linux.  |
| | |

> [!IMPORTANT]
> For most of these ingestion methods to work, your storage account must be using the hierarchical namespace.

For Azure Storage Blob data, you can use any of the tools shown in the following table to copy blobs to Azure Data Lake Storage:

| | |
| --- | --- |
|**Tool**  | **Description**  |
|**AzCopy**   | A local command-line tool that you can use to transfer blobs (for example, `azcopy copy`*`source_blob_uri`* *`dest_blob_uri`*).   |
|**Azure Data Factory**   | An Azure data integration service for orchestrating data movement, which includes a Copy activity for copying blobs between data stores.   |
|**DistCp**   | An Apache Hadoop command-line tool for copying data from an Azure HDInsight cluster to Azure Data Lake Storage (for example, `hadoop distcp`*`WASB_uri`* *`ADLS_uri`*).     |
| | |

### Ingesting relational data

If you have data stored in a relational database management system, you might want to transfer that data to Azure Data Lake Storage for analysis. To ingest relational data, you use the Azure Data Factory service, which includes a Copy activity that enables you to transfer data to Azure Data Lake Storage from any of the following Azure sources:

* Azure Cosmos DB (MongoDB API)
* Azure Cosmos DB (SQL API)
* Azure Database for MariaDB
* Azure Database for MySQL
* Azure Database for PostgreSQL
* Azure SQL Database
* Azure SQL Managed Instance

If your relational data is on-premises, Azure Data Factory can also work with most relational database systems as sources, including the following products:

* DB2
* Hive
* MariaDB
* Microsoft Access
* MongoDB
* MySQL
* Oracle
* PostgreSQL
* Snowflake
* Spark
* SQL Server
* Sybase

### Ingesting streamed data

Does your organization generate real-time streamed data from devices, sensors, or applications? If so, then you'll want to capture that data on an event-by-event basis as the data is generated and then ingest that data into Azure Data Lake Storage for processing and analysis. You can use the tools shown in the following table to ingest streamed data.

| | |
| --- | --- |
|**Tool**  | **Description**  |
|**Azure HDInsight Storm**   | Uses Apache Storm on HDInsight to write data to HDFS on Azure Data Lake Storage. Apache Storm is a processing framework for real-time streaming data.   |
|**Azure Stream Analytics**   | Uses an Azure Stream Analytics job that reads data from an Azure IoT Hub resource and outputs the job data to a blob on Azure Data Lake Storage.   |
| | |

## Accessing stored data

Assuming you have a storage account with the hierarchical namespace enabled, how do you access the data that you have ingested into Azure Data Lake Storage? The following sections describe the most common access methods.

### Azure Storage Explorer

The easiest way to access your data is to use Azure Storage Explorer. Storage Explorer is a standalone application that offers a graphical front end to your Azure Data Lake Storage data. Storage Explorer enables you to upload and download Azure Data Lake Storage entities such as blobs and files, create and manage Azure Data Lake Storage directories, and perform many other data management tasks from your Windows, macOS, or Linux computer.

### PowerShell

The PowerShell utility offers many cmdlets that are specific to Azure Data Lake Storage. (If you're new to PowerShell, a *cmdlet*—it's pronounced "command-let"—is a special command that you invoke in the PowerShell environment to implement a specific task or function.) To give you a flavor of what you can do in PowerShell, the following table lists a few cmdlets that are commonly used to access data in Azure Data Lake Storage.

| | |
| --- | --- |
|**Cmdlet**  | **Description**  |
|**Get-AzDataLakeGen2ChildItem**    | Lists the subdirectories and files that reside in a directory or the filesystem root.   |
|**Get-AzDataLakeGen2Item**   | Gets the details of a file or directory, including when it was last modified, what permissions are set, and which user is the owner.   |
|**Get-AzDataLakeGen2ItemContent**    | Downloads an Azure Data Lake Storage file to a local file.   |
|**Move-AzDataLakeGen2Item**    | Moves a file or directory to another a file or directory in the same storage account.   |
|**New-AzDataLakeGen2Item**    | Creates a file or directory.    |
|**Remove-AzDataLakeGen2Item**    | Deletes a file or directory.   |
|**Update-AzDataLakeGen2Item**   | Updates the properties, metadata, permissions, or owner of a file or directory.   |
| | |

### Other access methods

Besides Azure Storage Explorer and PowerShell, you can also use any of the following tools to access your Azure Data Lake Storage data:

* Azure CLI: The Azure command-line interface includes several commands for working with Azure Data Lake Storage data, including `list`, `show`, `create`, `move`, `delete`, `upload`, and `download`.
* Hadoop Distributed File System CLI: You can access and manage the data in your storage account by using a command-line interface just as you would with a Hadoop Distributed File System (HDFS).
* JavaScript (Node.js): You can install the Azure Data Lake Storage client library for JavaScript. In your Node.js script, you create a `DataLakeServiceClient` instance for your storage account and use that instance's exposed methods—such as `create()`, `move()`, and `delete()`—to connect to and work with your Azure Data Lake Storage data.
* .NET: You can install the Azure.Storage.Files.DataLake NuGet package in your .NET project. Then, in your code, you create a `DataLakeServiceClient` instance for your storage account and use that instance's exposed methods to connect to and work with your data.
* Python: You can install the Azure Data Lake Storage client library for Python. Then, in your script, you create a `DataLakeServiceClient` instance for your storage account and use that instance's exposed methods to connect to and work with your data.

## Setting access controls on stored data

To control who can access the data stored in Azure Data Lake Storage, you can implement one or both of the following authorization mechanisms:

* Azure role-based access control (RBAC)
* Access control list (ACL)

As described in the following two sections, you use RBAC for "coarse-grained" access to data, and you use ACL for "fine-grained" access. In both cases, you apply the access permissions to one or more of the following types of security principals (each of which must be defined in Azure Active Directory):

* User
* Group
* Service principal
* Managed identity

### Role-based access control (RBAC)

Azure RBAC uses role assignments to apply a collection of permissions to a security principal. When assigning a role to a security principal, you specify a *role definition*. A role definition is a set of permissions that lists the operations the security principal can perform, such as read, write, and delete. A role definition gives a security principal coarse-grained access. For example, a role assignment might give a security principal read or write access to all of the data in a storage account or to all of the data in a container.

The roles in the following table permit a security principal to access data in a storage account.

| | |
| --- | --- |
|**Role**  | **Description**  |
|**Storage Blob Data Owner**    | This role assigns the security principal full access to blob storage containers and data. This access permits the security principal to set the owner on an item and to modify the ACLs of all items.    |
|**Storage Blob Data Contributor**    | This role assigns the security principal read, write, and delete access to blob storage containers and blobs. This access doesn't permit the security principal to set the ownership of an item, but it can modify the ACL of items that are owned by the security principal.    |
|**Storage Blob Data Reader**    | This role assigns the security principal only read and list permissions for blobs and blob storage containers.    |
| | |

You can assign roles using the Azure portal, Azure CLI, Azure PowerShell, Azure SDKs, or REST APIs.

### Access control list (ACL)

You can associate a security principal with an access level for files and directories. These associations are captured in an access control list (ACL). Each file and directory in your storage account has an access control list. When a security principal attempts an operation on a file or directory, an ACL check determines whether that security principal has the correct permission level to perform the operation.

The following table lists the levels of permission that you can assign:

| | | |
| --- | --- | --- |
|**Permission**  | **Short form**  | **The security principal can**  |
|**Read (R)**    | R--    | Read the contents of a file    |
|**Write (W)**   | -W-    | Write or append to a file    |
|**Execute (X)**   | --X    | Not used at the file level in Azure Data Lake Storage; traverse the child items in a directory     |
|**Read + Execute**    | R-X    | List the contents of a directory    |
|**Write + Execute**    | -WX    | Create child items in a directory    |
| | | |

The easiest way to set ACL permissions is to use Azure Storage Explorer. If you manage Azure Data Lake Storage via PowerShell, the following table lists the cmdlets you can use to work with ACLs in Azure Data Lake Storage.

| | |
| --- | --- |
|**Cmdlet**  | **Description**  |
|**Remove-AzDataLakeGen2AclRecursive**    | Removes ACL permissions recursively on the specified path.    |
|**Set-AzDataLakeGen2AclRecursive**    | Sets ACL permissions recursively on the specified path.   |
|**Set-AzDataLakeGen2ItemAclObject**    | Creates or updates an Azure Data Lake Storage item ACL object, which you can use in the Update-AzDataLakeGen2Item cmdlet.|
|**Update-AzDataLakeGen2AclRecursive**    | Updates ACL permissions recursively on the specified path.   |
| | |

Besides Azure Storage Explorer and PowerShell, you can also use any of the following tools to set ACL permissions on your Azure Data Lake Storage data:

* Azure CLI
* Java
* JavaScript (Node.js)
* .NET
* Python
* REST API

### How Azure Data Lake Storage evaluates permissions

When an operation occurs that requires security principal-based authorization, Azure Data Lake Storage evaluates permissions using the following procedure:

1. Has the required RBAC role been assigned to the security principal?
    * If yes, grant access to the resource.
    * If no, continue with Step 2.
1. Has the required ACL permission been assigned to the security principal?
    * If yes, grant access to the resource.
    * If no, continue with Step 3.
1. Deny the security principal access to the resource.

:::image type="content" source="../media/3-how-azure-data-lake-storage-works-access-control.png" alt-text="Flowchart showing how Azure Data Lake Storage evaluates permissions.":::

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->