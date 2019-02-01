Azure storage accounts are the base storage type used within Microsoft Azure.  Azure Storage offers a massively scalable object store for data objects and file system services for the cloud. It can also provide a messaging store for reliable messaging, or act as a NoSQL store. The four configuration options available include:

- **Azure Blobs**: A massively scalable object store for text and binary data.
- **Azure Files**: Managed file shares for cloud or on-premises deployments.
- **Azure Queues**: A messaging store for reliable messaging between application components.
- **Azure Tables**: A NoSQL store for schema-less storage of structured data.

Azure storage can be the basis for storage when provisioning a data platform technology such as Azure Data Lake Storage and HDInsight. However, it can also be provisioned for standalone use such as an Azure BLOB Store that is either provisioned as standard storage in the form of magnetic disk storage, or premium storage in the form of solid-state drives (SSD). Azure BLOB store is what we will focus on in our definitions that follow.

## When to Use It

If your business scenario is to provision a data store that will store data, but not query it, then creating a storage account configured as a BLOB store is the cheapest option for storing data and work very well with images and unstructured data. In short, if you want to store data in Azure in the cheapest way. Azure BLOB store is the cheapest way to achieve this.

## Key Features

Azure storage accounts are scalable and secure, durable and highly available. Microsoft Azure handles hardware maintenance, updates, and critical issues for you and provides SDKs for Azure Storage in a variety of languages -- .NET, Java, Node.js, Python, PHP, Ruby, Go, and others -- as well as a mature REST API. Azure Storage supports scripting in Azure PowerShell or Azure CLI.

## Ingesting Data

To ingest data, a Data Engineer can use either the Azure Data Factory, Azure Storage Explorer or the AzCopy Tool, PowerShell, or Visual Studio.  To import file sizes above 2Gb using the File Upload feature, Data Engineers must use PowerShell or Visual Studio.  The AzCopy Tool supports a maximum file size of 1Tb and will automatically split into multiple files if the data file exceeds 200Gb.

## Querying Data

Creating a storage account as a Blob means that you cannot query the data directly.  If you need to query it, then you either need to move the data to a store that can support querying or configure the Azure Storage Account for data lake storage account.

## Securing Data

All data written to Azure Storage is encrypted by the service. Azure Storage also provides you with fine-grained control over who has access to your data using keys or Shared Access Signatures. There is also a permissions model using Resource Manager Role-Based Access Control (RBAC), where you can assign roles to users, groups, or applications and set permissions.