Now that we have a storage account, let's look at how we work with the queue that it will hold.

To access a queue, you need three pieces of information:

- Storage account name
- Queue name
- Authorization token

This information is used by both applications that talk to the queue (the web front end that adds messages and the mid-tier that processes them).

## Queue identity

Every queue has a name that you assign during creation. The name must be unique within your storage account but doesn't need to be globally unique (unlike the storage account name).

The combination of your storage account name and your queue name uniquely identifies a queue.

## Access authorization

Every request to a queue must be authorized and there are several options to choose from.

| Authorization type | Description |
|--------------------|-------------|
| **Azure Active Directory** | You can use role-based authentication and identify specific clients based on AAD credentials. |
| **Shared Key** | Sometimes referred to as an **account key**, this is an encrypted key signature associated with the storage account. Every storage account has two of these keys that can be passed with each request to authenticate access. Using this approach is like using a root password - it provides _full access_ to the storage account. |
| **Shared access signature** | A shared access signature (SAS) is a generated URI that grants limited access to objects in your storage account to clients. You can restrict access to specific resources, permissions, and scope to a date range to automatically turn off access after a period of time.  |

> [!NOTE]
> We will use the account key authorization because it is the simplest way to get started working with queues, however it's recommended that you either use shared access signature (SAS) or Azure Active Directory in production apps.

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
> This connection string value should be stored in a secure location since anyone who has access to this connection string would be able to manipulate the queue.

Let's get our connection string from Azure and set up a new application to use it.
