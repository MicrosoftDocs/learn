## Introduction to Azure Storage

Azure Storage is a Microsoft cloud-storage solution for modern data-storage scenarios. Azure Storage offers a massively scalable object store for data objects, a file system service for the cloud, a messaging store for reliable messaging, and a NoSQL store. 

Azure Storage is:

- **Durable and highly available**: Redundancy ensures that your data is safe in the event of transient hardware failures. You can also opt to replicate data across datacenters or geographical regions for additional protection from local catastrophe or natural disaster. Data that's replicated in this way remains highly available in the event of an unexpected outage. 
- **Secure**: All data that's written to Azure Storage is encrypted by the service. With Azure Storage, you get fine-grained control over who can access your data.
- **Scalable**: Azure Storage is designed to be massively scalable to meet the data storage and performance needs of today's applications. 
- **Managed**: Microsoft Azure handles maintenance and any critical problems for you.
- **Accessible**: Data in Azure Storage is accessible from anywhere in the world over HTTP or HTTPS. Microsoft provides SDKs for Azure Storage in a variety of languages: .NET, Java, Node.js, Python, PHP, Ruby, Go, and others, as well as a mature REST API. Azure Storage supports scription in Azure PowerShell or Azure CLI. And the Azure portal and Azure Storage Explorer offer easy visual solutions for working with your data.  

## Azure Storage services

Azure Storage includes these data services: 

- **Azure Blobs**: A massively scalable object store for text and binary data.
- **Azure Files**: Managed file shares for cloud or on-premises deployments.
- **Azure Queues**: A messaging store for reliable messaging between application components. 
- **Azure Tables**: A NoSQL store for schemaless storage of structured data.

Each service is accessed through a storage account. 

For this tutorial, we use Blob storage.

### Blob storage

Azure Blob storage is a Microsoft object-storage solution for the cloud. Blob storage is optimized for storing massive amounts of unstructured data, such as text or binary data. 

Blob storage is ideal for:

* Serving images or documents directly to a browser.
* Storing files for distributed access.
* Streaming video and audio.
* Storing data for backup and restore, disaster recovery, and archiving.
* Storing data for analysis by an on-premises or Azure-hosted service.

Objects in Blob storage can be accessed from anywhere in the world via HTTP or HTTPS. Users or client applications can access blobs via URLs, the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage client library. The storage client libraries are available for multiple languages, including .NET, Java, Node.js, Python, PHP, and Ruby.

Now, let's get started hosting our web app in Azure Storage.