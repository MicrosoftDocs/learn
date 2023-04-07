To optimize the manageability of Linux on Azure VMs, you must understand the interaction between the Azure platform and the VM OS. This interaction is particularly significant during VM provisioning.

## Assess the platform-supported management options

_VM provisioning_ is the process in which the platform creates the Azure VM configuration parameter values (such as hostname, username, and password) that are available to the OS during the boot process. A provisioning agent consumes these values, configures the OS, and then reports the results when completed. Azure supports cloud-init provisioning agents and Azure Linux Agent (WALA):

- **Cloud-init provisioning agent**. The cloud-init agent is a widely used approach to customizing Linux during an initial boot. You can use cloud-init to install packages and write files, or to configure users and security. Because cloud-init is called during the initial boot process, you don’t need any additional steps or required agents to apply your configuration.

- [!NOTE] For more information on how to properly format your #cloud-config files or other inputs, refer to the [cloud-init documentation](https://cloudinit.readthedocs.io/en/latest/topics/format.html) site. 

- **WALA**. WALA is an Azure platform-specific agent you can use to provision and configure Azure VMs. You can also use it to implement support for Azure extensions. Microsoft is currently enhancing the task of configuring VMs to use cloud-init instead of the Linux Agent. This work will enable existing cloud-init customers to use their current cloud-init scripts, and new customers to leverage the rich cloud-init configuration functionality. 

### Optimize the management and troubleshooting boot process

To optimize management and troubleshooting of the boot process, you must take into account several considerations. These considerations require you to perform the following tasks:

- **Enable boot diagnostics when provisioning an Azure VM**. Boot diagnostics help you analyze boot failures by collecting serial log information and screenshots. To expedite the Azure VM provisioning process, select the managed storage account option to store the boot diagnostics data.

- **Leverage the Azure VM serial console access for troubleshooting boot failures**. The Azure VM serial console provides access to a text-based console over the Azure VM's ttys0 serial port. This is independent of network connectivity or OS state. Users with Contributor-level permissions or higher can access the serial console by using the Azure portal or Azure Command-Line Interface (Azure CLI). To use the serial console functionality, you must first enable boot diagnostics. 

There are many scenarios in which the serial console can help you restore an Azure VM running Linux to an operational state. The most common ones include:

- Broken file system table (fstab) files
- Misconfigured firewall rules
- File system corruption
- SSH configuration issues
- Interaction with bootloader

- **Increase the timeout value in the** **grub** **menu** **on** **generation 2 Azure VMs**. Because legacy hardware has been removed from emulation in generation 2 VMs, the grub menu countdown timer counts down too quickly for the grub menu to display real-time loading of the default entry. To address this issue, replace the default entry "**timeout=5**" with "**timeout=100000**" in **/boot/grub/grub.conf,/etc/default/grub**, or their equivalent.

- **Reserve more memory for** **kdump**. Just in case the dump capture kernel ends up with a panic on boot, you should reserve more memory for the kernel. For example, when using Ubuntu, in grub configuration file, change the parameter **crashkernel=384M-:128M** to **crashkernel=384M-:256M**.
