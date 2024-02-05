Your organization has data spread across various systems. These systems can be physical, or they can be virtual and still rely on physical infrastructure.

Your organization's data should be protected at different levels. You can encrypt disks to encrypt the data physically. If you're dealing with virtual machines, you can also encrypt the data on the VHDs. And you can use client-side encryption and encrypt data inside the files that store the data.

Here, you learn about encryption at rest, and about the tools and services that you can use to encrypt your data.

## Secure storage accounts by using Storage Service Encryption

Based on the type of classification, when your data is stored it needs continuous protection. You can use Azure Storage Service Encryption to encrypt data stored at rest in your Azure storage accounts. Data in storage accounts is physically stored on hard drives.

A physical hard disk in an Azure datacenter is unlikely to be stolen. Personal devices and laptops in your organization are easier targets. It's important to have safeguards that meet your organization's regulatory obligations, and a strategy for keeping data secure.

Storage Service Encryption uses 256-bit AES encryption. When your data is in any tier of an Azure storage account, it's encrypted by default. Each storage account is automatically encrypted as it's created. In fact, you can't disable encryption for storage accounts even if you want to. You can choose whether you want to use your own customer-managed keys (BYOK) or the default Microsoft-managed keys that are kept in Azure Key Vault.

Storage Service Encryption supports encryption for the following types of storage:

- Azure Blob storage
- Azure Table storage
- Azure Files
- Azure Queue storage
- Azure Managed Disks

## Secure disks by using Azure Disk Encryption

Just like Storage Service Encryption, Azure Disk Encryption helps secure your data. This encryption keeps you compliant with your organization's strategy and regulatory legal obligations. Your virtual machines on Azure all have disks allocated to them. Azure Disk Encryption ensures that these disks are encrypted.

With Azure Disk Encryption, you can choose to add another layer of security for your data by encrypting the VHD files. This way, you ensure that all of the operating system disks and the data disks are encrypted. The storage account that the disks are on is already encrypted through Storage Service Encryption. 

This encryption is achieved through DM-Crypt if you're dealing with Linux-based virtual machines. If you're working with Windows-based virtual machines, BitLocker handles the encryption.

Always take a snapshot of the VM, or create a backup, before you enable disk encryption. This action helps keep your VM safe if a problem occurs during the disk encryption process. 

When you're in the process of encrypting Linux OS disks, you should consider those Linux machines unusable. Also, the key vault and the virtual machine should always be in the same region.

When you've taken the appropriate precautions, you can enable disk encryption on a VM. You can also keep all of your disk encryption keys secure in Azure Key Vault. The following example shows how to use the Azure CLI to encrypt both OS and data volumes for a VM running on Azure by specifying the volume type parameter:

```azurecli
az vm encryption enable \
--resource-group "YourVirtualMachineResourceGroup" \
--name "YourSecureVM" \
--disk-encryption-keyvault "YourSecureVault"\
--volume-type ALL
```

Ensure that the disks have been encrypted by using this command:

```azurecli
az vm encryption show --name "YourSecureVM" --resource-group "YourVirtualMachineResourceGroup"
```

## Secure data by using client-side encryption

How do you ensure that the data in files is encrypted? You need to be able to encrypt this data yourself before it's moved and stored in Azure Storage. You need *client-side encryption*.

Your application can encrypt all of the data before it lands in Azure. The application then decrypts the data when it fetches the data back.

You can use Azure Storage client libraries for .NET, Python, or Java to encrypt the data. You use Azure Key Vault with all of these libraries to take care of your encryption keys.

### Encryption

To encrypt the data, you use the storage client library to first create a content encryption key (CEK). You then encrypt the data on your end, by using this CEK. This key is then encrypted through a key encryption key (KEK). A KEK can be either one you already have or one that's stored in Azure Key Vault. Finally, the encrypted data can be stored in Azure Storage. This process is called *envelope encryption*.

:::image type="content" source="../media/3-envelope-technique.svg" alt-text="Envelope encryption.":::

### Decryption

To decrypt the data, you need the KEK. However, you don't need to know the KEK that was used to encrypt the CEK. You typically use a key resolver, which goes through a group of keys and fetches the correct one.

Your storage client library can then fetch the data that was encrypted previously. For data decryption to start, the CEK is decrypted through the KEK. The library calls the key provider, whether Azure Key Vault or your own, to decrypt the CEK by using the appropriate KEK. The library has no access to this key. When the CEK is decrypted, the data is finally decrypted.
