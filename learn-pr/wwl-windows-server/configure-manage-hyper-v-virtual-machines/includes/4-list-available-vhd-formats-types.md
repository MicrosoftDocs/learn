As a new Hyper-V administrator planning the migration of VMs to new hosts, you need to understand the various formats and types available for virtual hard disks (VHDs) to ensure you can achieve the best performance.

A *VHD* is a file format that represents a traditional hard disk drive that VMs use for storage. You can configure a VHD with partitions, files, and folders.

You can create and manage VHDs by using:

- The Hyper-V Manager console.
- The Disk Management console.
- The `Diskpart` command-line tool.
- The `New-VHD` Windows PowerShell cmdlet.
- The Windows Admin Center console.

## VHD formats

When you create a new VHD, choose between the following formats:

- VHD. Select VHD if you need to support:
  - Virtual disks up to 2,040 GB in size.
  - Older Hyper-V versions.

- VHDX. Select VHDX to:
  - Support virtual disks up to 64 TB in size.
  - Minimize corruption issues. The VHDX file structure helps minimize corruption issues if a host server suffers from an unexpected power outage.
  - Support larger block sizes for dynamically expanding virtual hard disks and differencing virtual hard disks. This provides increased performance.
  - Extend or shrink the disk size while the VM is running if the VHDX disk is connected to an SCSI controller.

- VHD SET. The VHD SET:
  - Is used for shared VHDs only.
  - Enables backup of VM groups that use shared VHDs.
  - Isn't supported in operating systems that are earlier than Windows 10.

You can convert between VHDX and VHD formats by using Hyper-V Manager's Edit Virtual Hard Disk Wizard, or by using the `Convert-VHD` Windows PowerShell cmdlet. When you do so, a new VHD is created and the contents of the existing VHD are copied into it. You can't convert the VHD Set VHD format.

> [!CAUTION]
> Before you begin, ensure that you have sufficient disk space to perform the conversion.

> [!NOTE]
> Generation 1 VMs support the use the use of VHD or VHDX formats, whereas Generation 2 VMs only support VHDX format VHDs.

## VHD types

Hyper-V supports multiple VHD types as listed in the following table. They each have varying benefits and drawbacks, so the type of hard disk you select will vary depending on your needs.

|VHD type|Details|
|---|---|
|Fixed size|This type of VHD allocates all of the space immediately. This minimizes fragmentation, which in turn enhances performance.|
|Dynamically expanding|When you create a dynamically expanding VHD, you specify a maximum size for the file. The disk itself only uses the amount of space that needs to be allocated, and it grows as necessary. This type of disk provides better use of physical storage space and only uses space as needed.|
|Differencing|This type of disk involves a parent-child relationship. A differencing disk is linked to a parent disk that contains a base installation and configuration. Any changes made, are done to the differencing disk, and thus results in no change to the parent disk. Differencing disks are typically used to reduce data storage requirements for child disks that might use the same parent configuration. For example, you might have 10 differencing disks based on the same parent disk that contains a *sysprepped* image of Windows Server 2019. You then could use the 10 differencing disks to create 10 different VMs.|

> [!NOTE]
> You can use the Edit Virtual Hard Disk Wizard to convert between disk types. Ensure that the target disk format is the same as the source disk format.

> [!TIP]
> Both VHD and VHDX disk types can be mounted using the Disk Management console, the `Diskpart` command-line tool, or Windows PowerShell. The disks' contents can be accessed from outside of the VM. This can be a security risk that you might need to address; however, it can be a useful troubleshooting option in certain situations.

### Use physical hard disks

A VM can use a physical hard disk attached to the host computer rather than using a VHD. Also known as a *pass-through disk*, you can use this type of hard disk configuration to connect directly to an Internet SCSI (iSCSI) LUN or a physical disk attached on the host machine.

When you use pass-through disks, the VM must have exclusive access to the target disk. To use pass-through disks, you must use the host’s Disk Management console to take the disk offline. After the disk is offline, you can connect it to one of the VM's disk controllers.

You can attach a pass-through disk to a VM by performing the following steps:

1. Ensure that the target hard disk is offline.
1. Use **Hyper-V Manager** to edit the existing VM's properties.
1. Select an integrated drive electronics (IDE) or SCSI controller, select **Add**, and then select **Hard Drive**.
1. On the **Hard Drive** page, select **Physical hard disk**, and then in the drop-down list, select the disk that you want to use as the pass-through disk.
