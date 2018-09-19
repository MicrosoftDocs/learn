Azure Key Vault is a *secret store*: a centralized cloud service for storing application secrets. Key Vault helps you control your applications' secrets by keeping them in a single central location and providing secure access, permissions control, and access logging.

The main benefits of using Key Vault are:

- Reduced risk of accidental secret leaks by storing secrets securely, outside of configuration and source control, and eliminating scenarios where secrets are copied around in files or pasted into emails or chats
- Restricted secret access with access policies tailored to the applications and individuals that need them
- Centralized secret storage, so that multiple users and instances of applications can access secret values that only need to be updated in one place
- Access logging and monitoring to help you understand how and when secrets are accessed

Secrets are stored in individual *vaults*, which are Azure resources with their own configuration and security policies that you can create with any of the standard Azure management tools like the Azure portal or the Azure CLI. Secret access and vault management is accomplished via a REST API, which is also supported by all of the Azure management tools as well as client libraries available for many popular languages. Every vault has a unique URL where its API is hosted.

> [!IMPORTANT]
> **Key Vault is designed to store configuration secrets for server applications.** It's not intended for storing data belonging to your app's users, and it shouldn't be used in the client-side part of an app. This is reflected in its performance characteristics, API, and cost model.
>
> User data should be stored elsewhere, such as in an Azure SQL database with Transparent Data Encryption, or a storage account with Storage Service Encryption. Secrets used by your application to access those data stores can be kept in Key Vault.

## What is a secret in Key Vault?

In Key Vault, a secret is a name-value pair of strings. Secret names must be 1-127 characters long, contain only alphanumeric characters and dashes, and must be unique within a vault. A secret value can be any UTF-8 string up to 25 KB in size.

> [!TIP]
> Secret names don't need to be considered especially secret themselves. You can store them in your app's configuration if your implementation calls for it. The same is true of vault names and URLs.

> [!NOTE]
> Key Vault supports two additional kinds of secrets beyond strings &mdash; *keys* and *certificates* &mdash; and provides useful functionality specific to their use cases. This module does not cover these features and concentrates on secret strings like passwords and connection strings.
