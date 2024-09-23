Azure Key Vault is a *secret store*: a centralized cloud service for storing app secrets, such as configuration values like passwords and connection strings that must remain secure at all times. Key Vault helps you control your apps' secrets by keeping them in a single central location. It provides secure access, permissions control, and access logging.


> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4LHck]

The main benefits of using Key Vault are:

- Separation of sensitive app information from other configuration and code, which reduces the risk of accidental leaks
- Restricted secret access with access policies tailored to the apps and individuals that need them
- Centralized secret storage, meaning required changes only have to be made in one place
- Access logging and monitoring to help you understand how and when secrets are accessed

Secrets are stored in individual *vaults*, which are Azure resources used to group secrets together. Secret access and vault management is accomplished by using a REST API. All of the Azure management tools and client libraries available for many popular languages also support this API. Every vault has a unique URL where its API is hosted.

> [!IMPORTANT]
> *Key Vault is designed to store configuration secrets for server apps.* It's not intended for storing data belonging to your app's users. It shouldn't be used in the client-side part of an app. This behavior is reflected in its performance characteristics, API, and cost model.
>
> User data should be stored elsewhere, such as in an Azure SQL database with Transparent Data Encryption, or a storage account with Storage Service Encryption. Secrets your app uses to access those data stores can be kept in Key Vault.

## What is a secret in Key Vault?

In Key Vault, a secret is a name-value pair of strings. Secret names must be 1-127 characters long, contain only alphanumeric characters and dashes, and must be unique within a vault. A secret value can be any UTF-8 string up to 25 KB in size.

> [!TIP]
> Secret names don't need to be considered especially secret themselves. You can store them in your app's configuration if your implementation calls for it. The same is true of vault names and URLs.

> [!NOTE]
> Key Vault supports two additional kinds of secrets beyond strings: *keys* and *certificates*. Key Vault provides useful functionality specific to their use cases. This module does not cover these features and concentrates on secret strings like passwords and connection strings.

## Vault authentication and permissions

Key Vault's API uses Microsoft Entra ID to authenticate users and apps. Vault access policies are based on *actions* and are applied across an entire vault. For example, an app with `Get` (read secret values), `List` (list names of all secrets), and `Set` (create or update secret values) permissions to a vault can create secrets, list all secret names, and get and set all secret values in that vault.

*All* actions performed on a vault require authentication and authorization. There's no way to grant any kind of anonymous access.

> [!TIP]
> When you grant vault access to developers and apps, grant only the minimum set of permissions needed. Permissions restrictions help avoid accidents caused by code bugs, and reduce the impact of stolen credentials or malicious code injected into your app.

Developers usually only need `Get` and `List` permissions to a development-environment vault. Some engineers need full permissions to change and add secrets, when necessary.

For apps, often only `Get` permissions are required. Some apps might require `List` depending on the way the app is implemented. The app in this module's exercise requires the `List` permission because of the technique it uses to read secrets from the vault.
