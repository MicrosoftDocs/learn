To secure Azure VM disks, Azure provides Storage Service Encryption (SSE) and Azure Disk Encryption (ADE). These technologies work together to provide strong 256-bit encryption, as part of a defense-in-depth approach for the protection of Azure VM disks. It's required that you complete the Azure Disk Encryption prerequisites to enable disk encryption. The Azure Disk Encryption prerequisites configuration script can automate this process. When enabling encryption on new VMs, you can use an Azure Resource Manager template. Using a template ensures that your data is encrypted at the point of deployment, leaving no vulnerabilities.

<!-- Cleanup sandbox -->
[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Additional resources

- [Azure Disk Encryption scenarios on Linux VMs](https://docs.microsoft.com/azure/virtual-machines/linux/disk-encryption-linux)
- [Azure Disk Encryption for virtual machines and virtual machine scale sets](https://docs.microsoft.com/azure/security/fundamentals/azure-disk-encryption-vms-vmss)
- [Resource Manager templates on GitHub](https://github.com/Azure/azure-quickstart-templates)
- [Azure data security and encryption best practices](https://docs.microsoft.com/azure/security/fundamentals/data-encryption-best-practices)