Blobs are *files for the cloud*. Apps work with blobs in much the same way as they work with files on a disk. Apps read and write data to blobs. However, unlike a local file, you can reach blobs from anywhere with an internet connection.

Azure Blob Storage is *unstructured*. There are no restrictions on the kinds of data it can hold. For example, a blob can hold a PDF document, a JPG image, a JSON file, video content, and more. 

Blobs aren't limited to common file formats. A blob could contain gigabytes of binary data streamed from a scientific instrument, an encrypted message for another application, or data in a custom format for an app you're developing.

Blobs aren't efficient for structured data that needs to be queried frequently. They have higher latency than memory and local disks. They don't have the indexing features that make databases efficient at running queries. However, blobs are frequently used *in combination* with databases to store nonqueryable data. For example, an app with a database of user profiles could store profile pictures in blobs. Each user record in the database would include the name or URL of the blob that contains the user's picture.

Blobs are used for data storage in many ways across all kinds of apps and architectures:

- Apps that need to transmit large amounts of data using a messaging system that only supports small messages. These apps can store data in blobs and send the blob URLs in messages.
- Blob Storage can be used like a file system for storing and sharing documents and other personal data.
- Static web assets like images can be stored in blobs and made available for public download as if they were files on a web server.
- Many Azure components use blobs behind the scenes. For example, Azure Cloud Shell stores your files and configuration in blobs, and Azure Virtual Machines uses blobs for hard-disk storage.

Some apps constantly create, update, and delete blobs as part of their work. Others use a small set of blobs and rarely change them.

## Storage accounts, containers, tags, and metadata

In Blob Storage, every blob lives inside a *blob container*. You can store an unlimited number of blobs in a container and an unlimited number of containers in a storage account. Containers are *flat*. They can only store blobs, not other containers.

Blobs and containers support tags and metadata in the form of name-value string pairs. Your apps can use tags and metadata for anything, such as a human-readable description of a blob's contents to display or a string that your app uses to determine how to process the data.

> [!TIP]
> Blob Storage does not provide any mechanism for searching or sorting blobs by metadata. You can search and sort blobs by using Blob index tags. For information about using Azure Cognitive Search, see the *Further Reading* section at the end of this module.

## Blob Storage API and client libraries

The [Blob Storage API](/rest/api/storageservices/blob-service-rest-api) is REST-based. The client libraries of many popular languages support it. The API lets you write apps that create and delete blobs and containers, upload and download blob data, and list the blobs in a container.
