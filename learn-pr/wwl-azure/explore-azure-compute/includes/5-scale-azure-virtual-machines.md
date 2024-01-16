## Compute

Azure provides the ability to change the size of your virtual machine (VM) based on the required CPU, network, or disk performance. Resizing is important for temporary performance needs like upgrades and migrations.

After you create a VM, you can scale the VM up or down by changing the VM size. Resizing a VM might require deallocating it first if the new size isn't available on the hardware cluster that's currently hosting the VM. Similarly, when resizing VMs in the same availability set, if the new size for a VM in an availability set isn't available on the hardware cluster currently hosting the VM, then all VMs in the availability set needs to be deallocated to resize the VM. You also might need to update the size of other VMs in the availability set after one VM is resized.

Resizing of Azure VMs can be performed from the Azure portal, via PowerShell, Azure CLI, Azure Resource Manager templates, or programmatically (including REST API).

Key considerations for resizing include:

- The Azure region might not contain the hardware requirements to support the desired sizes
- Resizing without the need to restart the VM depending on the current hardware cluster
- New VM support or Premium Storage
- Updating the VM in an availability set

## Storage

As explained earlier, the size of the virtual machine controls how many data disks you can attach. Attaching disks is an online operation. You can detach a data disk without stopping the Azure VM by using PowerShell or Azure CLI, but you should first make sure that the disk isn't being used. For details, refer to:

- [How to detach a data disk from a Windows virtual machine](/azure/virtual-machines/windows/detach-disk)
- [How to detach a data disk from a Linux virtual machine](/azure/virtual-machines/linux/detach-disk)

You also have the option of expanding attached Azure VM disks. For details, refer to:

- [How to expand virtual hard disks attached to a Windows virtual machine](/azure/virtual-machines/windows/expand-os-disk)
- [Expand virtual hard disks on a Linux VM with the Azure CLI](/azure/virtual-machines/linux/expand-disks)
