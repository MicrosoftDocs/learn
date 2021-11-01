You’ve completed the migration of your workloads to the cloud. This pilot involved a small set of VMs comprising older applications, not considered business-critical. You’ve learned a lot about how the migration process works and are now better prepared to move larger numbers of more complex workloads to Azure.

Moving your workloads to the cloud doesn’t free you from all responsibility for the security of your operating system, applications, and data. Although the Azure platform provides a secure infrastructure, there’s a shared security responsibility model. You need to ensure your Azure environment is secure at the administrative, application, and network layers. 

And while securing your environment is an ongoing activity, you should take certain actions right after migration to ensure your workloads are protected and secure.

In this unit, you’ll learn about techniques that you can use to secure your newly migrated VMs immediately after migration. You’ll continue to fine-tune the security controls on your workloads and applications over time, as you endeavor to protect your customers’ data and assets.

## Enhance virtual machine resilience

Your customers expect your applications to be available when they need to use them, and that their data is safe. Growing cyber threats and unplanned application downtime do occur and can impair user experience. 

Users can experience application downtime in a cloud-based environment for various reasons. Ensure that your migrated VMs have a sufficient level of resilience, by implementing a backup and recovery solution.

As a first step, consider using Azure Backup service. Azure Backup is built-in to Azure and doesn’t require any additional infrastructure.

Using Azure Backup, you can schedule regular backups of entire Windows or Linux VMs, files and folders and even an SQL database. For more complex scenarios, you’ll want to consider additional options to improve resilience, but Azure Backup lets you immediately impose some security control over your migrated VMs.

To further enhance your solution, set up Multi-Factor Authentication (MFA) so that only authorized users can perform critical backup operations.

## Limit inbound access to virtual machines

With your workloads now in the cloud, Azure VMs can become vulnerable to security attacks through open management ports, like port 3389. Azure IP addresses are well-known, and hackers continually probe for them for attacks on open 3389 ports. If an attacker can gain access to a VM through an open management port, they can gain a foothold into your environment.

To reduce the risk of attacks through open ports, you can limit inbound access to your VMs. Using Microsoft Defender for Cloud, enable just-in-time (JIT) virtual machine access. JIT uses network security groups (NSGs) and incoming rules to limit the amount of time that a specific port is open.

You configure a JIT policy on an individual VM. You can do this from Defender for Cloud, from the VM directly, or programmatically. The policy specifies rules for how users can connect to VMs.

If a user has permissions on the VM, an access request is approved, and Defender for Cloud configures NSGs to allow inbound traffic to the selected ports for the duration specified in the policy. After the time expires, Defender for Cloud restores the firewall and NSG rules to their previous state.

## Encrypt disks

Security breaches that result in lost data can have serious consequences, usually resulting in major legal and financial penalties for companies where breaches occur. Naturally, major compliance initiatives such as HIPAA and PCI have strong data encryption requirements.

Data encryption protects against loss or theft of a device by preventing unauthorized access to or removal of the hard drive. It also safeguards internal files in case an attacker tries to access them by alternate methods.

To protect your Azure VMs, use Azure Disk Encryption to encrypt your Windows and Linux VM disks. Disk encryption leverages BitLocker for Windows, and DM-Crypt for Linux to provide volume encryption for the OS and data disks.

You can use an encryption key created by Azure, or you can supply your own encryption key, safeguarded in Azure Key Vault. With Azure Disk Encryption, infrastructure as a service (IaaS) VM data is secured at rest (on disk) and during VM startup.

Microsoft Defender for Cloud provides a set of tools for monitoring and managing the security of virtual machines and other cloud computing resources with the Azure public cloud. If you use Microsoft Defender for Cloud, it alerts you if you have VMs that aren't encrypted and recommends you encrypt them.

![Screenshot of Microsoft Defender for Cloud, showing the apply disk encryption on your virtual machine blade. The screenshot shows two virtual machines that have a high severity warning because they are not currently encrypted. The recommendation is to encrypt those machines. ](../media/6654-azure-disk-encryption.png)
