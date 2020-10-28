Just like any other computer, virtual machines in Azure use disks as a place to store an operating system, applications, and data. These disks are called virtual hard disks (VHDs).

Suppose you have created a virtual machine (VM) in Azure, which will host the database of case histories that your law firm relies on. A well-designed disk configuration is fundamental to good performance and resilience for SQL Server.

In this unit, you'll learn how to choose the right configuration values for your disks and how to attach those disks to a VM.

## How disks are used by VMs

VMs use disks for three different purposes:

- **Operating system storage**. Every VM includes one disk that stores the operating system. This drive is registered as a SATA drive and labeled as the C: drive in Windows and mounted at "/" in Unix-like operating systems. It has a maximum capacity of 4,095 gibibytes (GiB), and its content is taken from the VM image you used to create the VM.
- **Temporary storage**. Every VM includes a temporary VHD that is used for page and swap files. Data on this drive may be lost during a maintenance event or redeployment. The drive is labeled as D: on a Windows VM by default. Do not use this drive to store important data that you do not want to lose.
- **Data storage**. A data disk is any other disk attached to a VM. You use data disks to store files, databases, and any other data that you need to persist across reboots. Some VM images include data disks by default. You can also add additional data disks up to the maximum number specified by the size of the VM. Each data disk is registered as a SCSI drive and has a max capacity of 32,767 GiB. You can choose drive letters or mount points for your data drives.

## Storing VHD files

In Azure, VHDs are stored in an Azure storage account as **page blobs**.

This table shows the various kinds of storage accounts and which objects can be used with each.

|Storage account type|Services supported|Types of blobs supported|
|-----|-----|-----|-----|
|General-purpose standard| Azure Blob storage, Azure Files, Azure Queue storage | Block blobs, page blobs, and append blobs|
|General-purpose premium|Blob storage |Page blobs|
|Blob storage, hot and cool access tiers|Blob storage|Block blobs and append blobs|

Both general-purpose standard and premium storage support page blobs. Choose a standard storage account if cost is your primary concern. Premium storage will cost more, but will also deliver much higher I/O operations per second, or IOPS. If data performance is a requirement for your VM, consider using premium storage.

## Attach data disks to VMs

You can add data disks to a virtual machine at any time by attaching them to the VM. Attaching a disk associates the VHD file with the VM. 

The VHD can't be deleted from storage while it's attached.

### Attach an existing data disk to an Azure VM

You may already have a VHD that stores the data you want to use in your Azure VM. In our law firm scenario, for example, perhaps you've already converted your physical disks to VHDs locally. In this case, you can use the PowerShell `Add-AzVhd` cmdlet to upload it to the storage account. This cmdlet is optimized for transferring VHD files and may complete the upload faster than other methods. The transfer is completed by using multiple threads for best performance. Once the VHD has been uploaded, attach it to an existing VM as a data disk. This approach an excellent way to deploy data of all types to Azure VMs. The data is automatically present in the VM, and there's no need to partition or format the new disk.

### Attach a new data disk to an Azure VM

You can use the Azure portal to add a new, empty data disk to a VM. 

This process will create a **.vhd** file as a page blob in the storage account that you specify, and attach that .vhd file as a data disk to the VM.

Before you can use the new VHD to store data, you have to initialize, partition, and format the new disk. We'll practice these steps in the next exercise.

In physical on-premises servers, you store data on physical hard disks. You store data in an Azure virtual machine (VM) on virtual hard disks (VHDs). These VHDs are stored as page blobs in Azure storage accounts. For example, when you migrate your law firm's database of case histories to Azure, you must create VHDs where the database files will be saved.
