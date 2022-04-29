Azure Blob Storage provides a convenient space for storing large quantities of data in a safe, reliable manner. You can use blobs to hold all types of data, ranging from individual files and graphics to an entire database. Blob storage is useful as a store for active data, but it's also ideally suited for acting as low-cost archive storage.

Imagine you're the DevOps administrator for a prototyping and engineering company. The company maintains an Azure Storage account that serves as a repository for client product designs, specifications, and supporting documentation. Your company has decided to move any inactive documents older than six months to a separate storage location. You'll use a new Azure Storage account for archiving.

In this module, you'll learn about several common techniques for moving data in and out of blob storage, and how to transfer blobs between storage accounts.

## Learning objectives

In this module, you will:

- Identify when to use synchronous and asynchronous methods for transferring blobs
- Copy and move blobs between Azure storage accounts using .NET Storage Client library
- Copy and move blobs between Azure storage accounts using the Azure CLI
- Copy and move blobs between Azure storage accounts using the AzCopy tool

## Prerequisites

- Beginner-level knowledge of Azure storage and blobs
- Beginner-level knowledge C# .NET
