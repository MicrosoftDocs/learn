There is a wide variety of cloud storage options available to architects who are designing Azure IoT solutions. Each solution has design considerations that must be weighed.

Azure storage options that are commonly found in Azure IoT Hub solutions include:

* Azure Blob Storage and Azure Data Lake Gen2, which are both available as IoT Hub routing endpoints.
* Azure Cosmos DB and Azure SQL Database, which are both available as Azure Stream Analytics outputs.

## Azure Storage characteristics

Azure Storage is Microsoft's cloud storage solution for modern data storage scenarios. Azure Storage offers a massively scalable object store for data objects, a file system service for the cloud, a messaging store for reliable messaging, and a NoSQL store. Azure Storage is:

* **Durable and highly available**. Redundancy ensures that your data is safe if a transient hardware failure occurs. You can also opt to replicate data across datacenters or geographical regions for extra protection from local catastrophe or natural disaster. Data replicated in this way remains highly available in the event of an unexpected outage.
* **Secure**. All data written to Azure Storage is encrypted by the service. Azure Storage provides you with fine-grained control over who has access to your data.
* **Scalable**. Azure Storage is designed to be massively scalable to meet the data storage and performance needs of today's applications.
* **Managed**. Microsoft Azure handles hardware maintenance, updates, and critical issues for you.
* **Accessible**. Data in Azure Storage is accessible from anywhere in the world over HTTP or HTTPS. Microsoft provides client libraries for Azure Storage in various languages, including .NET, Java, Node.js, Python, Go, and others, and a mature REST API. Azure Storage supports scripting in Azure PowerShell or Azure CLI. And the Azure portal and Azure Storage Explorer offer easy visual solutions for working with your data.

## Azure Storage as a routing endpoint

There are two storage services that IoT Hub can route messages to:

* Azure Blob Storage
* Azure Data Lake Storage Gen2 (ADLS Gen2) accounts

Both services use blobs for their storage. Azure Data Lake Storage accounts are hierarchical namespace-enabled storage accounts built on top of blob storage.

IoT Hub supports writing data to Azure Storage in the Apache Avro format and in JSON format. The default is Avro. When using JSON encoding, you must set the `Content-Type` to `application/json` and `contentEncoding` to `UTF-8` in the message system properties. Both of these values are case-insensitive. If the content encoding is not set, then IoT Hub writes the messages in base 64 encoded format.

The encoding format can only be set when the blob storage endpoint is configured; it can't be edited for an existing endpoint. To switch encoding formats for an existing endpoint, you need to delete and re-create the custom endpoint with the format you want. One helpful strategy might be to create a new custom endpoint with your desired encoding format and add a parallel route to that endpoint. In this way, you can verify your data before deleting the existing endpoint.

## Securing access to storage accounts

Each time you access data in your storage account, your client application makes a request over HTTP/HTTPS to Azure Storage. By default, every resource in Azure Storage is secured, and every request to a secure resource must be authorized. Authorization ensures that the client application has the appropriate permissions to access a particular resource in your storage account.

Each authorization option is briefly described as follows:

* **Shared Key authorization** for blobs, files, queues, and tables. A client using Shared Key passes a header with every request that is signed using the storage account access key.

  Microsoft recommends that you disallow Shared Key authorization for your storage account. When Shared Key authorization is disallowed, clients must use Microsoft Entra ID or a user delegation SAS to authorize requests for data in that storage account.

* **Shared access signatures** for blobs, files, queues, and tables. Shared access signatures (SAS) provide limited delegated access to resources in a storage account via a signed URL. The signed URL specifies the permissions granted to the resource and the interval over which the signature is valid. A service SAS or account SAS is signed with the account key, while the user delegation SAS is signed with Microsoft Entra credentials and applies to blobs only.

* **Microsoft Entra** integration for authorizing requests to blob, queue, and table resources. Microsoft recommends using Microsoft Entra credentials to authorize requests to data when possible for optimal security and ease of use.

  You can use Azure role-based access control (Azure RBAC) to manage a security principal's permissions to blob, queue, and table resources in a storage account. You can also use Azure attribute-based access control (ABAC) to add conditions to Azure role assignments for blob resources.

* **Microsoft Entra Domain Services authentication** for Azure Files. Azure Files supports identity-based authorization over Server Message Block (SMB) through Microsoft Entra Domain Services. You can use Azure RBAC for granular control over a client's access to Azure Files resources in a storage account.

* **On-premises Active Directory Domain Services (AD DS, or on-premises AD DS) authentication** for Azure Files. Azure Files supports identity-based authorization over SMB through AD DS. Your AD DS environment can be hosted in on-premises machines or in Azure VMs. SMB access to Files is supported using AD DS credentials from domain joined machines, either on-premises or in Azure. You can use a combination of Azure RBAC for share level access control and NTFS DACLs for directory/file level permission enforcement.

* **Anonymous read access** for blob data is supported, but not recommended. When anonymous access is configured, clients can read blob data without authorization. We recommend that you disable anonymous access for all of your storage accounts.

* **Storage Local Users** can be used to access blobs with SFTP or files with SMB. Storage Local Users support container level permissions for authorization.
