## Compute

Azure provides the ability to change the size of your virtual machine based on the required CPU, network, or disk performance. Resizing is important for temporary performance needs like upgrades and migrations.

After you create a virtual machine, you can scale the virtual machine up or down by changing the virtual machine size. Resizing a virtual machine might require deallocating it first if the new size isn't available on the hardware cluster that's currently hosting the virtual machine. Similarly, when resizing virtual machines in the same availability set, if the new size for a virtual machine in an availability set isn't available on the hardware cluster currently hosting the virtual machine, then all virtual machines in the availability set needs to be deallocated to resize the virtual machine. You also might need to update the size of other virtual machines in the availability set after one virtual machine is resized.

Resizing of Azure Virtual Machines can be performed from the Azure portal, via PowerShell, Azure CLI, Azure Resource Manager templates, or programmatically (including REST API).

Key considerations for resizing include:

- The Azure region might not contain the hardware requirements to support the desired sizes
- Resizing without the need to restart the virtual machine depending on the current hardware cluster
- New virtual machine support or Premium Storage
- Updating the virtual machine in an availability set

## Storage

As explained earlier, the size of the virtual machine controls how many data disks you can attach. Attaching disks is an online operation. You can detach a data disk without stopping the Azure Virtual Machine by using PowerShell or Azure CLI, but you should first make sure that the disk isn't being used. For details, refer to:

- [How to detach a data disk from a Windows virtual machine](/azure/virtual-machines/windows/detach-disk)
- [How to detach a data disk from a Linux virtual machine](/azure/virtual-machines/linux/detach-disk)

You also have the option of expanding attached Azure Virtual Machine disks. For details, refer to:

- [How to expand virtual hard disks attached to a Windows virtual machine](/azure/virtual-machines/windows/expand-os-disk)
- [Expand virtual hard disks on a Linux virtual machine with the Azure CLI](/azure/virtual-machines/linux/expand-disks)
