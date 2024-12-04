The operating system and data virtual disk .vhd files of Azure Virtual Machines reside in an Azure Storage account as blobs. Storage accounts provide the persistent store for virtual machine disks in Azure.

These .vhd files in Azure Storage represent one of two object types—**images or disks**.

- An **image** is a generalized copy of an operating system, which allows you to create any number of virtual machines, each with its own unique characteristics. Images serve as templates from which you provision disks for Azure Virtual Machines during their deployment. There are various ready-to-use images available from the Azure Marketplace. You can create your own images either by uploading .vhd files from your on-premises environment and registering them as images, or by creating them from existing Azure Virtual Machines.
- A **disk** object is either a non-generalized operating system disk or a data disk. You can use a copy of an operating system disk to create an exact replica of an individual virtual machine. You can also attach a data disk to an existing Azure Virtual Machine to access its content.

Azure Virtual Machines support three types of disks:

## Operating system disks

- One per virtual machine
- Maximum size of 2 TB
- Labeled as drive C on Windows virtual machines and mounted as /dev/sda1 on Linux virtual machines
- Appears to the operating system in the virtual machine as a Serial Advanced Technology Attachment (SATA) drive
- Contains the operating system

## Temporary disks

- One per virtual machine
- The size depends on the virtual machine size
- Labeled as drive D on Windows virtual machines or mounted as /mnt/resource on Linux virtual machines (/mnt with Ubuntu)
- Provides temporary, non-persistent storage (hosting, by default, the paging file).
- The content of the temporary disk is lost if the Hyper-V server hosting an Azure Virtual Machine changes. This can happen as a side effect of several events, including resizing the Azure Virtual Machine, temporarily stopping and deallocating the Azure Virtual Machine, or Hyper-V server failure.
- On most virtual machine SKUs, it uses SSD storage

## Data disks

- Virtual machine size determines the maximum number of data disks you can attach to the virtual machine
- Maximum size of 32 TB
- You can assign any available drive letter starting with F (on Windows virtual machines) or mount it via a custom mount point on Linux virtual machines
- Appears to the operating system in the virtual machine as a small computer system interface (SCSI) drive
- Provides persistent storage for applications and data

> [!NOTE]
> Operating system and data disks are implemented as page blobs in Azure Storage. The temporary disk is implemented as local storage on the Hyper-V host where the virtual machine is running.
