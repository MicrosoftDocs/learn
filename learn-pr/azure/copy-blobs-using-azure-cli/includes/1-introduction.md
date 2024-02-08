Azure Blob Storage provides a convenient space for storing large quantities of data in a safe, reliable manner. You can use blobs to hold all types of data, ranging from individual files and graphics to an entire database. Blob Storage is useful as a store for active data, but is also ideally suited for acting as low-cost archive storage.

Imagine you're the DevOps administrator for a prototyping and engineering company. The company maintains an Azure Storage account that serves as a repository for client product designs, specifications, and supporting documentation. Your company decides to move any inactive documents older than six months to a separate storage location. You want to use a new Azure Storage account for archiving.

The Azure CLI provides access to Azure Storage through the `az storage` series of commands.

The basic commands to upload and download blobs between Blob Storage and the local file system are synchronous. Transferring a large blob could potentially take several hours, depending on the network bandwidth available. Additionally, if a transfer fails partway through, there's no simple way of restarting the operation from the point of failure; you must repeat the entire operation.

You can transfer blobs between containers and storage accounts using the `az storage blob copy` command. Unlike the upload and download operations, this command runs asynchronously and uses the Azure Storage service to manage the copy process. This means you don't have to download and upload blobs via local storage to migrate them between accounts. You can track the progress and cancel the operation if necessary. The command also supports a batch mode that lets you copy multiple blobs.

In this module, you learn how to copy and move blobs between Azure Storage accounts using the Azure CLI.

## Learning objectives

In this module, you will:

- Identify when to use synchronous and asynchronous methods for transferring blobs.
- Copy and move blobs between Azure Storage accounts using the Azure CLI.

## Prerequisites

- Beginner-level knowledge of Azure Storage and blobs.