Now that you've created and configured your event hub, you'll need to configure applications to send and receive event data streams via your hub.

For example, a payment processing solution will use some form of a sender application to collect customer's credit card data, and a receiver application to verify that the credit card is valid.

Although there are differences in how a Java application is configured, when compared to a .NET application, the principles for enabling applications to connect to an event hub and to successfully send or receive messages are the same.

## What are the minimum Event Hubs requirements for configuring an application?

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

If you have a receiver application that stores messages in Azure Blob Storage, you'll also need to configure a storage account.

## Azure CLI commands to create a general-purpose standard storage account

The Azure CLI provides a set of commands you can use to create and manage a storage account. We'll work with them in the next unit, but here's a synopsis of the commands.

> [!TIP]
> There are several MS Learn modules that cover storage accounts, starting in the module **Introduction to Azure Storage**.

| Command | Description |
|---------|-------------|
| `storage account create` | Create a general-purpose V2 Storage account. |
| `storage account key list` | Retrieve the storage account key. |
| `storage account show-connection-string` | Retrieve the connection string for an Azure Storage account. |
| `storage container create` | Creates a new container in a storage account. |

## Shell command to clone an application GitHub repository

Git is a collaboration tool that uses a distributed version control model, and is designed for collaborative work on software and documentation projects. Git clients are available for multiple platforms, including Windows, and the Git command line is included in Azure Bash Cloud Shell. GitHub is a web-based hosting service for Git repositories.

If you have an application that is hosted as a project in GitHub, you can make a local copy of the project, by cloning its repository using the **git clone** command.

## Edit files in Cloud Shell

You can use one of the built-in editors in Cloud Shell to modify all the files that make up the application, and add your event hub namespace, event hub name, shared access policy name, and primary key.

Azure Cloud Shell supports **nano**, **vim**, **emacs, and Cloud Shell editor (code)**. Just enter the name of the editor you want, and it will launch in the environment. We'll use Cloud Shell editor (**code**) in the next unit.

## Summary

Sender and receiver applications must be configured with specific information about the Event Hubs environment. You need to create a storage account if your receiver application stores messages in Blob Storage. If your application is hosted on GitHub, you need to clone it to your local directory. Text editors, such as **nano** can be used to add your namespace to the application.
