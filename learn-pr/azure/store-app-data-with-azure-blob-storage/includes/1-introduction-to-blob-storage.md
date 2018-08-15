**TODO motivation and lead-in. Taking suggestions from reviewers.**

## What are blobs, and how are they used?

Blobs are "files for the cloud". Apps work with blobs in much the same way as they would work with files on a disk, reading and writing data, but blobs can be reached from anywhere with an internet connection. Blob storage is *unstructured*, meaning that there are no restrictions on the kinds of data you can store in a blob. Blobs used by your app might contain PDF documents, JPG images or JSON objects, for example, but they're not limited to common file formats &mdash; a blob could contain gigabytes of binary data streamed from a scientific instrument, an encrypted message for another application, or data in a custom format for an app you're developing.

Like files, blobs are usually not a good place for structured data that needs to be queried frequently. They have higher latency than memory and local disk, and don't have the indexing features that make databases efficient at running queries. However, blobs are frequently used in *combination* with databases to store non-queryable data. For example, an app with a database of user profiles could store profile pictures in blobs. Each user record in the database would include the name or URL of the blob containing user's picture.

Blobs are used for data storage in many different ways across all kinds of applications and architectures:

* Apps that need to communicate large amounts of data over a messaging system that only supports small messages can store data in blobs and send the blob URLs in messages.
* Blob storage can be used like a filesystem for storing and sharing documents and other personal data.
* Static web assets like images can be stored in blobs and made available for public download as if they were files on a webserver.
* Many Azure components use blobs behind the scenes: if you use a Cloud Shell, like the one in this module, the files and configuration you create are stored in blobs. Azure virtual machine disks are stored in blobs as well.

Some apps will constantly create, update and delete blobs as part of their work. Others will use a small set of blobs and rarely change them.

## Storage accounts, containers and metadata

In Blob storage, every blob lives inside a *blob container*. You can store an unlimited number of blobs in a container, and an unlimited number of containers in a storage account. Containers are "flat" &mdash; they can only store blobs, not other containers.

**TODO replace this image with something better**

![Accounts, containers and blobs](../images/blob1.png)

Blobs and containers support metadata in the form of name-value string pairs. Your apps can use metadata for anything you like: for example, a human-readable description of a blob's contents to be displayed by the application, or a string that your app uses to determine how to process the blob's data.

> [!NOTE]
> Blob storage does not provide any mechanism for searching or sorting blobs by metadata. See the Additional Resources section at the end of this module for information about using Azure Search to achieve this.

## The Blob storage API and client libraries

The Blob storage API is REST based and supported by client libraries in many popular languages. Operations we'll be looking at in this module include creating and deleting blobs and containers, uploading and downloading blob data, and listing blobs in a container.