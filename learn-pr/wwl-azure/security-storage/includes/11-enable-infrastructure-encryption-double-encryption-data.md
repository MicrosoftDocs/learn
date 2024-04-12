Azure Storage automatically encrypts all data in a storage account at the service level using 256-bit AES encryption, which is one of the strongest block ciphers available, and is FIPS 140-2 compliant. Customers who require higher levels of assurance that their data is secure can also enable 256-bit AES encryption at the Azure Storage infrastructure level for double encryption. Double encryption of Azure Storage data protects against a scenario where one of the encryption algorithms or keys may be compromised. In this scenario, the additional layer of encryption continues to protect your data.

Infrastructure encryption can be enabled for the entire storage account, or for an encryption scope within an account. When infrastructure encryption is enabled for a storage account or an encryption scope, data is encrypted twice — once at the service level and once at the infrastructure level — with two different encryption algorithms and two different keys.<br>

Service-level encryption supports the use of either Microsoft-managed keys or customer-managed keys with Azure Key Vault or Key Vault Managed Hardware Security Model (HSM). Infrastructure-level encryption relies on Microsoft-managed keys and always uses a separate key.<br>

To doubly encrypt your data, you must first create a storage account or an encryption scope that is configured for infrastructure encryption.

*Infrastructure encryption is recommended for scenarios where doubly encrypting data is necessary for compliance requirements. For most other scenarios, Azure Storage encryption provides a sufficiently powerful encryption algorithm, and there's unlikely to be a benefit to using infrastructure encryption.*

## Create an account with infrastructure encryption enabled

To enable infrastructure encryption for a storage account, you must configure a storage account to use infrastructure encryption at the time that you create the account. Infrastructure encryption can't be enabled or disabled after the account has been created. The storage account must be of type general-purpose v2 or premium block blob.

To use the Azure portal to create a storage account with infrastructure encryption enabled, follow these steps:

1.  In the [Azure portal](https://portal.azure.com/), navigate to the **Storage accounts** page.<br>
2.  Choose the **Add** button to add a new general-purpose v2 or premium block blob storage account.<br>
3.  On the **Encryption** tab, locate **Enable infrastructure encryption**, and select **Enabled**.<br>
4.  Select **Review + create** to finish creating the storage account.
    
    :::image type="content" source="../media/create-account-infrastructure-encryption-page-b7269a77.png" alt-text="Screenshot showing how to create an account with infrastructure encryption enabled.":::
    

To verify that infrastructure encryption is enabled for a storage account with the Azure portal, follow these steps:<br>

1.  Navigate to your storage account in the [Azure portal](https://portal.azure.com/),<br>
2.  Under **Settings**, choose **Encryption**.
    
    :::image type="content" source="../media/verify-infrastructure-encryption-page-c9ecb274.png" alt-text="Screenshot showing how to verify that infrastructure encryption is enabled for a storage account.":::
    
    
    Azure Policy provides a built-in policy to require that infrastructure encryption be enabled for a storage account.

## Create an encryption scope with infrastructure encryption enabled

If infrastructure encryption is enabled for an account, then any encryption scope created on that account automatically uses infrastructure encryption. If infrastructure encryption isn't enabled at the account level, then you have the option to enable it for an encryption scope at the time that you create the scope. The infrastructure encryption setting for an encryption scope can't be changed after the scope is created.
