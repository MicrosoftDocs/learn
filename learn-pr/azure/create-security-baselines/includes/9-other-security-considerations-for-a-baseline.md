There are a few additional security recommendations that you should follow to set general security and operational controls on your Azure subscription.

Included with each recommendation are the basic steps to follow in the Azure portal. You should perform these steps on your own subscription with your own resources to validate the security for each. Keep in mind that **Level 2** options might restrict some features or activity, so carefully consider which security options you decide to enforce.

### Set an expiration date on all keys in Azure Key Vault - Level 1

In addition to the key material, the following attributes may be specified. In a JSON Request, the attributes keyword and braces, `{ }`, are required even if there are no attributes specified. For example, `IntDate`, optional, default is "forever". The **exp** (expiration time) attribute identifies the expiration time on or after which the key MUST NOT be used for cryptographic operation,except for certain operation types under particular conditions. The processing of the exp attribute requires that the current date/time MUST be before the expiration date/time listed in the exp attribute. It is thus recommended that you rotate your keys in the key vault and set an explicit expiry time for all keys. This ensures that the keys cannot be used beyond their assigned lifetimes. Key Vault stores and manages secrets as sequences of octets (8-bit bytes),with a maximum size of 25k bytes each. For highly sensitive data, clients should consider additional layers of protection for data. Encrypting data using a separate protection key prior to storage in Key Vault is one example.

1. Sign in to the Azure portal.

1. Go to the **Key vaults** pane. If it is not listed on the left menu, search for **Key vaults**.

1. Select **Key Vaults**.

1. For each key vault, select **Keys**.

1. Ensure that each key in the vault has **EXPIRATION DATE** set as appropriate.

### Set an expiration date on all secrets in Azure Key Vault - Level 1

Securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets. Ensure that all Secrets in Azure Key Vault have an expiration time set.

1. Sign in to the Azure portal.

1. Go to the **Key vaults** pane.

1. For each key vault, select **Secrets**.

1. Ensure that each secret in the vault has **EXPIRATION DATE** set as appropriate.

1. The following illustrates setting expiration date on a password.

     ![Screenshot of setting Key Vault expiration date](../media/9-akv-expiration.png)

### Set resource locks for mission-critical Azure resources - Level 2

As an administrator, you may need to lock a subscription, resource group, or resource to prevent other users in your organization from accidentally deleting or modifying critical resources. You can set the lock level to `CanNotDelete` or `ReadOnly`. In the portal, the locks are called Delete and Read-only respectively. Unlike role-based access control, you use management locks to apply a restriction across all users and roles. Resource Manager locks apply only to operations that happen in the management plane, which consists of operations sent to <https://management.azure.com>. The locks don't restrict how resources perform their own functions. Resource changes are restricted, but resource operations aren't restricted.

    > [!TIP]
    > For example, a `ReadOnly` lock on a SQL Database prevents you from deleting or modifying the database. It doesn't prevent you from creating, updating, or deleting data in the database. Data transactions are permitted because those operations aren't sent to <https://management.azure.com>.

1. Sign in to the Azure portal.

1. In the Settings pane for the resource, resource group, or subscription that you want to lock, select **Locks**.

     ![Screenshot of setting Key Vault lock](../media/9-lock1.png)

1. To add a lock, select **Add**.

1. Give the lock a name and lock level, for example, **CanNotDelete or ReadOnly**. Optionally, you can add notes that describe the lock.

     ![Screenshot of setting Key Vault naming the lock](../media/9-lock2.png)
