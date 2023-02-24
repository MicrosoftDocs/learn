For your Azure Storage security solution, you can use Azure Key Vault to manage your encryption keys. The Azure Key Vault APIs can be used to generate encryption keys. You can also create your own encryption keys and store them in a key vault. 

### Things to know about customer-managed keys

Consider the following characteristics of customer-managed keys.

- By creating your own keys (referred to as _customer-managed_ keys), you have more flexibility and greater control.

- You can create, disable, audit, rotate, and define access controls for your encryption keys.

- Customer-managed keys can be used with Azure Storage encryption. You can use a new key or an existing key vault and key. The Azure storage account and the key vault must be in the same region, but they can be in different subscriptions.

## Configure customer-managed keys

In the Azure portal, you can configure customer-managed encryption keys. You can create your own keys, or you can have the keys managed by Microsoft. Consider how you might use Azure Key Vault to create your own customer-managed encryption keys.

:::image type="content" source="../media/customer-keys-b24acc48.png" alt-text="Screenshot that shows how to create a customer-managed key." border="false":::

- **Encryption type**: Choose how the encryption key is managed: by Microsoft or by yourself (customer).
- **Encryption key**: Specify an encryption key by entering a URI, or select a key from an existing key vault.