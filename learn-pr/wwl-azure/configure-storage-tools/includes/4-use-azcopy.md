An alternative method for transferring data is **AzCopy**. AzCopy v10 is the next-generation command-line utility for copying data to/from Microsoft Azure Blob and File storage, which offers a redesigned command-line interface and new architecture for high-performance reliable data transfers. Using AzCopy, you can copy data between a file system and a storage account, or between storage accounts.

## New features

Synchronize a file system to Azure Blob or vice versa. Ideal for incremental copy scenarios.

 -  Supports Azure Data Lake Storage Gen2 APIs.
 -  Supports copying an entire account (Blob service only) to another account.
 -  Account to account copy is now using the new Put from URL APIs. No data transfer to the client is needed which makes the transfer faster.
 -  List/Remove files and blobs in a given path.
 -  Supports wildcard patterns in a path, --include flags, and --exclude flags.
 -  Improved resiliency: every AzCopy instance will create a job order and a related log file. You can view and restart previous jobs and resume failed jobs. AzCopy will also automatically retry a transfer after a failure.
 -  General performance improvements.

## Authentication options

 -  **Azure Active Directory** (Supported for Blob and ADLS Gen2 services). Use .\\azcopy login to sign in using Azure Active Directory. The user should have *Storage Blob Data Contributor* role assigned to write to Blob storage using Azure Active Directory authentication.
 -  **SAS tokens** (supported for Blob and File services). Append the SAS token to the blob path on the command line to use it.

## Getting started

AzCopy has a simple self-documented syntax. Here's how you can get a list of available commands:

```
AzCopy --help

```

The basic syntax for AzCopy commands is:

```
azcopy copy [source] [destination] [flags]

```

> [!NOTE]
> AzCopy is available on Windows, Linux, and macOS.
