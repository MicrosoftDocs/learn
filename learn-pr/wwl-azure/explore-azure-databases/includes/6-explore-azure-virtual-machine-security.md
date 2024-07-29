Consider the following when exploring and implementing Azure Virtual Machine security:

## Network security

For network security, consider implementing a perimeter network, with a managed or hosted firewall in front of the subnet for Web Dispatcher. For storage security, ensure that data is encrypted in transit and at rest. To encrypt Azure Virtual Machine disks, you can use Azure Disk Encryption. This feature uses the BitLocker feature of Windows and DM-Crypt for Linux to provide volume encryption for the operating system and the data disks. The solution also works with Azure Key Vault to help you control and manage the disk-encryption keys and secrets. Data on the virtual machine disks are encrypted at rest in Azure storage. For SAP HANA data-at-rest encryption, we recommend using the SAP HANA native encryption technology.

## Storage security

Data in Azure Storage is encrypted and decrypted transparently using 256-bit AES encryption, one of the strongest block ciphers available, and is FIPS 140-2 compliant. Azure Storage encryption is similar to BitLocker encryption on Windows.

Azure Storage encryption is enabled for all storage accounts, including both Resource Manager and classic storage accounts, and cannot be disabled. Because your data is secured by default, you don't need to modify your code or applications to take advantage of Azure Storage encryption.

Data in a new storage account is encrypted with Microsoft-managed keys by default. You can continue to rely on Microsoft-managed keys for the encryption of your data, or you can manage encryption with your own keys.

Customers who require high levels of assurance that their data is secure can also enable 256-bit AES encryption at the Azure Storage infrastructure level. When infrastructure encryption is enabled, data in a storage account is encrypted twice—once at the service level and once at the infrastructure level—with two different encryption algorithms and two different keys. Double encryption of Azure Storage data protects against a scenario where one of the encryption algorithms or keys might be compromised. In this scenario, the extra layer of encryption continues to protect your data.

> [!NOTE]
> It isn't generally recommended to combine both Azure Disk Encryption with DBMS encryption, as this may impact performance.

- Availability zones introduce increased latency between SAP and DB servers. It's usually negligible, but it will show up in performance numbers. This is the tradeoff for the extra 0.04% uptime. Also, be aware that availability zones incur an extra charge for cross-zone network traffic.
- Don't use the HANA data-at-rest encryption with Azure Disk Encryption on the same server. For HANA, use only HANA data encryption.
