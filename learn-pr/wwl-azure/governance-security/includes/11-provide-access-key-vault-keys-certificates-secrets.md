Azure role-based access control (Azure RBAC) is an authorization system built on Azure Resource Manager that provides fine-grained access management of Azure resources.

Azure RBAC allows users to manage Key, Secrets, and Certificates permissions. It provides one place to manage all permissions across all key vaults.

The Azure RBAC model allows uses to set permissions on different scope levels: management group, subscription, resource group, or individual resources. Azure RBAC for key vault also allows users to have separate permissions on individual keys, secrets, and certificates.

## Best Practices for individual keys, secrets, and certificates role assignments

Our recommendation is to use a vault per application per environment (Development, Pre-Production, and Production).

Individual keys, secrets, and certificates permissions should be used only for specific scenarios:

 -  Sharing individual secrets between multiple applications, for example, one application needs to access data from the other application

## Azure built-in roles for Key Vault data plane operations

> [!NOTE]
> *The Key Vault Contributor role is for management plane operations only to manage key vaults. It does not allow access to keys, secrets and certificates.*

| **Built-in role**                        | **Description**                                                                                                                                                                                                                                                             | **ID**                               |
| ---------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| Key Vault Administrator                  | Perform all data plane operations on a key vault and all objects in it, including certificates, keys, and secrets. Cannot manage key vault resources or manage role assignments. Only works for key vaults that use the 'Azure role-based access control' permission model. | 00482a5a-887f-4fb3-b363-3b7fe8e74483 |
| Key Vault Certificates Officer           | Perform any action on the certificates of a key vault, except manage permissions. Only works for key vaults that use the 'Azure role-based access control' permission model.                                                                                                | a4417e6f-fecd-4de8-b567-7b0420556985 |
| Key Vault Crypto Officer                 | Perform any action on the keys of a key vault, except manage permissions. Only works for key vaults that use the 'Azure role-based access control' permission model.                                                                                                        | 14b46e9e-c2b7-41b4-b07b-48a6ebf60603 |
| Key Vault Crypto Service Encryption User | Read metadata of keys and perform wrap/unwrap operations. Only works for key vaults that use the 'Azure role-based access control' permission model.                                                                                                                        | e147488a-f6f5-4113-8e2d-b22465e65bf6 |
| Key Vault Crypto User                    | Perform cryptographic operations using keys. Only works for key vaults that use the 'Azure role-based access control' permission model.                                                                                                                                     | 12338af0-0e69-4776-bea7-57ae8d297424 |
| Key Vault Reader                         | Read metadata of key vaults and its certificates, keys, and secrets. Cannot read sensitive values such as secret contents or key material. Only works for key vaults that use the 'Azure role-based access control' permission model.                                       | 21090545-7ca7-4776-b22c-e363652d74d2 |
| Key Vault Secrets Officer                | Perform any action on the secrets of a key vault, except manage permissions. Only works for key vaults that use the 'Azure role-based access control' permission model.                                                                                                     | b86a8fe4-44ce-4948-aee5-eccb2c155cd7 |
| Key Vault Secrets User                   | Read secret contents including secret portion of a certificate with private key. Only works for key vaults that use the 'Azure role-based access control' permission model.                                                                                                 | 4633458b-17de-408a-b874-0445c86b69e6 |

> [!NOTE]
> There is no Key Vault Certificate User because applications require secrets portion of certificate with private key. The Key Vault Secrets User role should be used for applications to retrieve certificate.

### Managing built-in Key Vault data plane role assignments (preview)

| **Built-in role**                             | **Description**                                                                                                                                                                                                                                                                                                                                                             | **ID**                               |
| --------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| Key Vault Data Access Administrator (preview) | Manage access to Azure Key Vault by adding or removing role assignments for the Key Vault Administrator, Key Vault Certificates Officer, Key Vault Crypto Officer, Key Vault Crypto Service Encryption User, Key Vault Crypto User, Key Vault Reader, Key Vault Secrets Officer, or Key Vault Secrets User roles. Includes an ABAC condition to constrain role assignments. | 8b54135c-b56d-4d72-a534-26097cfdc8d8 |

## Using Azure RBAC secret, key, and certificate permissions with Key Vault

The new Azure RBAC permission model for key vault provides alternative to the vault access policy permissions model.

### Prerequisites

You must have an Azure subscription. If you don't, you can create a free account before you begin.

To add role assignments, you must have `Microsoft.Authorization/roleAssignments/write` and `Microsoft.Authorization/roleAssignments/delete` permissions, such as Key Vault Data Access Administrator (preview), User Access Administrator, or Owner.
