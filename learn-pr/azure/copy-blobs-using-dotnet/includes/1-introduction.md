Azure Blob Storage provides a convenient space for storing large quantities of data in a safe, reliable manner. You can use blobs to hold all types of data, ranging from individual files and graphics to an entire database. Blob Storage is useful as a store for active data, and is also ideally suited for acting as low-cost archive storage.

Imagine you're the DevOps administrator for a prototyping and engineering company. The company maintains an Azure Storage account that serves as a repository for client product designs, specifications, and supporting documentation. Your company decides to move any inactive documents older than six months to a separate storage location. You want to use a new Azure Storage account for archiving.

The .NET Storage Client library is a collection of objects and methods you can use to build custom applications that manipulate items held in Azure Storage. You can construct your own applications to upload, download, and migrate blobs between storage accounts. You can incorporate your code into existing applications, and you can deploy your code to various environments, such as Azure Functions.

The .NET Storage Client library provides full access to the metadata for a blob, and you can access any properties of a blob. This feature allows you, for example, to select a blob based on its last modified time, creation time, or any other available attribute.

The .NET Storage Client library implements asynchronous operations, letting you take full programmatic advantage of the multitasking capabilities of the .NET Framework.

The .NET Storage Client library requires a development investment, and might not be suitable for quick, one-off jobs. However, if you have a complex task that is frequently repeated, the investment could be worthwhile.

In this module, you learn how to copy and move blobs between Azure Storage accounts using the .NET Client Library.

## Learning objectives

In this module, you will:

- Identify when to use synchronous and asynchronous methods for transferring blobs.
- Copy and move blobs between Azure storage accounts using the .NET Storage Client library.

## Prerequisites

- Beginner-level knowledge of Azure Storage and blobs.