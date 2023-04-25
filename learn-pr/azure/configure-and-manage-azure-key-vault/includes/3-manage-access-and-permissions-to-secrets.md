Key Vault access has two facets: the management of the Key Vault itself, and accessing the data contained in the Key Vault. Documentation refers to these facets as  the *management plane* and the *data plane*.

These two areas are separated because the creation of the Key Vault is a management operation, while storing and retrieving a secret stored in the Key Vault is a different type of role. To access a key vault all users or apps must have proper *authentication* to identify the caller and *authorization* to determine the operations the caller can perform.

## Authentication

Azure Key Vault uses Azure Active Directory (Azure AD) to authenticate users and apps that try to access a vault. Authentication is always performed by associating the request with the Azure AD tenant of the subscription that the Key Vault is part of. Every user or app making a request must be known to Azure AD. There's no support for anonymous access to a Key Vault.

## Authorization

Management operations (creating a new Azure Key Vault) use role-based access control (RBAC). There's a built-in role **Key Vault Contributor** that provides access to management features of key vaults, but doesn't allow access to the key vault data. This role is the recommended role to use. There's also a **Contributor** role that includes full administration rights - including the ability to grant access to the data plane.

Reading and writing data in the Key Vault uses a separate Key Vault *access policy*. A Key Vault access policy is a permission set assigned to a user or managed identity to read, write, and/or delete secrets and keys. You can create an access policy using the CLI, REST API, or Azure portal as follows.

:::image type="content" source="../media/3-add-key-vault-policy.png" alt-text="Screenshot showing the Add KeyVault policy screen in the Azure portal.":::

The system has a list of predefined management options that define the permissions allowed for this policy - here we've selected **Key, Secret, & Certificate Management** which is appropriate to manage secrets in the Key Vault. You can then customize the permissions as desired by changing the **Key permissions** entries. For example, we could adjust the permissions to only allow *read* operations:

:::image type="content" source="../media/3-permissions.png" alt-text="Screenshot showing the permission list cut down to read only in the Azure portal.":::

Developers only need `Get` and `List` permissions to a development-environment vault. A lead or senior developer needs full permissions to the vault to change and add secrets when necessary. Full permissions to production-environment vaults are typically reserved for senior operations staff. Apps only require `Get` permissions as they often only need to retrieve secrets.

## Restrict network access

Another point to consider with Azure Key Vault is what services in your network can access the vault. In most cases, the network endpoints don't need to be open to the Internet. You should determine the minimum network access required. For example, you can restrict Key Vault endpoints to specific Azure Virtual Network subnets, specific IP addresses, or trusted Microsoft services. Including, Azure SQL, Azure App Service, and various data and storage services that use encryption keys.

:::image type="content" source="../media/3-network-rules.png" alt-text="Screenshot showing the network rules for a KeyVault in the Azure portal.":::