There are a few more security recommendations that you should follow to set general security and operational controls on your Azure subscription.

Included with each recommendation are the basic steps to follow in the Azure portal. You should perform these steps with your own subscription using your own resources to validate the security for each. Keep in mind that **Level 2** options might restrict some features or activity, so carefully consider which security options you decide to enforce.

### Set an expiration date on all keys in Azure Key Vault - Level 1

In addition to the key material, the following attributes might be specified. In a JSON request, the attributes' keyword and braces `{ }` are required even if there are no attributes specified. For example, `IntDate`, optional, default is "forever". The **exp** (expiration time) attribute identifies the expiration time on or after which the key MUST NOT be used for cryptographic operation, except for certain operation types under particular conditions. The processing of the exp attribute requires that the current date/time MUST be before the expiration date/time listed in the exp attribute. We recommend that you rotate your keys in the key vault and set an explicit expiry time for all keys. This process ensures that the keys can't be used beyond their assigned lifetimes. Key Vault stores and manages secrets as sequences of 8-bit bytes, called octets, with a maximum size of 25 KB each. For highly sensitive data, clients should consider more layers of protection for data. Encrypting data using a separate protection key prior to storage in Key Vault is one example.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Key vaults*. The **Key vaults** pane displays.

1. For each key vault, in the left menu pane, under **Objects**, select **Keys**. The **Keys** pane for your key vault displays.

1. Ensure that each key in the vault has **Expiration date** set as appropriate.

### Set an expiration date on all secrets in Azure Key Vault - Level 1

Securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets. Ensure that all Secrets in Azure Key Vault have an expiration time set.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Key vaults*. The **Key vaults** pane displays.

1. For each key vault, in the left menu pane, under **Objects**, select **Secrets**. The **Secrets** pane for your key vault displays.

1. Ensure that each secret in the vault has **Expiration date** set as appropriate.

1. The following screenshot illustrates setting an expiration date on a password.

     :::image type="content" source="../media/9-other-security-considerations-for-a-baseline/key-vault-set-secret-expiration-date.png" alt-text="Screenshot that shows setting an expiration date on a key vault Secret.":::

### Set resource locks for mission-critical Azure resources - Level 2

As an administrator, you might need to lock a subscription, resource group, or resource to prevent other users from accidentally deleting or modifying critical resources. You can set the lock level to `CanNotDelete` or `ReadOnly`. In the portal, the locks are called Delete and Read-only, respectively. Unlike role-based access control, you use management locks to apply a restriction across all users and roles. Resource Manager locks apply only to operations that happen in the management plane, which consists of operations sent to `https://management.azure.com`. The locks don't restrict how resources perform their own functions. Resource changes are restricted, but resource operations aren't restricted.

   > [!TIP]
   > For example, a `ReadOnly` lock on a SQL Database prevents you from deleting or modifying the database. It doesn't prevent you from creating, updating, or deleting data in the database. Data transactions are permitted because those operations aren't sent to <https://management.azure.com>.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, search for and select **All resources**. The **All resources** pane displays.

1. Select a resource, resource group, or subscription that you want to lock. That *resource* pane displays.

1. In the middle menu pane, under **Settings**, select **Locks**. The **Locks** pane displays for your resource.

1. To add a lock, in the top menu bar, select **Add**. The **Add lock** pane displays.

1. Enter a name for the lock and provide a lock level, for example, **CanNotDelete** or **ReadOnly**. Optionally, you can add notes that describe the lock.
