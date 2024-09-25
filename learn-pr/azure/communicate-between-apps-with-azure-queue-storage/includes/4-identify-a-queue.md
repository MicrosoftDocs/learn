Now that we have a storage account, let's look at how to work with the queue that it holds.

To access a queue, you need three pieces of information:

- Storage account name
- Queue name
- Authorization token

This information is used by both applications that talk to the queue, the web front end that adds messages and the mid-tier that processes them.

## Queue identity

Every queue has a name that you assign during creation. The name must be unique within your storage account but doesn't need to be globally unique (unlike the storage account name).

The combination of your storage account name and your queue name uniquely identifies a queue.

## Access authorization

Every request to a queue must be authorized and there are several options to choose from.

| Authorization type | Description |
|--------------------|-------------|
| **Microsoft Entra ID** | You can use role-based authentication and identify specific clients based on Microsoft Entra credentials. |
| **Shared Key** | An encrypted key signature associated with the storage account that is sometimes referred to as an **account key**. Every storage account has two of these keys that can be passed with each request to authenticate access. Using this approach is like using a root password - it provides *full access* to the storage account. |
| **Shared access signature** | A shared access signature (SAS) is a generated URI that grants limited access to objects in your storage account to clients. You can restrict access to specific resources, permissions, and scope the restrictions to a date range, so that it automatically turns off access after a period of time.  |

> [!IMPORTANT]
> We will use the account key authorization because it is the simplest way to get started working with queues. However, for optimal security, Microsoft recommends using Microsoft Entra ID with managed identities to authorize requests queue data, whenever possible. Authorization with Microsoft Entra ID and managed identities provides superior security and ease of use over Shared Key authorization. To learn more about managed identities, see [What are managed identities for Azure resources](/entra/identity/managed-identities-azure-resources/overview). For an example of how to enable and use a managed identity for a .NET application, see [Authenticating Azure-hosted apps to Azure resources with .NET](/dotnet/azure/sdk/authentication/azure-hosted-apps).
>
> For scenarios where shared access signatures (SAS) are used, Microsoft recommends using a user delegation SAS. A user delegation SAS is secured with Microsoft Entra credentials instead of the account key. To learn about shared access signatures, see [Grant limited access to data with shared access signatures](/azure/storage/common/storage-sas-overview.md). For an example of how to create and use a user delegation SAS with .NET, see [Create a user delegation SAS for a blob with .NET](/azure/storage/blobs/storage-blob-user-delegation-sas-create-dotnet).

### Retrieve the connection string

A connection string is a string that combines a storage account name and account key and must be known to the application to access the storage account. The format looks like this:

```console
"DefaultEndpointsProtocol=https;AccountName=<your storage account name>;AccountKey=<your key>;EndpointSuffix=core.windows.net"
```

You can retrieve the connection string from the  **Security + Networking** > **Access keys** section of your storage account in the Azure portal, or you can retrieve it through the command line using the Azure CLI:

```azurecli
az storage account show-connection-string -g <resource group name> --output tsv -n <storage account name>
```

### Use the Azure.Storage.Queues package for .NET

The Azure.Storage.Queues package is part of the Azure SDK for .NET. This package provides a programmatic way to access Azure storage queues from .NET code. Access using the package requires the use of your connection string and the name of the queue.

> [!WARNING]
> This connection string value should be stored in a secure location. Anyone who has access to this connection string is able to manipulate the queue.

Let's get our connection string from Azure and set up a new application to use it.
