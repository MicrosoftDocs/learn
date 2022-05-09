Key Vault provides secure storage of secrets, such as passwords and database connection strings.

From a developer's perspective, Key Vault APIs accept and return secret values as strings. Internally, Key Vault stores and manages secrets as sequences of octets (8-bit bytes), with a maximum size of 25k bytes each. The Key Vault service doesn't provide semantics for secrets. It merely accepts the data, encrypts it, stores it, and returns a secret identifier ("ID"). The identifier can be used to retrieve the secret at a later time.

For highly sensitive data, clients should consider additional layers of protection for data. Encrypting data using a separate protection key prior to storage in Key Vault is one example.

Key Vault also supports a contentType field for secrets. Clients may specify the content type of a secret to assist in interpreting the secret data when it's retrieved. The maximum length of this field is 255 characters. There are no pre-defined values. The suggested usage is as a hint for interpreting the secret data. For instance, an implementation may store both passwords and certificates as secrets, then use this field to differentiate. There are no predefined values.

:::image type="content" source="../media/az500-key-vault-secrets-331a5b9e.png" alt-text="Key Vault Secrets Create a secret form":::


As shown above, the values for Key Vault Secrets are:

 -  Name-value pair - **Name must be unique in the Vault**
 -  Value can be any UTF-8 string - max of 25 KB in size
 -  Manual or certificate creation
 -  Activation date
 -  Expiration date

## Encryption

All secrets in your Key Vault are stored encrypted. This encryption is transparent and requires no action from the user. The Azure Key Vault service encrypts your secrets when you add them, and decrypts them automatically when you read them. The encryption key is unique to each key vault.

## Azure storage account key management

Key Vault can manage Azure storage account keys:

 -  Internally, Key Vault can list (sync) keys with an Azure storage account.
 -  Key Vault regenerates (rotates) the keys periodically.
 -  Key values are never returned in response to caller.
 -  Key Vault manages keys of both storage accounts and classic storage accounts.

## Storage account access control

The following permissions can be used when authorizing a user or application principal to perform operations on a managed storage account:

**Permissions for managed storage account and SaS-definition operations:**

 -  `get`: Gets information about a storage account
 -  `list`: List storage accounts managed by a Key Vault
 -  `update`: Update a storage account
 -  `delete`: Delete a storage account
 -  `recover`: Recover a deleted storage account
 -  `backup`: Back up a storage account
 -  `restore`: Restore a backed-up storage account to a Key Vault
 -  `set`: Create or update a storage account
 -  `regeneratekey`: Regenerate a specified key value for a storage account
 -  `getsas`: Get information about a SAS definition for a storage account
 -  `listsas`: List storage SAS definitions for a storage account
 -  `deletesas`: Delete a SAS definition from a storage account
 -  `setsas`: Create or update a new SAS definition/attributes for a storage account

**Permissions for privileged operations**

 -  `purge`: Purge (permanently delete) a managed storage account
