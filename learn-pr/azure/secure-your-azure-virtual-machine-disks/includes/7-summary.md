Azure provides Storage Service Encryption (SSE) and Azure Disk Encryption (ADE) to secure Azure VM disks. These technologies work together to provide strong 256-bit encryption, as part of a defense-in-depth approach for the protection of Azure VM disks. It's required that you complete the Azure Disk Encryption prerequisites to enable disk encryption. The Azure Disk Encryption prerequisites configuration script can automate this process. When enabling encryption on new VMs, you can use an Azure Resource Manager template. This ensures that your data is encrypted at the point of deployment, leaving no vulnerabilities.

<!-- Cleanup sandbox -->
[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Additional resources

- [Troubleshooting Azure VM Disk encryption](https://docs.microsoft.com/azure/security/azure-security-disk-encryption-tsg)
- [How to encrypt a Linux virtual machine in Azure](https://docs.microsoft.com/azure/virtual-machines/linux/encrypt-disks)
- [Azure Disk Encryption Overview](https://docs.microsoft.com/azure/security/azure-security-disk-encryption-overview)
- [What Linux distributions does Azure Disk Encryption support?](https://docs.microsoft.com/en-us/azure/security/azure-security-disk-encryption-faq#bkmk_LinuxOSSupport).
- [Resource Manager templates on GitHub](https://github.com/Azure/azure-quickstart-templates)