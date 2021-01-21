As a Contoso Hyper-V administrator, you'll need to understand the various configuration settings that are available. You'll need to know how to implement them and how to make decisions concerning various settings, options, and requirements.

## VM settings

In the Hyper-V Manager, the VM settings are grouped into two main sections: Hardware and Management. The configuration files that store hardware and management information are separated into two formats: .vmcx and .vmrs. The .vmcx format is used for configuring VMs, and the .vmrs format is used for runtime data. These are binary files which are not editable manually. Management tools such as Hyper-V Manager and Windows PowerShell are used to read and edit the files.

> [!NOTE]
> In configuration version 5.0, .xml was the file format for the configuration files that store hardware and management information.

### Hardware

VMs use simulated hardware. Hyper-V uses this virtual hardware to mediate access to actual hardware. Depending on the scenario, you might not need to use all available simulated hardware.

#### Generation 1 hardware

By default, Generation 1 VMs have the hardware listed in the following table.

|Hardware|Description|
|||
|BIOS|Virtual hardware simulates a computer's BIOS. For example, you can configure a VM to switch Num Lock on or off. You can choose the startup order for a VM's virtual hardware. You can start a VM from a DVD drive, an integrated drive electronics (IDE) device, a legacy network adapter, or a floppy disk.|
|Memory|You can allocate memory resources to a VM. An individual VM can allocate as much as 1 TB of memory. You can also configure Dynamic Memory, which automatically changes a VM's available memory within a range that you define.|
|Processor|You can allocate processor resources to a VM. You can allocate up to 64 virtual processors to a single VM.|
|Non-Uniform Memory Access (NUMA)|NUMA helps multiprocessor VMs scale better by grouping processor and memory into nodes, which you can group into sockets. Aligning the nodes and sockets of a VM to the hardware topology helps improve the performance of NUMA-aware workloads.|
|IDE controller|A VM can support only two IDE controllers. By default, the two IDE controllers allocated to a VM are IDE controller 0 and IDE controller 1. Each IDE controller can support two devices. You can connect virtual hard disks (VHDs) or virtual DVD drives to an IDE controller. If booting from a hard disk drive or DVD-ROM, the boot device must be connected to an IDE controller. IDE controllers are the only way to connect VHDs and DVD-ROMs to VMs that use operating systems that don't support integration services.|
|SCSI controller|You can use SCSI controllers only on VMs that you deploy with operating systems that support integration services. SCSI controllers enable supporting up to 256 disks by using four controllers with a maximum of 64 connected disks each. You can add and remove virtual SCSI disks while a VM is running.|
|Network adapter|Hyper-V–specific network adapters represent virtualized network adapters. You can only use network adapters with supported VM guest operating systems that support integration services.|
|COM port|A COM port enables connections to a simulated serial port on a VM.|
|Diskette drive|You can map a .vfd floppy disk file to a virtual floppy drive.|

> [!IMPORTANT]
> Virtual NUMA and Dynamic Memory features can't be used at the same time; enabling one, disables the other.

#### Generation 2 hardware

Generation 2 VMs have the following hardware by default.

|Hardware|Description|
|||
|Firmware|UEFI allows all the features of the BIOS in generation 1 VMs. However, it also allows Secure Boot, which is enabled by default.|
|Memory|Same as generation 1 VMs.|
|Processor|Same as generation 1 VMs.|
|SCSI controller|Generation 2 VMs can use a SCSI controller for a boot device.|
|Network adapter|Generation 2 VMs support hot add/removal of virtual network adapters.|

You can add the following hardware to a VM by editing the properties of the VM and then selecting **Add Hardware**.

|Hardware|Description|
|||
|SCSI controller|You can add up to four virtual SCSI devices. Each controller supports up to 64 disks.|
|Network adapter|A single VM can have a maximum of eight Hyper-V–specific network adapters.|
|Fibre Channel adapter|This adapter allows a VM to connect directly to a Fibre Channel SAN. For this adapter, the Hyper-V host should have a Fibre Channel HBA that also has a Windows Server driver that supports virtual Fibre Channels.|

### Management

Use management settings to configure how a VM behaves on a Hyper-V host. The VM management settings in the following table are configurable.

|VM Management Setting|Use|
|||
|Name|Use this setting to configure the display name of the VM on a Hyper-V host. Doing this doesn't alter the actual VM's computer name.|
|Integration Services|Determine how a VM communicates with the host with settings for various components such as Heartbeat, Time synchronization and more. Use this setting to configure which VM integration settings are enabled and available in a VM.|
|Checkpoints|Checkpoints allow you to save a VM's state at a specific point in time, which you can later restore. Use this setting to enable or disable checkpoints, specify the type of checkpoint that will be created and also a location for where the configuration and checkpoint saved state files should be stored.|
|Smart Paging File Location|Smart Paging is used to assist with VM start up. It allows the allocation of additional memory during startup time to ensure a VM starts smoothly, where the minimum memory assigned is less than what is required during startup. You can configure the location where the Smart Paging files are stored for a VM.|
|Automatic Start Action|Use this setting to manage how a VM responds when a Hyper-V host turns on.|
|Automatic Stop Action|Use this setting to manage how a VM responds when a Hyper-V host shuts down gracefully.|

It's also possible to monitor resource usage for VMs that are running on Hyper-V hosts by using Windows PowerShell cmdlets. Use the `Enable-VMResourceMetering` cmdlet followed by the `Measure-VM` cmdlet to determine a specific VM's resource usage data for CPU, memory, storage, and networking. This process of tracking resource usage to an identified owner is known as resource metering.

> [!TIP]
> If you use checkpoints before an update is applied to a system, or before new software is installed, you could revert the VM to a previous state if needed.

## Demonstration

The following video demonstrates how to:

- Create a Hyper-V virtual switch.
- Create a virtual hard disk.
- Create a VM.
- Manage a VM by using Windows Admin Center.

The main steps in the process are:

1. Create a Hyper-V private virtual switch by using Hyper-V Manager.
1. Create a virtual hard disk differencing drive by using Hyper-V Manager.
1. Create a generation 1 VM with dynamic memory enabled by using Hyper-V Manager.
1. Manage the VMs by using Windows Admin Center.

>[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MC7i]