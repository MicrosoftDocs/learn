The Azure Key Vault can manage your encryption keys. You can create your own encryption keys and store them in a key vault, or you can use Azure Key Vault's APIs to generate encryption keys.

Customer-managed keys give you more flexibility and control. You can create, disable, audit, rotate, and define access controls.

:::image type="content" source="../media/customer-keys-b24acc48.png" alt-text="Screenshot of using a customer managed key.":::


> [!NOTE]
> Customer-managed keys can be used with SSE. You can use either a new or existing key vault and key. The storage account and the key vault must be in the same region, but they can be in different subscriptions.
