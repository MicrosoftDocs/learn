Storage accounts provide a flexible solution that keeps data as files, tables, and messages. With Storage Explorer, it's easy to read and manipulate this data.

You want to enable your engineers to manage the data kept in Azure Storage, so they can maintain the data used by your Customer Relationship Management (CRM) system. But you don't wish to burden them with learning about complex tools. You want to assess whether they can use Azure Storage Explorer for this purpose.

Here, you'll learn about Azure Storage Explorer, and how you can use it to manage data from multiple storage accounts and subscriptions. You'll learn different ways of using Azure Storage Explorer to connect to your data, the Azure Stack, and data held in Cosmos DB and Azure Data Lakes.

## What is Azure Storage Explorer?

Azure Storage Explorer was released in 2016. It's a GUI application developed by Microsoft to simplify access to, and the management of, data stored on one or more Azure Storage accounts. Storage Explorer is available on Windows, macOS, and Linux.

Some of the benefits of using Azure Storage Explorer are:

- It's easy to connect to and manage multiple storage accounts
- The user interface lets you connect to Azure Data Lakes and Azure Cosmos DB
- An easy-to-use interface lets you update and view entities in your storage accounts
- Azure Storage Explorer is free to download and use

With Azure Storage Explorer, you can use a range of storage and data operation tasks, including edit, download, copy, and data deletion, on any of your Azure Storage accounts. 

### Supported software versions

The Azure Storage Explorer application runs on the following versions of these platforms:

| Operating System | Version                                                |
| ---------------- | ------------------------------------------------------ |
| Windows          | Windows 10 (Recommended), Windows 8, or Windows 7      |
| macOS            | macOS 12.12 Sierra and later                           |
| Linux            | Ubuntu 18.04 x64, Ubuntu16.04 x64, or Ubuntu 14.04 x64 |

### Azure Storage types

Azure Storage Explorer can access many different data types. We'll explore a couple of them here.

- **Blob storage.** Blob storage is used to store unstructured data as a binary large object (blob). Azure Blob storage offers two access types: hot and cold. Hot is used for frequently accessed data, and cold for less frequently accessed data.
- **Table storage.** Table storage is used to store NoSQL, semi-structured data. While it's called table storage, it uses a schemaless design based on groups of entities.
- **File storage.** File storage is a file-sharing service. Your organization could use file storage as part of a migration process to move data to the cloud. It can also be used to store logs, diagnostic data, and application settings.
- **Data Lake Storage.** Azure Data Lake, based on Apache Hadoop, is designed for large data volumes and can store unstructured and structured data. Azure Data Lake has strong integration with Azure HDInsight and Azure Data Analytics.

### Manage multiple storage accounts in multiple subscriptions

If you have multiple storage accounts across multiple subscriptions in your Azure tenant, it can be time-consuming to attempt to manage them through the Azure portal. Azure Storage Explorer provides the means to manage the data stored in your Azure Storage accounts. It lets you manage one or more Azure subscriptions, and one or more storage accounts.

### Manage your Azure Stack

The Azure Stack allows you to have an Azure instance on your on-premises network, without needing the cloud. It's ideally suited to government or private organizations that need to keep their assets and resources out of the cloud. Azure Stack uses a subset of the cloud Azure features. Azure Stack behaves like a cloud-based version.

You can use Azure Storage Explorer to connect to both an Azure Cloud or an Azure Stack. Access to the Azure Stack requires a direct connection provided by a Base-64 encoded root certificate. You import this certificate into Azure Storage Explorer. 

The following steps provide an overview of how to get the certificate and apply it through Azure Storage Explorer.

To get the certificate:

1. Start a Microsoft Management Console (MMC) session on your Azure Stack, or locally via a VPN to the Azure Stack.
1. Select **File**, then **Add/Remove snap-in**, and **Certificates** from the available snap-ins list.

    ![Screenshot showing the Microsoft management console, certificate selection dialogue](../media/2-mmc-snap-in-certificate.png)

1. Next, select the correct **Computer account** and **local computer** options.
1. Find the **AzureStackSelfSignedRootCert**, which you'll see here:  **Console Root\Certificated (Local Computer)\Trusted Root Certification Authorities\Certificates**.
1. Finally, export the certificate as a **Base-64 encoded X.509 (.CER)** file.

Applying the certificate:

1. Launch Storage Explorer and don't connect to an Azure Storage account.
1. From the **Edit** menu, select **SSL Certificate** and use the **Import Certificate** option.
1. Import the root certificate you exported earlier.
1. Restart Storage Explorer for the certificate to be applied correctly.
1. When Storage Explorer is running, check to see if the **Target Azure Stack API** is selected.

You can use Storage Explorer to manage your Azure Stack storage accounts in the same way you use the Azure portal.

### Manage your local emulators

