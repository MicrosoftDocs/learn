Just like any other computer, virtual machines in Azure use disks as storage for operating systems, applications, and data. These disks are called managed disks.

Suppose you have created a virtual machine (VM) in Azure, which hosts the database of case histories that your law firm relies on. A well-designed disk configuration is fundamental to good performance and resilience for SQL Server.

In this unit, you learn how to choose the right configuration values for your disks and how to attach those disks to a VM.

## How VMs use disks

There are three main disk roles in Azure: the data disk, the OS disk, and the temporary disk. These roles map to disks that are attached to your virtual machine.

- **OS Disk**. Every VM includes one disk that stores the operating system. This drive is registered as a SATA drive and labeled as the C: drive in Windows or mounted at "/" in Unix-like operating systems. This disk has a maximum capacity of 4,095 GiB, however, many operating systems are partitioned with [master boot record (MBR)](https://wikipedia.org/wiki/Master_boot_record) by default. MBR limits the usable size to 2 TiB. If you need more than 2 TiB, create and attach data disks and use them for data storage. If you need to store data on the OS disk and require the extra space, [convert it to GUID Partition Table](/windows-server/storage/disk-management/change-an-mbr-disk-into-a-gpt-disk) (GPT). To learn about the differences between MBR and GPT on Windows deployments, see [Windows and GPT FAQ](/windows-hardware/manufacture/desktop/windows-and-gpt-faq).
- **Data storage**. A data disk is a managed disk that's attached to a virtual machine to store application data, or other data you need to persist across reboots. Some VM images include data disks by default. You can also add more data disks up to the maximum number specified by the VM's size. Each data disk is registered as a SCSI drive and has a max capacity of 32,767 GiB. You can choose drive letters or mount points for your data drives.
- **Temporary storage**. Most VMs contain a temporary disk, which isn't a managed disk. The temporary disk provides short-term storage for applications and processes, and is intended to only store data such as page files, swap files, or SQL Server tempdb. Data on this drive may be lost during a maintenance event or redeployment. The drive is labeled as D: on a Windows VM by default. Don't use this drive to store important data that you don't want to lose.

## Attach data disks to VMs

You can add data disks to a virtual machine at any time by attaching them to the VM. Attaching a disk associates the disk with the VM.

You can't delete a disk while it's attached to a VM.

### Attach an existing data disk to an Azure VM

You may already have a VHD that stores the data you want to use in your Azure VM. In our law firm scenario, for example, perhaps you've already converted your physical disks to VHDs locally. In this case, you can upload your VHD directly to a managed disk. The recommended way to do this is to use the PowerShell `Add-AzVhd` cmdlet. This cmdlet is optimized for transferring VHD files, and may complete the upload faster than other methods. The transfer is completed by using multiple threads for best performance. Once the VHD has been uploaded, attach it to an existing VM as a data disk. This approach an excellent way to deploy data of all types to Azure VMs. The data is automatically present in the VM, and there's no need to partition or format the new disk.

### Attach a new data disk to an Azure VM

You can use the Azure portal to add a new, empty data disk to a VM.

This process creates a **.vhd** file as a page blob in the storage account that you specify, and attach that .vhd file as a data disk to the VM.

Before you can use the new VHD to store data, you have to initialize, partition, and format the new disk. We'll practice these steps in the next exercise.

In physical on-premises servers, you store data on physical hard disks. You store data in an Azure virtual machine (VM) on virtual hard disks (VHDs). These VHDs are stored as page blobs in Azure storage accounts. For example, when you migrate your law firm's database of case histories to Azure, you must create VHDs where the database files will be saved.
