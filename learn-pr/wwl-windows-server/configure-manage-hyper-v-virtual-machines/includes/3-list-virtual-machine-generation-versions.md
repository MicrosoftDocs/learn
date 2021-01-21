As Contoso migrates its workloads, you must determine the different VM generation versions that exist in your organization and what Hyper-V functionality you want to utilize. Your organization might need to run different VM generation versions to use specific features, so it's important to understand and identify the existing generation versions and future required functionality so you can determine requirements for your VM deployments.

When you create a new VM, one of the options presented is whether to create a Generation 1 or Generation 2 VM.

## Generation 1 VMs

When you create a Generation 1 VM, the following features are supported:

|Feature|Description|
|||
|Guest operating systems|Generation 1 VMs support both 32-bit and 64-bit Windows versions. Generation 1 also supports CentOS/Red Hat Linux, Debian, FreeBSD, Oracle Linux, SUSE Linux, and Ubuntu guest operating systems.|
|VM boot|Generation 1 VMs can boot from a virtual floppy disk (.VFD), integrated drive electronics (IDE) Controller VHD, IDE Controller virtual DVD, or PXE boot by using a legacy network adapter. Generation 1 boot volumes only support a maximum of 2 TB with four partitions.|
|Boot Volume|For Generation 1 virtual machines, the maximum boot volume is 2TB for a .vhdx and 2040GB for a .vhd| 
|Firmware support|Legacy BIOS.|

## Generation 2 VMs

When you create a Generation 2 VM, the following features are supported:

|Feature|Description|
|||
|Guest operating systems|Generation 2 VMs support only 64-bit Windows versions (excluding Windows Server 2008 and Windows 7). Generation 2 also supports current versions of CentOS/Red Hat Linux, Debian, Oracle Linux, SUSE Linux, and Ubuntu guest operating systems.|
|VM boot|Generation 2 VMs can only boot from a SCSI Controller VHD, SCSI Controller virtual DVD, or PXE boot by using a standard network adapter.|
|Secure Boot|Generation 2 VMs support Secure Boot and Secure Boot is enabled by default in Generation 2 VMs. This feature verifies that the boot loader is signed by a trusted authority in the Unified Extensible Firmware Interface (UEFI) database. It can prevent unauthorized firmware, operating systems, or UEFI drivers from running at boot time.|
|Shielded virtual machines|Generation 2 VMs support shielded VMs.|
|Boot volume.|Generation 2 VMs provide larger boot volume support, up to a maximum boot volume size of 64 TB.|
|Firmware support|UEFI.|

> [!NOTE]
> Generation 2 VMs do not have a DVD drive by default, but you can add a DVD drive after you create the VM. Also, Generation 2 VMs don't support a virtual floppy disk controller.

> [!CAUTION]
> It's important to understand the impact and considerations of your generation selection, because you can't change the generation after you've created it.

> [!TIP]
> Don't use Generation 2 VMs on their own to achieve a performance gain. In the daily running of a VM, there's no performance difference between Generation 1 and Generation 2 VMs. You might notice a slight improvement in VM boot and installation times with Generation 2 VMs, but performance shouldn't be the main factor for using Generation 2 VMs.

## Demonstration

The following video demonstrates how to create a Generation 1 VM.

The main steps in the process are:

1. In Hyper-V Manager, in the New Virtual Machine Wizard, select **Generation 1**.
1. In Hyper-V Manager, on the **Summary** tab, note that **Generation 1** is listed in **Generation Details**.
1. Open a **Windows PowerShell** window and then run the following cmdlet:

    ```powershell
    get-vm | format-list name, state, Generation, status, cpuusage, memoryassigned, virtualmachinetype, virtualmachinesubtype, status, version
    ```

  1. Note that **Generation**, **VirtualMachinesubtype**, and **Version** details, along with the other VM property details, are listed.

> [!TIP]
> You can get a full list of property values available with  a Windows PowerShell cmdlet by using the pipe symbol `|` and the `get-member` cmdlet combined with the `get-vm` cmdlet. For example, use the cmdlet `get-vm | get-member` or `get-vm | gm`.

> [!IMPORTANT]
> When using the `New-VM` Windows Powershell cmdlet to create a new VM, Generation 2 VMs do not support Floppy, LegacyNetworkAdapter, or IDE. Using these values in a Windows PowerShell cmdlet causes an error.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MC7h]