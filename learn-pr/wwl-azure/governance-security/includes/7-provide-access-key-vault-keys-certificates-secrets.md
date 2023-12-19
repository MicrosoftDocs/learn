Azure role-based access control (Azure RBAC) is an authorization system built on Azure Resource Manager that provides fine-grained access management of Azure resources.

Azure RBAC allows users to manage Key, Secrets, and Certificates permissions. It provides one place to manage all permissions across all key vaults.

The Azure RBAC model allows uses to set permissions on different scope levels: management group, subscription, resource group, or individual resources. Azure RBAC for key vault also allows users to have separate permissions on individual keys, secrets, and certificates.

## Best Practices for individual keys, secrets, and certificates role assignments

Our recommendation is to use a vault per application per environment (Development, Pre-Production, and Production).

Individual keys, secrets, and certificates permissions should be used only for specific scenarios:

 -  Sharing individual secrets between multiple applications, for example, one application needs to access data from the other application

## Azure built-in roles for Key Vault data plane operations

*The Key Vault Contributor role is for management plane operations only to manage key vaults. It does not allow access to keys, secrets and certificates.*

:::image type="content" source="../media/azure-built-in-roles-key-vault-data-plane-operations-b36072fd.png" alt-text="Screenshot of table showing Azure built-in roles for Key Vault data plane operations.":::


*There is no Key Vault Certificate User because applications require secrets portion of certificate with private key. The Key Vault Secrets User role should be used for applications to retrieve certificate.*

### Managing built-in Key Vault data plane role assignments (preview)

:::image type="content" source="../media/manage-built-in-key-vault-data-plane-role-assignments-preview-cd94ca4e.png" alt-text="Screenshot of table showing built-in Key Vault data plane role assignments.":::


## Using Azure RBAC secret, key, and certificate permissions with Key Vault

The new Azure RBAC permission model for key vault provides alternative to the vault access policy permissions model.

### Prerequisites

You must have an Azure subscription. If you don't, you can create a free account before you begin.

To add role assignments, you must have `Microsoft.Authorization/roleAssignments/write` and `Microsoft.Authorization/roleAssignments/delete` permissions, such as Key Vault Data Access Administrator (preview), User Access Administrator, or Owner.

### Enable Azure RBAC permissions on Key Vault

Changing permission model requires 'Microsoft.Authorization/roleAssignments/write' permission, which is part of **Owner** and **User Access Administrator** roles. Classic subscription administrator roles like 'Service Administrator' and 'Co-Administrator' are not supported.

1. Enable Azure RBAC permissions on new key vault:

:::image type="content" source="../media/create-key-vault-ab129f1c.png" alt-text="Screenshot showing how to create and perform access configuration on a Key Vault.":::
<br>

2. Enable Azure RBAC permissions on existing key vault:

:::image type="content" source="../media/exist-vault-b28fd494.png" alt-text="Screenshot showing how to enable Azure RBAC permissions on existing Key Vault.":::
<br>

*Setting Azure RBAC permission model invalidates all access policies permissions. It can cause outages when equivalent Azure roles aren't assigned.*
