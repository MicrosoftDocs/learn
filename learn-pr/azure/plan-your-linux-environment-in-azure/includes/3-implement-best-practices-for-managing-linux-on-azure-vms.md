To optimize the manageability of Azure Linux VMs, you must understand the interaction between the Azure platform and the VM OS. This interaction is particularly significant during VM provisioning.

## Platform-supported management agents

*VM provisioning* is the process of creating the Azure VM configuration parameter values, such as hostname, username, and password, that are available to the OS during the startup or *boot* process. A provisioning agent consumes these values, configures the OS, and reports the results when completed.

Azure supports *cloud-init provisioning agents* and *Azure Linux Agent (WALA)*.

- **Cloud-init provisioning agents** are a widely-used approach to customizing Linux during an initial boot. You can use cloud-init to install packages and write files, or to configure users and security. Because cloud-init is called during the initial boot process, you don't need any more steps or required agents to apply the configuration. For more information, see the [Cloud-init documentation](https://cloudinit.readthedocs.io/latest).

  >[!NOTE]
  >Microsoft is enhancing the VM configuration process to use cloud-init instead of the Linux Agent. Existing cloud-init customers can use their current cloud-init scripts, and new customers can use rich cloud-init configuration functionality.

- **WALA**. WALA is an Azure platform-specific agent you can use to provision and configure Azure VMs. You can also use WALA to implement support for Azure extensions.

## Boot diagnostics and serial console

To optimize managing and troubleshooting the boot process, you can enable boot diagnostics and use the serial console.

### Enable boot diagnostics

Boot diagnostics help you analyze boot failures by collecting serial log information and screenshots. You can enable boot diagnostics during or after VM creation. To expedite the provisioning process, select the managed storage account option to store the boot diagnostics data.

### Use the Azure VM serial console

You can use Azure VM serial console access for troubleshooting boot failures. Serial console provides a text-based console over the Linux VM's `ttyS0` serial port. This access is independent of network connectivity or OS state. Azure users with at least **Contributor**-level permissions can access the serial console by using the Azure portal or Azure CLI. You must enable boot diagnostics to use the serial console.

The serial console can help you restore a VM to an operational state in situations like the following scenarios:

- Broken file system table `fstab` files
- Misconfigured firewall rules
- File system corruption
- SSH configuration issues
- Common bootloader issues:

  - **Increase the timeout value in the grub menu on Gen2 Azure VMs**. Because legacy hardware has been removed from emulation in generation 2 VMs, the grub menu countdown timer counts down too quickly to display real-time loading of the default entry. To address this issue, replace the default entry `"timeout=5"` with `"timeout=100000"` in */boot/grub/grub.conf*, */etc/default/grub*, or their equivalent.

  - **Reserve more memory for kdump**. If the dump capture kernel ends up with a panic on boot, you should reserve more memory for the kernel. For example, when using Ubuntu, in the grub configuration file, change the parameter `crashkernel=384M-:128M` to `crashkernel=384M-:256M`.
