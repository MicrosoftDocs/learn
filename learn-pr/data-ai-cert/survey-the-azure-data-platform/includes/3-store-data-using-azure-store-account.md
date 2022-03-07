Azure Storage accounts are the base storage type within Azure. Azure Storage offers a scalable object store for data objects and file system services in the cloud. It can also provide a messaging store for reliable messaging, or it can act as a NoSQL store. 

Azure Storage offers four configuration options:

- **Azure Blob**: A scalable object store for text and binary data
- **Azure Files**: Managed file shares for cloud or on-premises deployments
- **Azure Queue**: A messaging store for reliable messaging between application components
- **Azure Table**: A NoSQL store for no-schema storage of structured data

You can use Azure Storage as the storage basis when you're provisioning a data platform technology such as Azure Data Lake Storage and HDInsight. But you can also provision Azure Storage for standalone use. For example, you provision an Azure Blob store either as standard storage in the form of magnetic disk storage or as premium storage in the form of solid-state drives (SSDs). 

The following definitions focus on Azure Blob storage.

## When to use Blob storage

If you need to provision a data store that will store but not query data, your cheapest option is to set up a storage account as a Blob store. Blob storage works well with images and unstructured data, and it's the cheapest way to store data in Azure.

## Key features 

Azure Storage accounts are scalable and secure, durable, and highly available. Azure handles your hardware maintenance, updates, and critical issues. It also provides REST APIs and SDKs for Azure Storage in various languages. Supported languages, runtime environments, and developer platforms include, .NET, Node.js, Java, Python, PHP, Ruby, and Go. Azure Storage also supports scripting in Azure PowerShell and the Azure CLI.

## Data ingestion

To ingest data into your system, use Azure Data Factory, Storage Explorer, the AzCopy tool, PowerShell, or Visual Studio. If you use the File Upload feature to import file sizes above 2 GB, use PowerShell or Visual Studio. AzCopy supports a maximum file size of 1 TB and automatically splits data files that exceed 200 GB.

## Data security

Azure Storage encrypts all data that's written to it. Azure Storage also provides you with fine-grained control over who has access to your data. You'll secure the data by using keys or shared access signatures. 

Azure Resource Manager provides a permissions model that uses role-based access control (RBAC). Use this functionality to set permissions and assign roles to users, groups, or applications.