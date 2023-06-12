Key Vault provides secure storage of secrets, such as passwords and database connection strings.

From a developer's perspective, Key Vault APIs accept and return secret values as strings. Internally, Key Vault stores and manages secrets as sequences of octets (8-bit bytes), with a maximum size of 25k bytes each. The Key Vault service doesn't provide semantics for secrets. It merely accepts the data, encrypts it, stores it, and returns a secret identifier ("ID"). The identifier can be used to retrieve the secret at a later time.

For highly sensitive data, clients should consider additional layers of protection for data. Encrypting data using a separate protection key prior to storage in Key Vault is one example.

Key Vault also supports a contentType field for secrets. Clients may specify the content type of a secret to assist in interpreting the secret data when it's retrieved. The maximum length of this field is 255 characters. There are no pre-defined values. The suggested usage is as a hint for interpreting the secret data. For instance, an implementation may store both passwords and certificates as secrets, then use this field to differentiate. There are no predefined values.

:::image type="content" source="../media/az500-key-vault-secrets-331a5b9e.png" alt-text="Key Vault Secrets Create a secret form":::


As shown above, the values for Key Vault Secrets are:

 -  Name-value pair - **Name must be unique in the Vault**
 -  Value can be any **Unicode Transformation Format (UTF-8)** string - max of 25 KB in size
 -  Manual or certificate creation
 -  Activation date
 -  Expiration date

## Encryption

All secrets in your Key Vault are stored encrypted. Key Vault encrypts secrets at rest with a hierarchy of encryption keys, with all keys in that hierarchy are protected by modules that are **Federal Information Processing Standards (FIPS)** 140-2 compliant. This encryption is transparent, and requires no action from the user. The Azure Key Vault service encrypts your secrets when you add them, and decrypts them automatically when you read them.

The encryption leaf key of the key hierarchy is unique to each key vault. The encryption root key of the key hierarchy is unique to the security world, and its protection level varies between regions:

 -  China: root key is protected by a module that is validated for FIPS 140-2 Level 1.
 -  Other regions: root key is protected by a module that is validated for FIPS 140-2 Level 2 or higher.

## Secret attributes

In addition to the secret data, the following attributes may be specified:

 -  ***exp***: IntDate, optional, **default is forever**. The ***exp* (expiration time)** attribute identifies the expiration time on or after which the secret data **SHOULD NOT** be retrieved, except in particular situations. This field is for informational purposes only as it informs users of key vault service that a particular secret may not be used. Its value MUST be a number containing an IntDate value.
 -  ***nbf***: IntDate, optional, **default is now**. The ***nbf* (not before)** attribute identifies the time before which the secret data **SHOULD NOT** be retrieved, except in particular situations. This field is for informational purposes only. Its value **MUST** be a number containing an IntDate value.
 -  ***enabled***: boolean, optional, **default is true**. This attribute specifies whether the secret data can be retrieved. The enabled attribute is used with *nbf* and *exp* when an operation occurs between *nbf* and *exp*, it will only be permitted if enabled is set to true. Operations outside the *nbf* and *exp* window are automatically disallowed, except in particular situations.

There are more read-only attributes that are included in any response that includes secret attributes:

 -  ***created***: IntDate, optional. The created attribute indicates when this version of the secret was created. This value is null for secrets created prior to the addition of this attribute. Its value must be a number containing an IntDate value.
 -  ***updated***: IntDate, optional. The updated attribute indicates when this version of the secret was updated. This value is null for secrets that were last updated prior to the addition of this attribute. Its value must be a number containing an IntDate value.

For information on common attributes for each key vault object type, see **Azure Key Vault keys, secrets and certificates overview**.

## Date-time controlled operations

A secret's get operation will work for not-yet-valid and expired secrets, outside the *nbf* / *exp* window. Calling a secret's get operation, for a not-yet-valid secret, can be used for test purposes. Retrieving (getting) an expired secret, can be used for recovery operations.

## Secret access control

Access Control for secrets managed in Key Vault, is provided at the level of the Key Vault that contains those secrets. The access control policy for secrets is distinct from the access control policy for keys in the same Key Vault. Users may create one or more vaults to hold secrets, and are required to maintain scenario appropriate segmentation and management of secrets.

The following permissions can be used, on a per-principal basis, in the secrets access control entry on a vault, and closely mirror the operations allowed on a secret object:

 -  Permissions for secret management operations
    
    
     -  ***get***: Read a secret
     -  ***list***: List the secrets or versions of a secret stored in a Key Vault
     -  ***set***: Create a secret
     -  ***delete***: Delete a secret
     -  ***recover***: Recover a deleted secret
     -  ***backup***: Back up a secret in a key vault
     -  ***restore***: Restore a backed up secret to a key vault
 -  Permissions for privileged operations
    
    
     -  ***purge***: Purge (**permanently delete**) a deleted secret

## Secret tags

You can specify more application-specific metadata in the form of tags. Key Vault supports up to 15 tags, each of which can have a 256 character name and a 256 character value.

> [!NOTE]
> Tags are readable by a caller if they have the *list* or *get* permission.

## Usage Scenarios

## :::image type="content" source="../media/azure-key-vault-usage-scenarios-164b7bf4.png" alt-text="Screeshot showing when to use Azure Key Vault usage scenarios."::: 
