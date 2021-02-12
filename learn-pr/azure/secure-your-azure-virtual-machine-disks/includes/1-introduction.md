Suppose you work for a warehouse company that's transitioning to the cloud. Currently, you use a hybrid environment consisting of on-premises Windows servers, Azure Virtual Machines (VMs), and Azure Active Directory. Your company has developed a custom in-house business-to-business (B2B) infrastructure, supporting secure order management with your suppliers. Some of your suppliers use Linux servers, and you run several Linux servers in Azure to support these suppliers.

Your security policies mandate that data must be encrypted using your own encryption keys, and that your company is responsible for managing these keys.

Your admin team already uses PowerShell for on-premises server management. You'll deploy and test many Azure VMs, and intend to use Azure Resource Manager templates to automate this process.

Here, you'll look at the types of protection available for VM disks, so you can decide if Azure Disk Encryption (ADE) is the best choice for a given scenario. You'll then enable ADE on existing VM disks, and use templates to enable ADE for new VM deployments.


## Learning objectives

In this module, you will:

- Determine which encryption method is best for your VM.
- Encrypt existing VM disks using the Azure portal.
- Encrypt existing VM disks using PowerShell.
- Modify Azure Resource Manager templates to automate disk encryption on new VMs.
