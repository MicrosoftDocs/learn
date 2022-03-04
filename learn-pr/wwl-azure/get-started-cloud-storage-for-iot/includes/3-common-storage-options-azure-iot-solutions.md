There is a wide variety of cloud storage options available to architects who are designing Azure IoT solutions. Each solution has design considerations that must be weighed.

Azure storage options that are commonly found in IoT solutions include:

 -  Azure Blob Storage and Azure Data Lake Gen2, which are both available as Azure IoT Hub routing endpoints.
 -  Azure Cosmos DB and Azure SQL Database, which are both available as Azure Stream Analytics outputs.

## Azure Storage characteristics

Azure Storage is Microsoft's cloud storage solution for modern data storage scenarios. Azure Storage offers a massively scalable object store for data objects, a file system service for the cloud, a messaging store for reliable messaging, and a NoSQL store. Azure Storage is:

 -  Durable and highly available. Redundancy ensures that your data is safe if a transient hardware failure occurs. You can also opt to replicate data across datacenters or geographical regions for extra protection from local catastrophe or natural disaster. Data replicated in this way remains highly available in the event of an unexpected outage.
 -  Secure. All data written to Azure Storage is encrypted by the service. Azure Storage provides you with fine-grained control over who has access to your data.
 -  Scalable. Azure Storage is designed to be massively scalable to meet the data storage and performance needs of today's applications.
 -  Managed. Microsoft Azure handles hardware maintenance, updates, and critical issues for you.
 -  Accessible. Data in Azure Storage is accessible from anywhere in the world over HTTP or HTTPS. Microsoft provides client libraries for Azure Storage in various programming languages, including .NET, Java, Node.js, Python, PHP, Ruby, Go, and others, and a mature REST API. Azure Storage supports scripting in Azure PowerShell or Azure CLI. And the Azure portal and Azure Storage Explorer offer easy visual solutions for working with your data.

## Azure Storage as a routing endpoint

There are two storage services that IoT Hub can route messages to -- Azure Blob Storage and Azure Data Lake Storage Gen2 (ADLS Gen2) accounts. Azure Data Lake Storage accounts are hierarchical namespace-enabled storage accounts built on top of blob storage. Both of these use blobs for their storage.

IoT Hub supports writing data to Azure Storage in the Apache Avro format and in JSON format. The default is AVRO. When using JSON encoding, you must set the contentType to application/json and contentEncoding to UTF-8 in the message system properties. Both of these values are case-insensitive. If the content encoding is not set, then IoT Hub will write the messages in base 64 encoded format.

The encoding format can only be set when the blob storage endpoint is configured; it can't be edited for an existing endpoint. To switch encoding formats for an existing endpoint, you'll need to delete and re-create the custom endpoint with the format you want. One helpful strategy might be to create a new custom endpoint with your desired encoding format and add a parallel route to that endpoint. In this way, you can verify your data before deleting the existing endpoint.
