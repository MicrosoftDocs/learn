
**Azure Disk Encryption for Windows VMs** helps protect and safeguard your data to meet your organizational security and compliance commitments. It uses the BitLocker feature of Windows to provide volume encryption for the OS and data disks of Azure virtual machines (VMs), and is integrated with Azure Key Vault to help you control and manage the disk encryption keys and secrets.

:::image type="content" source="../media/az500-disk-encryption-44468f31.png" alt-text="A virtual machine uses storage with keys protected in a key vault.":::


If you use Microsoft Defender for Cloud, you'll be alerted if you have VMs that aren't encrypted. The alerts show as High Severity and the recommendation is to encrypt these VMs.

Azure Disk Encryption is zone resilient, the same way as Virtual Machines.

## Supported VMs and operating systems

**Supported VMs**

Windows VMs are available in a range of sizes. Azure Disk Encryption is supported on Generation 1 and Generation 2 VMs. Azure Disk Encryption is also available for VMs with premium storage.

Azure Disk Encryption is not available on Basic, A-series VMs, or on virtual machines with less than 2 GB of memory.

**Supported operating systems**

 -  Windows client: Windows 8 and later.
 -  Windows Server: Windows Server 2008 R2 and later.
 -  Windows 10 Enterprise multi-session.

### Networking requirements

To enable Azure Disk Encryption, the VMs must meet the following network endpoint configuration requirements:

 -  To get a token to connect to your key vault, the Windows VM must be able to connect to an Azure Active Directory endpoint, \[login.microsoftonline.com\].
 -  To write the encryption keys to your key vault, the Windows VM must be able to connect to the key vault endpoint.
 -  The Windows VM must be able to connect to an Azure storage endpoint that hosts the Azure extension repository and an Azure storage account that hosts the VHD files.
 -  If your security policy limits access from Azure VMs to the Internet, you can resolve the preceding URI and configure a specific rule to allow outbound connectivity to the IPs.

### Group Policy requirements

Azure Disk Encryption uses the BitLocker external key protector for Windows VMs. For domain joined VMs, don't push any group policies that enforce TPM protectors.

BitLocker policy on domain joined virtual machines with custom group policy must include the following setting: Configure user storage of BitLocker recovery information -&gt; Allow 256-bit recovery key. Azure Disk Encryption will fail when custom group policy settings for BitLocker are incompatible. On machines that didn't have the correct policy setting, apply the new policy, force the new policy to update (gpupdate.exe /force), and then restarting may be required.

Azure Disk Encryption will fail if domain level group policy blocks the AES-CBC algorithm, which is used by BitLocker.

### Encryption key storage requirements

Azure Disk Encryption requires an Azure Key Vault to control and manage disk encryption keys and secrets. Your key vault and VMs must reside in the same Azure region and subscription.

## Azure Disk Encryption for Linux VMs

Azure Disk Encryption helps protect and safeguard your data to meet your organizational security and compliance commitments. It uses the DM-Crypt feature of Linux to provide volume encryption for the OS and data disks of Azure virtual machines (VMs) and is integrated with Azure Key Vault to help you control and manage the disk encryption keys and secrets.

As for Windows VMs, if you use Microsoft Defender for Cloud, you're alerted if you have VMs that aren't encrypted. The alerts show as High Severity and the recommendation is to encrypt these VMs.

### Supported VMs and operating systems

**Supported VMs**

Linux VMs are available in a range of sizes. Azure Disk Encryption is supported on Generation 1 and Generation 2 VMs. Azure Disk Encryption is also available for VMs with premium storage.

**Note:** Azure Disk Encryption is not available on Basic, A-series VMs, or on virtual machines that do not meet these minimum memory requirements:

| **Virtual machine**                                                                                              | **Minimum memory requirement**                                                                                 |
| ---------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Linux VMs when only encrypting data volumes                                                                      | 2 GB                                                                                                           |
| Linux VMs when encrypting both data and OS volumes, and where the root (/) file system usage is 4GB or less      | 8 GB                                                                                                           |
| Linux VMs when encrypting both data and OS volumes, and where the root (/) file system usage is greater than 4GB | The root file system usage \* 2. For instance, a 16 GB of root file system usage requires at least 32GB of RAM |

Once the OS disk encryption process is complete on Linux virtual machines, the VM can be configured to run with less memory.

Azure Disk Encryption requires the dm-crypt and `vfat` modules to be present on the system. Removing or disabling `vfat` from the default image will prevent the system from reading the key volume and obtaining the key needed to unlock the disks on subsequent reboots. System hardening steps that remove the vfat module from the system are not compatible with Azure Disk Encryption
