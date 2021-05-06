Azure doesn't include any process to move blobs. To perform a move, you'll first copy the data and then delete the source data. Azure does provide several tools you can use to copy blobs to a destination.

In this unit, you'll learn about three common cross-platform tools that you can use to perform these tasks:
- Azure CLI
- AzCopy utility
- .NET Storage Client library

## Azure CLI

The Azure CLI provides access to Azure Storage through the `az storage` series of commands.

The basic commands to upload and download blobs between blob storage and the local file system are synchronous. Transferring a large blob could potentially take several hours, depending on the network bandwidth available. Additionally, if a transfer fails part way through, there's no simple way of restarting the operation from the point of failure; you must repeat the entire operation.

You transfer blobs between containers and storage accounts using the `az storage blob copy` command. Unlike the upload and download operations, this command runs asynchronously and uses the Azure Storage service to manage the copy process. This means you don't have to download and upload blobs via local storage to migrate them between accounts. You can track the progress, and cancel the operation if necessary. This command also supports a batch mode that enables you to copy multiple blobs.

## AzCopy utility

The AzCopy utility was written specifically for transferring data into, out of, and between Azure Storage accounts.

A key strength of AzCopy over the Azure CLI is that all operations run asynchronously, and they're recoverable. The AzCopy command tracks the progress of copy operations, and if an operation fails, it can be restarted close to the point of failure. Additionally, you can tune the performance of the AzCopy command to match the processing power and bandwidth available to your local machine.

As with the Azure CLI, AzCopy makes use of the Azure Storage service to transfer blobs between storage accounts.

The AzCopy command lacks the ability to select blobs based on their modification dates. However, AzCopy does provide comprehensive support for hierarchical containers and blob selection by pattern matching (two features not available with the Azure CLI).

## .NET Storage Client library

The .NET Storage Client library is a collection of objects and methods that you can use to build custom applications that manipulate items held in Azure Storage. You can construct your own applications to upload, download, and migrate blobs between storage accounts. You can incorporate your code into existing applications, and you can deploy your code to a variety of environments, such as Azure Functions.

The .NET Storage Client library provides full access to the metadata for a blob, and you can access any properties of a blob. This feature enables you, for example, to select a blob based on its last modified time, creation time, or any other available attribute.

The .NET Storage Client library implements asynchronous operations, enabling you to take full programmatic advantage of the multitasking capabilities of the .NET Framework.

The .NET Storage Client library requires a development investment, and may not be suitable for quick, one-off jobs. However, if you have a complex task that is frequently repeated, this investment could be worthwhile.
