Storage accounts provide a flexible solution that keeps data as files, tables, and messages. With Azure Storage Explorer, it's easy to read and manipulate this data.

You want to enable your engineers to manage the data stored in Azure Storage so they can maintain the data that your CRM application uses. You want to assess whether they can use Storage Explorer for this purpose.

Here, you'll learn about Storage Explorer and how you can use it to manage data from multiple storage accounts and subscriptions. You'll learn different ways of using Storage Explorer to connect to your data, Azure Stack, and data held in Azure Data Lake Storage.

## What is Storage Explorer?

Storage Explorer is a GUI application developed by Microsoft to simplify accessing and managing data stored in Azure storage accounts. Storage Explorer is available on Windows, macOS, and Linux.

Some of the benefits of using Storage Explorer are:

- It's easy to connect to and manage multiple storage accounts.
- The interface lets you connect to Data Lake Storage.
- You can also use the interface to update and view entities in your storage accounts.
- Storage Explorer is free to download and use.

With Storage Explorer, you can use a range of storage and data operation tasks on any of your Azure storage accounts. These tasks include edit, download, copy, and delete.

### Supported software versions

The Azure Storage Explorer application runs on the following versions of these platforms:

| Operating system | Versions                                                |
| ---------------- | ------------------------------------------------------ |
| Windows          | Windows 11, Windows 10, Windows 8, or Windows 7      |
| macOS            | macOS 10.12 Sierra and later                           |
| Linux            | Ubuntu 18.04 x64, Ubuntu16.04 x64, or Ubuntu 14.04 x64 |

### Azure Storage types

Azure Storage Explorer can access many different data types from services like these:

- **Azure Blob Storage**: Blob storage is used to store unstructured data as a binary large object (blob).
- **Azure Table Storage**: Table storage is used to store NoSQL, semi-structured data.
- **Azure Queue Storage**: Queue storage is used to store messages in a queue, which can then be accessed and processed by applications through HTTP(S) calls.
- **Azure Files**: Azure Files is a file-sharing service that enables access through the Server Message Block protocol, similar to traditional file servers.
- **Azure Data Lake Storage**: Azure Data Lake, based on Apache Hadoop, is designed for large data volumes and can store unstructured and structured data. Azure Data Lake Storage Gen1 is a dedicated service. Azure Data Lake Storage Gen2 is Azure Blob Storage with the hierarchical namespace feature enabled on the account.

### Manage multiple storage accounts in multiple subscriptions

If you have multiple storage accounts across multiple subscriptions in your Azure tenant, managing them through the Azure portal can be time consuming. Storage Explorer lets you manage the data stored in multiple Azure storage accounts and across Azure subscriptions.

### Use local emulators

During the development phase of your project, you might not want developers to incur additional costs by using Azure storage accounts. In those cases, you can use a locally based emulator. Storage Explorer supports two emulators: Azure Storage Emulator and Azurite.

- Azure Storage Emulator uses a local instance of Microsoft SQL Server 2012 Express LocalDB. It emulates Azure Table, Queue, and Blob storage.
- Azurite, which is based on Node.js, is an open-source emulator that supports most Azure Storage commands through an API.

Storage Explorer requires the emulator to be running before you open it. Connecting to your emulator is no different than connecting to Azure storage accounts except that you'll choose the **Attach to a local emulator** connection type.

All locally emulated storage connection types appear in **Local & Attached** > **Storage accounts**.

## Connecting Storage Explorer to Azure

There are several ways to connect your Storage Explorer application to your Azure storage accounts.

You need two permissions to access your Azure storage account: management and data. However, you can use Storage Explorer with only the data-layer permission. The data layer requires the user to be granted, at a minimum, a read data role. The nature of the read/write role should be specific to the type of data stored in the storage account. The data layer is used to access blobs, containers, and other data resources.

The management role grants access to view lists of your various storage accounts, containers, and service endpoints.

### Connection types

There are many ways to connect an Azure Storage Explorer instance to your Azure resources. For example:

- Add resources by using Azure Active Directory (Azure AD)
- Use a connection string
- Use a shared access signature URI
- Use a name and key
- Attach to a local emulator
- Attach to Azure Data Lake Storage by using a URI

We'll explore a few of these connection types, and provide an overview of the required steps to set up the connection.

### Add an Azure account by using Azure AD

Use this connection type when the user can access the data layer. You can use it only to create an Azure Data Lake blob container or a standard blob container. Connecting to Azure Storage through Azure AD requires more configuration than the other methods. The account that you use to connect to Azure must have the correct permissions and authorization to access the target resources.

To add a resource by using Azure AD:

1. Open Storage Explorer.
1. Select the **Sign in with Azure** option and sign in to Azure.
1. Connect to your Azure storage account.
1. Select **Add a resource via Azure AD**, and then choose the Azure tenant and the associated account.
1. When you're prompted, provide the type of resource that you're connecting to.
1. Review and verify the connection details, and then select **Connect**.

It's crucial to select the correct resource type because it changes the information that you need to enter.

Any connections that you create through this approach will appear in the resource tree, in this branch: **Local & attached** > **Storage Accounts** > **Attached Containers** > **Blob**.

### Connect by using a shared access signature URI

A shared access signature (SAS) URI is an unambiguous identifier that's used to access your Azure Storage resources.

With this connection method, you'll use a SAS URI for the required storage account. You'll need a SAS URI whether you want to use a file share, table, queue, or blob container. You can get a SAS URI either from the Azure portal or from Storage Explorer. For more information, see [Create an account SAS](/rest/api/storageservices/create-account-sas?redirectedfrom=MSDN).

To add a SAS connection:

1. Open Storage Explorer.
1. Connect to your Azure storage account.
1. Select the connection type: **Shared access signature URI (SAS)**.
1. Provide a meaningful name for the connection.
1. Provide the SAS URI.
1. Review and verify the connection details, and then select **Connect**.

When you've added a connection, it appears in the resource tree as a new node. You'll find the connection node in this branch: **Local & attached** > **Storage Accounts** > **Attached Container** > **Service**.

### Connect by using a storage account name and key

To connect to a storage account on Azure quickly, you use the account key that's associated with the storage. To find the storage access keys from the Azure portal, go to the correct storage account page and select **access keys**.

To add a connection:

1. Open Storage Explorer.
1. Connect to your Azure storage account.
1. Select the connection type: **Storage account name and key**.
1. Provide a meaningful name for the connection.
1. When you're prompted, provide the name of the storage account and either of the account keys needed to access it.
1. From the provided list, select the storage domain that you want to use.
1. Review and verify the connection details, and then select **Connect**.

When the connection is added, it appears in the resource tree as a connection node. The connection node is in this branch: **Local & attached** > **Storage Accounts**.

### Manage Data Lake Storage Gen1

You can use Storage Explorer to access and manage data stored in Data Lake Storage Gen1.

To connect to a Data Lake service, you'll need the URI associated with the data lake. Using a URI allows you to access resources that aren't in your subscription. When you have the URI of the resource that you want to access, you connect to it by using the **Data Lake Storage Gen1** option.
