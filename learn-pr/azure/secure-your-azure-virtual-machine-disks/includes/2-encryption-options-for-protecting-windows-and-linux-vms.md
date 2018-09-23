Suppose your company's trading partners have security policies who require their trading data is protected with strong encryption. You use a B2B application that runs on your Windows servers, and stores data on the server data disk. Now that you're transitioning to the cloud, you need to demonstrate to your trading partners that data stored on your Azure VMs cannot be accessed by unauthorized users, devices, or applications. You need to decide on a strategy for implementing encryption of your B2B data.

Your audit requirements dictate that your encryption keys be managed in-house, and not by any third party. You're also concerned that the performance and manageability of your Azure-based servers is maintained. So before you implement encryption, you want to be sure that there won't be a performance hit.

## What is encryption?

Encryption is about converting meaningful information into something that appears meaningless, such as a random sequence of letters and numbers. The process of encryption uses some form of **key** as part of the algorithm that creates the encrypted data. A key is also needed to perform the decryption. Keys may be **_symmetric_**, where the same key is used for encryption and decryption, or **_asymmetric_**, where different keys are used. An example of the latter is the **public-private** key pairs used in digital certificates.

### Symmetric encryption

Algorithms that use symmetric keys, such as Advanced Encryption Standard (AES), are typically faster than public key algorithms, and are often used for protecting large data stores. Because there's only one key, procedures must be in place to prevent the key from becoming publicly known.

### Asymmetric encryption

With asymmetric algorithms, only the private key member of the pair must be kept private and secure; as its name suggests, the public key can be made available to anyone without compromising the encrypted data. The downside of public key algorithms, however, is that they're much slower than symmetric algorithms, and cannot be used to encrypt large amounts of data.

## Key management

In Azure, your encryption keys can be managed by Microsoft or the customer. Often the demand for customer-managed keys comes from organizations that need to demonstrate compliance with HIPAA, or other regulations. Such compliance may require that access to keys is logged, and that regular key changes are made and recorded.

## Azure disk encryption technologies

The main encryption-based disk protection technologies for Azure VMs are:

- Storage Service Encryption (SSE)
- Azure Disk Encryption (ADE)

### Storage Service Encryption

Azure Storage Service Encryption (SSE) is an encryption service built into Azure used to protect data at rest. The Azure storage platform automatically encrypts data before it's stored to several storage services, including Azure Managed Disks. Encryption is enabled by default using 256-bit AES encryption, and is managed by the storage account administrator.

### Azure Disk Encryption

Azure Disk Encryption (ADE) is managed by the VM owner. It controls the encryption of Windows and Linux VM-controlled disks, using **BitLocker** on Windows VMs and **DM-Crypt** on Linux VMs. BitLocker Drive Encryption is a data protection feature that integrates with the operating system, and addresses the threats of data theft or exposure from lost, stolen, or inappropriately decommissioned computers. Similarly, DM-Crypt encrypts data at rest for Linux before writing to storage.

ADE ensures that all data on VM disks are encrypted at rest in Azure storage, and ADE is required for VMs backed up to the Recovery Vault.

With ADE, VMs boot under customer-controlled keys and policies. ADE is integrated with Azure Key Vault for the management of these disk-encryption keys and secrets.

> [!NOTE] 
> ADE does not support the encryption of Basic tier VMs, and you cannot use an on-premises Key Management Service (KMS) with ADE.

## When to use encryption?

Computer data is at risk when it's in transit (transmitted across the Internet or other network), and when it's at rest (saved to a storage device). The at-rest scenario is the primary concern when protecting data on Azure VM disks. For example, someone might download the Virtual Hard Disk (VHD) file associated with an Azure VM, and save it on their laptop. If the VHD is not encrypted, the contents of the VHD are potentially accessible to anyone who can mount the VHD file on their computer.

For operating system (OS) disks, data such as passwords are encrypted automatically, so even if the VHD is not itself encrypted, it's not easy for such information to be accessed. Applications may also automatically encrypt their own data. However, even with such protections, if someone with malicious intent were to gain access to a data disk, and the disk itself was not encrypted, they might then be in a position to exploit any known weaknesses in that application's data protection. With disk encryption in place, such exploits are not possible.

Storage Service Encryption (SSE) is part of Azure itself, and there should be no noticeable performance impact on the VM disk IO when using SSE. Managed disks with SSE are now the default, and there should be no reason to change it. Azure Disk Encryption (ADE) makes use of VM operating system tools (BitLocker and DM-Crypt), so the VM itself has to do some work when encryption or decryption on VM disks is being performed. The impact of this additional VM CPU activity is typically negligible, except in certain situations. For instance, if you have a CPU-intensive application, there may be a case for leaving the OS disk unencrypted to maximize performance. In a situation such as this, you can store application data on a separate encrypted data disk, getting you the performance you need without compromising security.

Azure provides two complementary encryption technologies that are used to secure Azure VM disks. These technologies, SSE and ADE, encrypt at different layers, and serve different purposes. Both use AES 256-bit encryption. Using both technologies provides a defense-in-depth protection against unauthorized access to your Azure storage, and to specific VHDs.
