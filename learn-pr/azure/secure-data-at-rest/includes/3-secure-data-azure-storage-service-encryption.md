You have an environment that's classified as confidential. It's your company's policy to encrypt data at rest, whether it's in the cloud, on-premises, or on a personal device.  By the end of this unit, you'll:

- Understand encryption at rest.
- Understand why you would use encryption at rest.
- Understand SSE.
- Understand ADE.
- Understand how you would use Azure Storage Service Encryption.
- Understand how and why you would use client-side encryption.

## Secure storage accounts with SSE

When your data is stored – or considered at rest – it will need constant protection. Potentially, this data might be stolen or compromised through many different methods. For example, the hard drives that store your data could be stolen. An attacker may plug these hard drives into another computer, then view and use the data.  Encrypting your data at rest ensures that it's protected from this attack, even if the physical hard drives are stolen.

You can use Azure Storage Service Encryption (SSE) to encrypt data stored at rest in your Azure storage accounts. Data in storage accounts is physically stored on hard drives. It's unlikely that a physical hard disk in an Azure data center would be stolen – a laptop is an easier target. However, it's important to have safeguards that meet your organization's regulatory obligations, and strategy for keeping data secure.

Azure Storage Service Encryption uses a type of encryption called 256-bit AES. It's one of the best block ciphers you can get.  When your data is in any tier of Azure storage account, it's encrypted by default. Azure makes it possible to keep storage in a redundant way by offering additional copies of your storage accounts. Each storage account is also automatically encrypted as it's created. In fact, you can't disable encryption for storage accounts even if you wanted to.  For encryption to take place, there's nothing for you to do. The data is encrypted for you. You can, however, decide whether you want to use your own customer-managed keys (BYOK) or the default Microsoft-managed keys that are kept secure in Azure Key Vault.

Azure Storage Service supports encryption for the following types of storage:

- Azure Blob
- Azure Table Storage
- Azure Files
- Azure Queue Storage
- Azure-Managed Disks

## Secure disks with ADE

Just like Azure Storage Service Encryption, Azure Disk Encryption helps to ensure your data is secured. This encryption keeps you compliant with your organization's strategy and regulatory legal obligations. Your virtual machines on Azure all have disks allocated to them. Azure Disk Encryption ensures that these disks are encrypted.

With Azure Disk Encryption, you can choose to add an additional layer of security for your data by encrypting the VHD files.  This way, you ensure all of the operating system disks and the data disks are encrypted. The storage account the disks are on is already encrypted through Azure Storage Service Encryption. This encryption is achieved through DM-Crypt if you're dealing with Linux- based virtual machines. If you're working with Windows-based virtual machines, BitLocker handles the encryption.

You can keep all of your disk encryption keys secure in Azure Key Vault. Also, because disk encryption is automatically picked up with Azure Security Center, each virtual machine that doesn't have disk encryption, is flagged as 'red' and 'High Severity' in Azure Security Center. You use this service to monitor which machines are missing disk encryption at a higher level, and take appropriate action.

Always take a snapshot of the VM, or create a backup, before enabling disk encryption. This action keeps your VM safe in case a problem occurs during the disk encryption process. While encryption is taking place on Linux machines, don't expect the machine to be available for use.  The Azure Key Vault for the keys and the virtual machine should always be in the same region.

When you've taken the appropriate precautions, you can enable disk encryption on a VM. Below is an example in Azure CLI, encrypting a VM running on Azure:

```Azure CLI
az vm encryption enable \
--resource-group "YourVirtualMachineResourceGroup" \
--name "YourSecureVM" \
--disk-encryption-keyvault "YourSecureVault"\
--volume-type [All|OS|Data]
```

Finally, ensure that the disks have indeed been encrypted by verifying:

```AzureCLI
az vm encryption show --name "YourSecureVM" --resource-group "YourVirtualMachineResourceGroup"
```

## Secure data with client-side encryption

Sometimes, you might want to encrypt yourself before data is moved and stored in Azure storage. An organization may have a policy requiring that no data ever leaves the local network without being encrypted first. And for good reason – anyone could look at unencrypted data if it's going freely through the internet.

That's where client-side encryption comes in. Your application can encrypt all of the data before it lands in Azure. The data is then decrypted by the application when it fetches this data back.  You can use .NET, Python, or Java Azure Storage Client libraries to encrypt the data.  You use Azure Key Vault with all of these libraries to take care of your encryption keys.

To encrypt the data, you would use the storage client library to first create a content encryption key (CEK). You then encrypt the data on your end, using this content encryption key.  This key will then be encrypted using a key encryption key (KEK).  A KEK can either be one you already have, or one that's stored in Azure Key Vault.  Finally, the encrypted data can then be stored into Azure Storage.

To decrypt the data again, the key encryption key is needed. However, you don't need to know the actual key encryption key that was used to encrypt the content encryption key.  You would typically use a key resolver, which goes through a group of keys and fetches the correct one.  

Your storage client library can then fetch the data that was encrypted previously. To start decrypting the data, the content encryption key is decrypted using the key encryption key. The library calls the key provider – whether Azure Key Vault or your own – to decrypt the content encryption key with the appropriate key encryption key. The library has no access to this key.  

When the content encryption key is decrypted, the data is finally decrypted.