During the development phase of your project, you might not want developers to incur additional costs by using Azure Storage accounts. In those cases, you can use a locally based Microsoft Azure Storage Emulator. Storage Explorer supports two emulators: Microsoft Azure Storage Emulator and Azurite.

- Microsoft Azure Storage Emulator uses a local instance of Microsoft SQL Server 2012 Express localDB. It emulates the Azure Table, Queue, and Blob services. 
- Azurite, which is based on Node.js, is an open-source Azure Storage emulator that supports most Azure Storage commands through an API.

Storage Explorer requires the emulator to be running before you launch it. Connecting to your emulator is no different from connecting to Azure Storage accounts. However, you'll choose the **Attach to a local emulator** connection type.

All locally emulated storage connection types will appear in the **Local & Attached** > **Storage accounts**.

### Manage Cosmos DB and Azure Data Lake

You use Storage Explorer to access and manage data stored in Azure Cosmos DB and Azure Data Lake.

To connect to a Cosmos DB service, you'll need to use a connection string. You get a connection string by accessing the Cosmos DB configuration through the Azure portal. 

To connect to an Azure Data Lake service, you'll need the URI associated with the data lake. Presently, only Data Lake Storage Gen 1 is supported by Storage Explorer. Data Lake Storage Gen 2 is currently in preview, and support will be available through Storage Explorer. Using a URI allows you to access resources that aren't in your subscription. When you have the URI of the resource you want to access, you connect to it using the **Data Lake Storage Gen1** option.

## Connecting Storage Explorer to Azure

There are several ways to connect your Storage Explorer application to your Azure Storage accounts.

To access your Azure Storage account or accounts requires two permissions: management and data. However, you can use Storage Explorer with only the data layer permission. The data layer requires the user to be granted, at a minimum, a read data role. The nature of the read/write role should be specific to the type of data stored in the storage account. The data layer is used to access blobs, containers, and other data resources. 

The management role grants access to see lists of your various storage accounts, containers, and service endpoints.

### Connection types

There are many ways to connect an Azure Storage Explorer instance to your Azure resources. For example:

- Add resources using Azure AD
- Use a connection string
- Use a shared access signature URI
- Use a name and key
- Attach to a local emulator
- Attach to an Azure Cosmos DB through a connection string
- Attach to an Azure Data Lake using a URI

We'll explore a few of these connection types, and provide an overview of the required steps to set up the connection.

### Add an Azure account using Azure AD

Use this connection type when the user can access the data layer. It can only be used to create either an Azure Data Lake Blob container or a standard blob container. Connecting to Azure Storage through Azure AD requires more configuration than the other methods. The account you use to connect to Azure must have the correct permissions and authorization to access the target resources.

To add a resource using Azure AD:

1. Launch Azure Storage Explorer.
1. Select the **Add an Azure Account** option and sign in to Azure.
1. **Connect** to your Azure Storage.
1. Select **Add a resource via Azure AD**, then choose the Azure tenant and the associated account.
1. When prompted, provide the type of resource you're connecting to.
1. Review and verify the connection details, and then select **Connect**.

It's crucial to select the correct resource type as it changes the information you need to enter.

Any connections created using this approach will appear in the resource tree in the branch: **Local & attached** > **Storage Accounts** > **Attached Containers** > **Blob**.

### Connect using a shared access signature URI

A Shared Access Signature (SAS) URI is an unambiguous identifier used to access your Azure Storage resources.

With this connection method, you'll use a SAS URI for the required storage account. You'll need a SAS URI whether you want to use a file share, table, queue, or blob container. A SAS URI can be obtained either from the Azure portal or from Storage Explorer.

To add a SAS connection:

1. Launch Azure Storage Explorer.
1. **Connect** to your Azure Storage.
1. Select the connection type: **shared access signature (SAS) URI**.
1. Provide a meaningful name for the connection.
1. When prompted, provide the **shared access signature URI**.
1. Review and verify the connection details, and then select **Connect**.

When you've added a connection, it appears in the resource tree as a new node. You'll find the connection node in the resource tree, in the branch: **Local & attached** > **Storage Accounts** > **Attached Container** > ***Service***.

### Connect using a storage account name and key

To connect to a storage account on Azure quickly, you use the account key associated with the storage. To find the storage access keys from the Azure portal, go to the correct storage account page and select **access keys**.

To add a connection:

1. Launch Azure Storage Explorer.
1. Connect to your Azure Storage.
1. Select the connection type: **storage account name and key**.
1. Provide a meaningful name for the connection.
1. When prompted, provide the name of the storage account and either of the account keys needed to access it.
1. From the provided list, select the storage domain you want to use.
1. Review and verify the connection details, and then select **Connect**.

When the connection is added, it appears in the resource tree as a connection node. The connection node is found in the resource tree, in the branch: **Local & attached** > **Storage Accounts**.