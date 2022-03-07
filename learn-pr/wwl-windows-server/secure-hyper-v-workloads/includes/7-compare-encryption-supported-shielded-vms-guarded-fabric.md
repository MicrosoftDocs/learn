To plan and configure the security of the Contoso infrastructure effectively, you should understand the differences between the types of VMs that are supported by a Hyper-V guarded fabric.

## Guarded fabric-supported VM types

In Hyper-V, guarded fabrics can run VMs in the following ways:

- Standard VM. A *standard VM* is a normal VM that doesn't offer additional protection other than the standard protections provided by Hyper-V.
- Encryption-supported VM. An *encryption-supported VM* is a VM with additional protections that can be configured by a fabric admin.
- Shielded VM. A *shielded VM* is a VM with all protections enabled. These protections can't be disabled by a fabric admin.

> [!NOTE]
> Both encryption-supported VMs and shielded VMs support Live Migration and Hyper-V Replica between guarded fabric Hyper-V hosts.

### Encryption-supported VMs

Encryption-supported VMs are intended for use where the fabric administrators are fully trusted members of an organizational enterprise. For example, an enterprise might deploy a guarded fabric to ensure that VM disks are encrypted at-rest for compliance purposes. Fabric administrators can continue to use the management features that Hyper-V provides, such as VM console connections, VMConnect, PowerShell Direct, and other fabric management and troubleshooting tools.

### Shielded VMs

Shielded VMs are intended for use in fabrics where the data and state of the VM must be protected from both malicious fabric administrators and software that might be running on the Hyper-V hosts.

### Encryption-supported VMs compared to shielded VMs

The following table summarizes the differences and similarities between encryption-supported VM and shielded VM capabilities.

|Capability|Encryption-supported VMs|Shielded VMs|Description of the capability|
|--|--|--|--|
|Secure Boot|Yes, required but configurable|Yes, required, and enforced|*Secure Boot* verifies that the boot loader is signed by a trusted authority in the UEFI database to help prevent unauthorized firmware, operating systems, or UEFI drivers from running when the VM starts up.|
|Virtual TPM|Yes, required but configurable|Yes, required, and enforced|*Virtual TPM* emulates the signature of physical TPM hardware chip to allow a VM to use encryption.|
|Encrypt VM state and live migration traffic|Yes, required but configurable|Yes, required, and enforced|A VM's saved state file is encrypted at rest, and in transit when you live migrate a VM to another host.|
|Integration components|Configurable by fabric admin|Certain integration components blocked, for example data exchange; also known as *Key-Value pair exchange*|*Integration components* are sets of drivers and services that provide Hyper-V VMs with synthetic devices to improve their performance and help them to maintain a more consistent state.|
|VMConnect, human interface devices (keyboard, mouse)|On, can't be disabled|Enabled on hosts beginning with Windows Server version 1803; disabled on earlier hosts|*VMConnect* is a console tool for interacting with a VM's guest OS remotely.|
|COM ports|Supported|Disabled (can't be enabled)|A *COM port* provides an interface for serial communications. COM ports aren't visible by Generation 2 VMs, which are required for encryption-supported and shielded VMs, by default. If COM ports are needed on Gen 2 VMs, you must configure them by using Windows PowerShell.|
|Attach a debugger to the VM process|Supported|Disabled (can't be enabled)|You can connect tools called *debuggers* that can analyze the processes running in a VM for errors.|

> [!IMPORTANT]
> When you consider attaching a debugger to the VM process, please note:
> - Traditional debuggers that attach directly to a process, such as `WinDbg.exe`, are blocked for shielded VMs because the VM's worker process (`VMWP.exe`) is a protected process light (PPL).
> - Alternative debugging techniques, such as those used by `LiveKd.exe`, aren't blocked.

> [!NOTE]
> Unlike shielded VMs, the worker process for encryption-supported VMs doesn't run as a PPL. As a result, traditional debuggers, like WinDbg.exe, will continue to function normally in an encryption-supported VM.
