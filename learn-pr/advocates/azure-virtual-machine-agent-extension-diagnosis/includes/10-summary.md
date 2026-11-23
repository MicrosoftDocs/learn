When the next guest operation fails, start with the last step you can prove succeeded. In this module, you separated power and provisioning state from guest health, chose diagnostic channels that still worked, and used evidence from the current operation to distinguish agent, handler, script, and monitoring failures.

At the next Contoso handover, “the report works over SSH” isn't enough to close the ticket. That was true before the repair. What changed is that the corrected extension command now returns the expected report and exits successfully on a new sequence. The independent SSH check shows the report still works outside the extension.

## More info

These official references describe the exact agent, channel, extension, and command behavior used in the module.

- [Troubleshoot Windows Server virtual machines in Azure](/training/modules/troubleshoot-windows-server-virtual-machines-azure/)
- [VM power states, provisioning states, and instance view](/azure/virtual-machines/states-billing)
- [Windows VM Agent troubleshooting](/troubleshoot/azure/virtual-machines/windows/windows-azure-guest-agent)
- [Windows event collection](/powershell/module/microsoft.powershell.diagnostics/get-winevent)
- [Convert DateTime evidence to UTC](/dotnet/api/system.datetime.touniversaltime)
- [Azure Linux VM Agent](/azure/virtual-machines/extensions/agent-linux)
- [Linux agent configuration reference](https://github.com/Azure/WALinuxAgent/blob/master/README.md)
- [Linux agent cloud-init wait behavior](https://github.com/Azure/WALinuxAgent/blob/bb053b4986456c791a20175f74c8c9e7da45ff7e/azurelinuxagent/ga/update.py)
- [VM OSProfile extension-operation control](/azure/templates/microsoft.compute/virtualmachines#osprofile)
- [Cloud-init provisioning and troubleshooting](/azure/virtual-machines/linux/using-cloud-init)
- [Azure platform IP address and connectivity tests](/azure/virtual-network/what-is-ip-address-168-63-129-16)
- [Troubleshoot the Azure Linux Agent](/troubleshoot/azure/virtual-machines/linux/linux-azure-guest-agent)
- [Linux extension prerequisites, networking, and common failures](/azure/virtual-machines/extensions/features-linux)
- [Ubuntu OpenBSD netcat command options](https://manpages.ubuntu.com/manpages/noble/man1/nc_openbsd.1.html)
- [Action Run Command for Linux](/azure/virtual-machines/linux/run-command)
- [Custom Script for Linux](/azure/virtual-machines/extensions/custom-script-linux)
- [Linux Custom Script command-execution implementation](https://github.com/Azure/custom-script-extension-linux/blob/master/main/exec.go)
- [Linux Custom Script execution-artifact cleanup](https://github.com/Azure/custom-script-extension-linux/blob/26e276cce16174206f9f5b6c35ac24871a670298/main/cmds.go)
- [Azure extension-platform cleanup utility](https://github.com/Azure/azure-extension-platform/blob/01812dfbde3d/pkg/utils/utils_linux.go)
- [Windows Custom Script execution context](/azure/virtual-machines/extensions/custom-script-windows)
- [Linux boot-error troubleshooting](/troubleshoot/azure/virtual-machines/linux/boot-error-troubleshoot-linux)
- [Serial Console for Linux](/troubleshoot/azure/virtual-machines/linux/serial-console-linux)
- [Serial Console for Windows](/troubleshoot/azure/virtual-machines/windows/serial-console-windows)
- [Azure CLI VM extension commands](/cli/azure/vm/extension?view=azure-cli-latest&preserve-view=true)
- [Azure CLI VM instance view](/cli/azure/vm?view=azure-cli-latest#az-vm-get-instance-view&preserve-view=true)
- [Understand Azure role-assignment scope](/azure/role-based-access-control/scope-overview)
- [Troubleshoot Linux boot issues caused by fstab errors](/troubleshoot/azure/virtual-machines/linux/linux-virtual-machine-cannot-start-fstab-errors)
