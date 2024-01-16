Azure Blob Storage provides a convenient space for storing large quantities of data in a safe, reliable manner. You can use blobs to hold all types of data, ranging from individual files and graphics to an entire database. Blob storage is useful as a store for active data, but it's also ideally suited for acting as low-cost archive storage.

Imagine you're the DevOps administrator for a prototyping and engineering company. The company maintains an Azure Storage account that serves as a repository for client product designs, specifications, and supporting documentation. Your company has decided to move any inactive documents older than six months to a separate storage location. You want to use a new Azure Storage account for archiving.

The AzCopy utility was written specifically for transferring data into, out of, and between Azure Storage accounts.

A key strength of AzCopy over the Azure CLI is that all operations run asynchronously, and they're recoverable. AzCopy tracks the progress of copy operations, and if an operation fails, it can be restarted close to the point of failure. Additionally, you can tune the performance of the AzCopy to match the processing power and bandwidth available to your local machine.

As with the Azure CLI, AzCopy makes use of the Azure Storage service to transfer blobs between storage accounts.

In this module, you learn how to copy and move blobs between Azure Storage accounts using the AzCopy tool.

## Learning objectives

In this module, you will:

- Identify when to use synchronous and asynchronous methods for transferring blobs
- Copy and move blobs between Azure Storage accounts using the AzCopy tool

## Prerequisites

- Beginner-level knowledge of Azure Storage and blobs
