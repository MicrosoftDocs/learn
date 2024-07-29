In order to back up Azure Virtual Machines, Azure Backup installs an extension on the virtual machine agent running on the machine. If your virtual machine was created from an Azure Marketplace image, the agent will be running. In some cases, for example, if you create a custom virtual machine, or you migrate a machine from on-premises. you might need to install the agent manually. If you do need to install the virtual machine agent manually, use the following OS-specific instructions:

- [Azure Virtual Machine Agent overview (Windows)](/azure/virtual-machines/extensions/agent-windows)
- [Understanding and using the Azure Linux Agent](/azure/virtual-machines/extensions/agent-linux)

After the agent is installed, when you enable backup, Azure Backup installs the backup extension. It also updates and patches the extension without user intervention.

You can back up Azure Virtual Machines using the methods:

- **Single Azure Virtual Machine**: directly from the virtual machine settings in the Azure portal. For details, refer to [Back up an Azure Virtual Machine from the virtual machine settings](/azure/backup/backup-azure-vms-first-look-arm)
- **Multiple Azure Virtual Machines**: You can set up a Recovery Services vault and configure backup for multiple Azure Virtual Machines. For details, refer to [Back up Azure Virtual Machines in a Recovery Services vault](/azure/backup/backup-azure-arm-vms-prepare)
