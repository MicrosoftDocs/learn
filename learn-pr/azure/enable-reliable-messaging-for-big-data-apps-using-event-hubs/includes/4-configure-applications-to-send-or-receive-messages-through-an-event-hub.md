Now that you created and configured your event hub, you need to configure applications to send and receive event data streams via your hub.

For example, a payment processing solution uses some form of a sender application to collect a customer's credit card data, and a receiver application to verify that the credit card is valid.

There are differences in how a Java application is configured, when compared to a .NET application. However, the principles are the same for enabling applications to connect to an event hub, and to successfully send or receive messages.

## What minimum requirements does Event Hubs have for configuring an application?

To configure an application to send messages to an event hub, provide the following information, so that the application can create connection credentials:

- Event hub namespace name
- Event hub name
- Shared access policy name
- Primary shared access key

To configure an application to receive messages from an event hub, provide the following information, so that the application can create connection credentials:

- Event hub namespace name
- Event hub name
- Shared access policy name
- Primary shared access key
- Storage account name
- Storage account connection string
- Storage account container name

If you have a receiver application that stores messages in Azure Blob Storage, you also need to configure a storage account.

## Azure CLI commands to create a general-purpose standard storage account

The Azure CLI provides a set of commands you can use to create and manage a storage account. We use them in the next unit, but for now, here's a synopsis of the commands.

> [!TIP]
> There are several MS Learn modules that cover storage accounts, starting in the module **Introduction to Azure Storage**.

| Command | Description |
|---------|-------------|
| `storage account create` | Create a general-purpose V2 Storage account. |
| `storage account key list` | Retrieve the storage account key. |
| `storage account show-connection-string` | Retrieve the connection string for an Azure Storage account. |
| `storage container create` | Create a new container in a storage account. |


## Summary

Sender and receiver applications must be configured with specific information about the Event Hubs environment. You need to create a storage account if your receiver application stores messages in Blob Storage. If your application is hosted on GitHub, you need to clone it to your local directory. Text editors, such as **nano** can be used to add your namespace to the application.
