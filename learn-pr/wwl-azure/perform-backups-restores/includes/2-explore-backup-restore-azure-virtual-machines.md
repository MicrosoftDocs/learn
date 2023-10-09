In order to back up Azure VMs, Azure Backup installs an extension on the VM agent running on the machine. If your VM was created from an Azure Marketplace image, the agent will be running. In some cases, for example, if you create a custom VM, or you migrate a machine from on-premises. you might need to install the agent manually. If you do need to install the VM agent manually, use the following OS-specific instructions:

- [Azure Virtual Machine Agent overview (Windows)](/azure/virtual-machines/extensions/agent-windows)
- [Understanding and using the Azure Linux Agent](/azure/virtual-machines/extensions/agent-linux)

After the agent is installed, when you enable backup, Azure Backup installs the backup extension. It also updates and patches the extension without user intervention.

You can back up Azure VMs using the methods:

- **Single Azure VM**: directly from the VM settings in the Azure portal. For details, refer to [Back up an Azure VM from the VM settings](/azure/backup/backup-azure-vms-first-look-arm)
- **Multiple Azure VMs**: You can set up a Recovery Services vault and configure backup for multiple Azure VMs. For details, refer to [Back up Azure VMs in a Recovery Services vault](/azure/backup/backup-azure-arm-vms-prepare)
