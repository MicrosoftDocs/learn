To secure Azure VM disks, Azure provides Storage Service Encryption (SSE) and Azure Disk Encryption (ADE). These technologies work together to provide strong 256-bit encryption as part of a defense-in-depth approach for the protection of Azure VM disks. You must complete the ADE prerequisites to enable disk encryption. The ADE prerequisites configuration script can automate this process. When enabling encryption on new VMs, you can use an Azure Resource Manager template. Using a template ensures that your data is encrypted at the point of deployment, leaving no vulnerabilities.

<!-- Cleanup sandbox -->
[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Additional resources

- [Azure Disk Encryption scenarios on Linux VMs](/azure/virtual-machines/linux/disk-encryption-linux)
- [Overview of managed disk encryption options](/azure/virtual-machines/disk-encryption-overview)
- [Resource Manager templates on GitHub](https://github.com/Azure/azure-quickstart-templates)
- [Azure data security and encryption best practices](/azure/security/fundamentals/data-encryption-best-practices)