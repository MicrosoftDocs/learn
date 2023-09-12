The operating system and data virtual disk .vhd files of Azure VMs reside in an Azure Storage account as blobs. Storage accounts provide the persistent store for virtual machine disks in Azure.

These .vhd files in Azure Storage represent one of two object types—**images or disks**.

- An **image** is a generalized copy of an operating system, which allows you to create any number of VMs, each with its own unique characteristics. Images serve as templates from which you provision disks for Azure VMs during their deployment. There are various ready-to-use images available from the Azure Marketplace. You can create your own images either by uploading .vhd files from your on-premises environment and registering them as images, or by creating them from existing Azure VMs.
- A **disk** object is either a non-generalized operating system disk or a data disk. You can use a copy of an operating system disk to create an exact replica of an individual VM. You can also attach a data disk to an existing Azure VM to access its content.

Azure VMs support three types of disks:

## Operating system disks

- One per VM
- Maximum size of 2 TB
- Labeled as drive C on Windows VMs and mounted as /dev/sda1 on Linux VMs
- Appears to the operating system in the VM as a Serial Advanced Technology Attachment (SATA) drive
- Contains the operating system

## Temporary disks

- One per VM
- The size depends on the VM size
- Labeled as drive D on Windows VMs or mounted as /mnt/resource on Linux VMs (/mnt in case of Ubuntu)
- Provides temporary, nonpersistent storage (hosting, by default, the paging file).
- The content of the temporary disk is lost if the Hyper-V server hosting an Azure VM changes. This can happen as a side effect of several events, including resizing the Azure VM, temporarily stopping and deallocating the Azure VM, or Hyper-V server failure.
- On most VM SKUs, it uses SSD storage

## Data disks

- VM size determines the maximum number of data disks you can attach to the VM
- Maximum size of 32 TB
- You can assign any available drive letter starting with F (on Windows VMs) or mount it via a custom mount point on Linux VMs
- Appears to the operating system in the VM as a small computer system interface (SCSI) drive
- Provides persistent storage for applications and data

> [!NOTE]
> Operating system and data disks are implemented as page blobs in Azure Storage. The temporary disk is implemented as local storage on the Hyper-V host where the VM is running.
